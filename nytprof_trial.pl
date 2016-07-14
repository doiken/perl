#!/usr/bin/perl
use strict;
use warnings;

use FindBin;
use lib $FindBin::Bin . '/lib';

##
## NYTProf
##
# cpanm -fl ./extlib  --no-man-pages -n  Devel::NYTProf
# perl -d:NYTProf -I/Users/doi_kenji/Documents/perl/extlib/lib/perl5/darwin-thread-multi-2level ...
# nytprofhtml -f nytprof.out -o nytprof_report
# open nytprof_report/index.html
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
