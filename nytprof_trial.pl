#!/usr/bin/perl
use strict;
use warnings;

use FindBin;
use lib $FindBin::Bin . '/lib';

##
## NYTProf
##
# cpanm -fl ./extlib  --no-man-pages -n  Devel::NYTProf
# perl -d:NYTProf -I ~/Documents/perl/local/lib/perl5/darwin-thread-multi-2level nytprof_trial.pl
# nytprofhtml -f nytprof.out -o nytprof_report
# open nytprof_report/index.html
use lib $FindBin::Bin . '/local/lib/perl5/darwin-thread-multi-2level';


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
