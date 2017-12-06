#!/usr/bin/perl
use strict;
use warnings;

sub do_call {
    callee();
}

sub callee {
    use Data::Dumper;
    my @caller = caller(0);
    my (undef, undef, undef, $func) = caller(1);
    print Dumper \@caller;
    print Dumper $func;
}

do_call();
