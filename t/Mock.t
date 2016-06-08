#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

use Test::MockObject;

##
## Create Mock
##
my $mock = Test::MockObject->new();
$mock->set_true('veritas');
$mock->set_false('ficta');
$mock->set_series('amicae', 'Sunny', 'Kylie', 'Bella');

ok($mock->veritas(), 'Check If veritas Return TRUE');
ok(!$mock->ficta(), 'Check If ficta Return FALSE');

is($mock->amicae(), 'Sunny', 'Check If amicae Return Sunny First');
is($mock->amicae(), 'Kylie', 'Check If amicae Return Kylie Second');
is($mock->amicae(), 'Bella', 'Check If amicae Return Bella Third');
is($mock->amicae(), undef, 'Check If amicae Return undef Last');

done_testing();

