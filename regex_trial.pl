#!/usr/bin/perl
use strict;
use warnings;

# precompile: https://stackoverflow.com/questions/952998/is-there-a-way-to-precompile-a-regex-in-perl
my $pattern = qr//;

my ($foo, @bar) = (1, 2, 3);
use Data::Dumper;
print Dumper $foo;
print Dumper \@bar;
my ($hoge, $huga, $piyo) = (1, 2, 3);
print Dumper $hoge;
print Dumper $huga;
print Dumper $piyo;
