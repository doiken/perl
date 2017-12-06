#!/usr/bin/perl
use strict;
use warnings;
use Devel::Peek;

my $int = 1;
my $float = 1.5;
my $string = 'str';
my @arr = (10, 20, 30);
my %hash = (10 => 'a', 20 => 'b', 30 => 'c');
my $mix = 1;
$mix = 1.5;
$mix = 'str';

Dump $int;
Dump $float;
Dump $string;
Dump $mix;

Dump \@arr;
Dump \%hash;
