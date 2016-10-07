#!/usr/bin/perl
use strict;
use warnings;
use lib './lib';

use Text::Ux;
use File::Temp ();

use local::lib 'extlib';

use TokyoCabinet;

package review_trial {
#    # Store to TC
#    {
#        # my $tmp = File::Temp->new(UNLINK => 0, SUFFIX => ".review_index.$task");
#        my $hdb = TokyoCabinet::HDB->new();
#
#        # open the database
#        if(!$hdb->open("/tmp/trie.hdb", $hdb->OWRITER | $hdb->OCREAT)){
#            my $ecode = $hdb->ecode();
#            printf STDERR ("open error: %s\n", $hdb->errmsg($ecode));
#        }
#
#        my $ux_saver = Text::Ux->new;
#
#        $ux_saver->build([qw(foo bar baz)]);
#        $ux_saver->save(\my $dic);
#        $hdb->put('test_key', $dic);
#
#        my $ux_loader = Text::Ux->new;
#        $ux_loader->load(\$hdb->get('test_key'));
#
#        # print $ux_loader->prefix_search('foo');
#    }
#    # Store to FIle::Temp
#    {
#        my $fh = File::Temp->new(SUFFIX => ".review_trial", TMPDIR => 1); #, UNLINK => 0);
#        binmode($fh);
#
#        # my $tmp = File::Temp->new(UNLINK => 0, SUFFIX => ".review_index.$task");
#        use MIME::Base64 qw(encode_base64);
#        my $ux_saver = Text::Ux->new();
#
#        $ux_saver->build([qw(foo bar baz)]);
#        $ux_saver->save(\my $dic);
#        $ux_saver->save('/tmp/hoge');
#        print $fh $dic;
#
#        my $ux_loader = Text::Ux->new;
##        $ux_loader->load('/tmp/hoge');
#        $ux_loader->load('/tmp/hoge');
#        print $ux_loader->prefix_search('foo'), "\n";
#    }
    # Just Test
    {
        my @arr = (1, 2, 3, 4, 5);
        print @arr;
        print scalar(@arr);
#        is_deeply @list, ();
#        my $hdb = TokyoCabinet::HDB->new();
#        $hdb->open("/tmp/review_index_data_copy.hdb", $hdb->OREADER);
#
#        my $ux = Text::Ux->new;
#        $ux->load(\$hdb->get('WFLTR::FL::APPNEXUS::TRIE:300x250'));
#
#        my @csv_10 = sort grep { substr($_, 0, 1) eq '9' } split(/,/, $hdb->get('WFLTR::FL::APPNEXUS:300x250'));
#        my @trie_10 = sort $ux->predictive_search('9');
#
#        use Test::More;
#        is scalar @csv_10, 156, 'not empty';
#        is scalar @trie_10, 156, 'not empty';
#
#        is_deeply \@csv_10, \@trie_10, 'same array list';
#        done_testing;
    }
}
