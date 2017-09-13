use strict;
use Test::More;

use Gimme;

my @arr = Gimme::gimme();
is_deeply(\@arr, [1, 2, 3]);
is(scalar(Gimme::gimme()), 5963);

done_testing;

