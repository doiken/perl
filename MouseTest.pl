#!/usr/bin/perl
use strict;
use warnings;

use FindBin;
use lib $FindBin::Bin . '/lib';

use Man;

my $m = Man->new(ssn => 0, foo => 'hello');
print $m->gender . "\n";
print $m->ssn, "\n";
print $m->foo_star, "\n";

# 
print $m->foo_star, "\n"; # keep hello
$m->clear_foo_star();
$m->foo('morning');
$m->foo('evening');
print $m->has_foo_star() ? 'has_foo_star\n' : 'not has_foo_star\n';
print $m->foo_star, "\n"; # change hello


my $list = [1, 2];
#print $m->hoge($list);
print $m->hoge;

