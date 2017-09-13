#!/usr/bin/perl
use strict;
use warnings;

use Benchmark qw(:all) ;
use FoO;
my $foo = FoO->new;

my $hash = +{ map { $_ => $_ } (0 .. 50) };
cmpthese(1_000_000, {
    'bar' => sub { $foo->bar(1, 2, $hash); },
#    'baz' => sub { $foo->baz(1, 2, +{ map { $_ => $)} 0 .. 100 }; },
#    'bar(static)' => sub { FoO::bar(undef, 1, 2, +{ map { $_ => $)} 0 .. 100 }); },
    'baz(static)' => sub { FoO::baz undef, 1, 2, $hash; },
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