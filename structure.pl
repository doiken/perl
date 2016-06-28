#!/usr/bin/perl
use strict;
use warnings;

#map { print $_ . ":"; $_ => 1 } (1 => 1, 2 => 2);
#map { print $_ . ":"; $_ => 1 } (1, @{[3, 4]});

package reference_trial;
{
    my $hash_of_hashref = +{
        first  => +{},
        second => +{ key => 'value'}
    };
#    my $LOADED_COMPONENTS = +{
#        components               => +{},
#        component_by_xid         => +{},
#        rules_by_component       => +{},
#    };
    ## referenceの参照
    print $hash_of_hashref->{'second'} , "\n";
    print %{$hash_of_hashref->{'second'}} , "\n";
    print $hash_of_hashref->{'second'}->{key} , "\n";

    ## referenceへの代入
    @{$hash_of_hashref->{'first'}}{'key1'} = [1, 2, 3];
    print @{$hash_of_hashref->{first}->{key1}}, "\n";

}
package arrow_trial;
{
    sub args {
        my ($k, $v) = @_;

        print 1 < @_ ? +{@_} : $_[0], "\n";
        print 'Key: ' . $k, "\n";
        print 'Value: ' . $v, "\n";
    }

    args(1 => 2);

}
package constant_trial;
{
    use constant {
        HOME   => 'Home',
        WORK   => 'Work',
        MOBILE => 'Mobile',
    };

    print HOME . "\n";
    print HOME . "\n" if HOME eq 'Home';
    print constant_trial::HOME . "\n";
}

package hash_trial;
{
    ## サブルーチンの引数としてはカンマとアローで括弧を省略可能(引数の括弧が省略されている?)
    sub test {
        my %hash = @_;
        print %hash;
    }
    test(key1 => 1, key2 => 2);

    ## 変数に直接の際はエラー
    # my %hash_direct = key1 => 1, key2 => 2;
    # print %hash_direct;
}

