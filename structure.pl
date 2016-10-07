#!/usr/bin/perl
use strict;
use warnings;

#map { print $_ . ":"; $_ => 1 } (1 => 1, 2 => 2);
#map { print $_ . ":"; $_ => 1 } (1, @{[3, 4]});

package Arr {
    use Mouse;
    use namespace::autoclean;
    has list => (
        is      => 'ro',
        isa     => 'ArrayRef[Num]',
    );
    __PACKAGE__->meta->make_immutable;
}


my @hoge = map { @{$_->list} } {[
    Arr->new(list => [1, 2]),
    Arr->new(list => [3, 4]),
]};

use Data::Dumper;
print Dumper @hoge;

# inline展開の確認
# perl -MO=Deparse xxx.pl
package constant_trial;
{
    use constant HOGE => "hoge";
    
    sub print_hoge {
        print HOGE, "\n";
        print constant_trial::HOGE, "\n";
        print __PACKAGE__->HOGE, "\n";
    }

    print_hoge;
    {
        local $SIG{__WARN__} = sub {};
        *HOGE = sub () { "foo" };
        print_hoge;
    }
}

package smart_style_trial;
{
    my $a;
    print for @$a;
    print "\n-- " . __PACKAGE__ . " --\n";
    my $hash_ref = {};
    print $hash_ref->{non_exist_key} // 'not exists', "\n";

    my $key = undef;
    $hash_ref->{key} = 111;
    print $hash_ref->{$key // 'key'}, "\n";
    
    sub get_ref { return {key => 111} }
    print get_ref()->{key}, "\n";
}

package hash_extract_trial;
{
    use Data::Dumper;
    print "\n-- ".__PACKAGE__." --\n";
    
    print Dumper {()};
    print Dumper {hoge => 11};
}

package reference_trial;
{
    print "\n-- " . __PACKAGE__ . " --\n";
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
    print "\n-- " . __PACKAGE__ . " --\n";
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
    print "\n-- " . __PACKAGE__ . " --\n";
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
    print "\n-- " . __PACKAGE__ . " --\n";
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

package signal_trial;
{
    print "\n-- " . __PACKAGE__ . " --\n";

    my $str = 'string';
    print q(single quote $str), "\n";
    print qq(double quote $str), "\n";
    print qw(quote word $str), "\n";

}

package regex_trial;
{
    print "\n-- " . __PACKAGE__ . " --\n";

#    my $pat = "\\.htm\$";
#    $string =~ /$pat/i;
    print 'slashed way matched .txt', "\n" if 'hoge.txt' =~ /\.txt$/;
    print 'qr way matched .txt', "\n" if 'hoge.txt' =~ qr/\.txt$/;

#    my $regexp = qr/\.htm$/i; # \ の使い方に注意
#    $string =~ $regexp;
#    print 'matched', "\n";

}

package autovivification_trial;
{
    print "\n-- " . __PACKAGE__ . " --\n";

    use Test::More;
    # autovivify
    {
        my $hash_ref = {};
        is_deeply $hash_ref, {}, 'of course empty.';

        print 'dummy echo' if $hash_ref->{foo}{bar};
        is_deeply $hash_ref, {foo => {}}, 'Create foo Automatically by Accessing.';

        $hash_ref = {};
        $hash_ref->{hoge}{huga} = 1;
        is_deeply $hash_ref, {hoge => {huga => 1}}, 'Create hoge.huga Automatically by Writing.';

    }
    # no autovivify
    {
        no autovivification;

        my $hash_ref = {};
        is_deeply $hash_ref, {}, 'of course empty.';

        print 'dummy echo' if $hash_ref->{foo}{bar};
        is_deeply $hash_ref, {}, 'Create Nothing.';

        $hash_ref->{hoge}{huga} = 1;
        is_deeply $hash_ref, {hoge => {huga => 1}}, 'Create hoge.huga Automatically by Writing.';

    }
    done_testing;
}

package unless_trial;
{
    # unlessに入る値がT/Fかが重要
    print "\n-- " . __PACKAGE__ . " --\n";
    print 'unless 0', "\n" unless 0;
    print '0 && ""', "\n" unless 0 && '';
    print '1 && ""', "\n" unless 1 && '';
    print '1 && 1', "\n" unless 1 && 1;
    print '0 || 1', "\n" unless 0 || 1;
}

package data_trial;
{
    print "\n-- " . __PACKAGE__ . " --\n";
    while (<DATA>) {
        print $_;
    }
}
__DATA__
data_1
data_2
data_3


