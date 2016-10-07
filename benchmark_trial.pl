#!/usr/bin/perl
use strict;
use warnings;

use Benchmark qw(:all) ;

sub sub_normal {
    1+1;
}

sub sub_normal_with_proto() {
    1+1;
}

cmpthese(100_000_000, {
    'sub_normal' => sub { sub_normal(); },
    'sub_normal_with_proto' => sub { sub_normal_with_proto(); },
    'sub_referende' => \&sub_normal,
    'sub_inline' => sub { 1+1; },
});

__END__;
/usr/bin/perl -Mlocal::lib=~/Documents/perl/local /Users/doi_kenji/Documents/perl/benchmark_trial.pl
            (warning: too few iterations for a reliable count)
            (warning: too few iterations for a reliable count)
                             Rate sub_normal sub_referende sub_normal_with_proto sub_inline
sub_normal              9718173/s         --          -94%                  -97%       -98%
sub_referende         153846154/s      1483%            --                  -58%       -62%
sub_normal_with_proto 370370370/s      3711%          141%                    --        -7%
sub_inline            400000000/s      4016%          160%                    8%         --

Process finished with exit code 0