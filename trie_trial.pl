#!/usr/bin/perl
use strict;
use warnings;
use lib './lib';

use Text::Ux;

package trie_trial {
    # apiについて
    # http://blog.k11i.biz/2011/02/trie.html
    my $ux = Text::Ux->new;

    # build
#    $ux->build([qw(foo bar baz)]);
#    $ux->save('/tmp/trie');
    # or save the dictionary into string
#    $ux->save(\my $dic);

    # search
    $ux->load('/tmp/trie');
    # or pass string
    # $ux->load(\$dic);

    print $ux->prefix_search('foo'), "\n";
#    print $ux->prefix_search('foooo'), "\n";
#    print $ux->common_prefix_search('bard'), "\n";
#    print $ux->predictive_search('ba'), "\n";


#    use Time::HiRes qw(gettimeofday tv_interval);
#    my $t;
#    my $ux_org = Text::Ux->new;
#    $ux_org->build([(1..20)]);
#    $ux_org->save(\my $dic);
#
#    $t = [gettimeofday];
#    my $ux;
#    for (0 .. 100000) {
#        $ux = Text::Ux->new;
#
#        # build
#        $ux->load(\$dic);
#    }
#    print 'newing elapsed=' . tv_interval($t), "\n";
#
#    $t = [gettimeofday];
#    for (0 .. 100000) {
#        $ux->clear;
#
#        # build
#        $ux->load(\$dic);
#    }
#    print 'clearing elapsed=' . tv_interval($t), "\n";
}
