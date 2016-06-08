#!/usr/bin/perl
use strict;
use warnings;

use FindBin;
use lib $FindBin::Bin . '/lib';

foreach my $path (@INC){
    print "$path\n";
}

print "\n";

##
## Parent
##

use Klass;

my $k = Klass->new();
$k->says();

##
## Child
##
use Child;

my $c = Child->new();
$c->says();
