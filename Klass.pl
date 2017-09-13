#!/usr/bin/perl
use strict;
use warnings;

use FindBin;
use lib $FindBin::Bin . '/lib';

#
##
## Parent
##

use Klass;

my $k = Klass->new();
$k->says();
$k->{hoge} = 11111111111;
print $k->echo_hoge;


##
## Child
##
use Child;

my $c = Child->new();
$c->says();
