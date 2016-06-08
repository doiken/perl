#!/usr/bin/perl
use strict;
use warnings;

use FindBin;
use lib $FindBin::Bin . '/lib';

use Man;

my $m = Man->new(('ssn' => 0));

print $m->gender . "\n";
print $m->ssn;

