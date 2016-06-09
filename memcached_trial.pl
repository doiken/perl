#!/usr/bin/perl
use strict;
use warnings;

use lib './lib';
use lib './extlib/lib/perl5';

use constant KEY => 'some_key';
use Cache::Memcached::Fast::Safe;

my $memd = Cache::Memcached::Fast::Safe->new({
    servers => [ { address => 'localhost:11211' } ]
});
$memd->set(KEY, +{i => 100});
print ${$memd->get(KEY)}{i};
#$memd->get_or_set('key:941',sub {
#        DB->retrieve(941)
#    },10);

#This module supports all method that Cache::Memcached::Fast has.
