#!/usr/bin/perl
use strict;
use warnings;
use Memoize qw(memoize);

memoize('foo_ref');
memoize('foo_list');
sub foo_ref {
    print '---- ref called ----', "\n";
    return \@_;
}

sub foo_list {
    print '---- list called ----', "\n";
    return @_;
}

my $cache = {};
my $norm = sub {
    my ($key, $array_ref) = @_;
    print '---- norm called ---- ', "\n";
#    use Data::Dumper;
#    print Dumper $key;
    return $key;
};
memoize('array_ref', NORMALIZER => $norm, LIST_CACHE => 'MERGE');
sub array_ref {
    my ($key, $array_ref) = @_;
    print '---- array ref called ---- ', "\n";
    if ($array_ref) {
        for my $i (0 .. (scalar @$array_ref) - 1) {
            Internals::SvREADONLY($array_ref->[$i], 1);
#            $array_ref->[$i] = $array_ref->[$i]+1;
        }
        $cache->{$key} = $array_ref;
    }
#    use Data::Dumper;
#    print Dumper $cache;
    return $cache->{$key};
}

#use Data::Dumper;
#print Dumper foo_ref(1, [2, 3]); # ref called
#print Dumper foo_ref(1, [3]);    # ref called
#print Dumper foo_ref(1, [2, 3]); # ref called T_T: normalizerを定義する必要あり
#
#print Dumper scalar foo_list(1, 2, 3); # list called
#print Dumper foo_list(1, 2, 3);        # list called T_T: want_array()によってメモリ空間が分かれている

use Data::Dumper;
my $ref;
$ref = array_ref('foo', [1, 2]);
print Dumper $ref;
pop @$ref;
print Dumper $ref;
print Dumper array_ref('foo');
print Dumper $ref;
