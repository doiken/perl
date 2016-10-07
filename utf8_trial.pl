#!/usr/bin/perl
use strict;
use warnings;
use lib './lib';

use Encode;
use JSON::PP;

# わかりやすい記事: http://monmon.hateblo.jp/entry/20111024/1319473613
# Perl外部に存在する"バイナリ" と Perl内部に存在する"Perl文字列"
# "バイナリ"を○○コードとみなして、"Perl文字列"に変換するのがEncodeモジュール
# use utf8;するとソースコードの文字は"Perl文字列"になる

# http://tech.voyagegroup.com/archives/465806.html
package utf8_trial_with_utf8 {
    use utf8;
    print "\n-- utf8_trial_with_utf8 --\n";
    my $str = 'あいうえお'; # flagged

    # print $str; # error
    print Encode::encode_utf8($str), "\n";

    my $json = {
      foo => 'ふぅ',
      bar => 'ばぁ'
    };

    # print JSON::PP->new->utf8(0)->encode($json), "\n"; # error
    print JSON::PP->new->utf8(1)->encode($json), "\n";

    ## jsonの繰り返し
    my $json_nest = {
        baz => JSON::PP->new->utf8(1)->encode($json)
    };

    my $foo;# = [1];
    print [@{$foo // []}, 2];
    print JSON::PP->new->utf8(0)->encode($json_nest), "\n";
}

package utf8_trial_without_utf8 {
    print "\n-- utf8_trial_without_utf8 --\n";
    my $str = 'あいうえお'; # flagged

    print $str, "\n";

    my $json = {
        foo => 'ふぅ',
        bar => 'ばぁ'
    };
    print JSON::PP->new->utf8(0)->encode($json), "\n";
    print JSON::PP->new->utf8(1)->encode($json), "\n"; # 文字化け

    my $json_mixed = {
        foo => 'ふぅ',
        bar => Encode::decode_utf8('ばぁ')
    };
    # print JSON::PP->new->utf8(0)->encode($json_mixed), "\n"; # error
    print JSON::PP->new->utf8(1)->encode($json_mixed), "\n"; # ふぅのみ文字化け

    ## jsonの繰り返し
    my $json_nest = {
        baz => JSON::PP->new->utf8(0)->encode($json)
    };

    print JSON::PP->new->utf8(0)->encode($json_nest), "\n";

}




