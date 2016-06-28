#!/usr/bin/perl
use strict;
use warnings;

use FindBin;
use lib $FindBin::Bin . '/lib';

use Data::Dumper;

# 配列
{
    print "------------------------------------\n";
    print "ARRAY\n";
    print "------------------------------------\n";
    # 値渡し
    my @value_from = (0, 1, 2);
    my @value_to   = @value_from;
    $value_to[1]   = 'a';
    print Dumper(\@value_from);
        # fromに変化なし

    # リファレンス
    my @ref_from = (0, 1, 2);
    my $ref_to   = \@ref_from;
    $ref_to->[1] = 'a';
    print Dumper(\@ref_from);
        # fromは変化

    # 無名配列のリファレンス
    my $anon_ref_from = [0, 1, 2];
    my $anon_ref_to   = $anon_ref_from;
    $anon_ref_to->[1] = 'a';
    print Dumper(@{$anon_ref_from});
        # fromは変化

    # リファレンスのネスト
    my $nest_from    = [[0, 1, 2], [3, 4, 5]];
    my $nest_to      = $nest_from;
    $nest_to->[1][0] = 'a';
    print Dumper(@{$nest_from});
        # fromは変化

}

# class
{
    print "\n";
    print "------------------------------------\n";
    print "CLASS\n";
    print "------------------------------------\n";
    use Klass;

    my $class_from = Klass->new();
    my $class_to = $class_from;

    $class_to->{Name} = 'modified';
    print ref($class_from);
    print Dumper($class_from);
    $class_to->says();
}
