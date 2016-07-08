#!/usr/bin/perl
use strict;
use warnings;

use FindBin;
use lib $FindBin::Bin . '/lib';

##
## NYTProf
##
# cpanm -fl ./extlib  --no-man-pages -n  Devel::NYTProf
# PERL5LIB=$PERL5LIB:~/Documents/perl/extlib/lib/perl5/:~/Documents/perl/extlib/lib/perl5/darwin-thread-multi-2level perl extlib/bin/nytprofhtml
use lib $FindBin::Bin . '/extlib/lib/perl5/darwin-thread-multi-2level';


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
