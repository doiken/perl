#!/usr/bin/perl
use strict;
use warnings;

use FindBin;
use lib $FindBin::Bin . '/xs/lib/';
use Hello;

Hello::hello;

