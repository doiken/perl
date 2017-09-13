#!/usr/bin/env perl

package PROF_CLASS;

use namespace::autoclean;
use Mouse;

has 'hash' => (
    is => 'rw',
    isa => 'HashRef',
);

sub func_many_args {
    my $self = shift;
    my %hash = @_;
    return $hash{49} + $hash{50};
}
sub func_many_args_ref {
    my ($self, $hash) = @_;
    return $hash->{49} + $hash->{50};
}

sub func_prop {
    my ($self) = @_;
    return $self->hash->{49} + $self->hash->{50};
}

__PACKAGE__->meta->make_immutable;

package main;
use strict;
use warnings;

use lib './lib';

use Time::HiRes qw(gettimeofday tv_interval);

# NYTPROF=file=/tmp/nytprof/nytprof.out perl -d:NYTProf -I ~/Documents/perl/local/lib/perl5/darwin-thread-multi-2level prof_trial.pl

my $hash = +{ map { $_ => $_ } (0 .. 50) };

my $i;

$i = 0;

my $class = PROF_CLASS->new;
my $t0 = [gettimeofday];
$class->func_many_args(%$hash) while $i++ < 1_000_000;
my $elapsed = tv_interval($t0);
print 'func_many_args: ', int($elapsed * 1000), "ms", "\n";


$i = 0;
$t0 = [gettimeofday];
$class->func_many_args_ref($hash) while $i++ < 1_000_000;
$elapsed = tv_interval($t0);
print 'func_many_args_ref: ',  int($elapsed * 1000), "ms", "\n";

$i = 0;
$t0 = [gettimeofday];
while ($i++ < 1_000_000) {
    $class->hash($hash);
    $class->func_prop() ;
}
$elapsed = tv_interval($t0);
print 'func_prop: ',  int($elapsed * 1000), "ms", "\n";

# nytprof なし
# func_many_args: 7613ms
# func_many_args_ref: 404ms
# func_prop: 666ms

# nytprof あり
# func_many_args: 10273ms
# func_many_args_ref: 2634ms
# func_prop: 6655ms


