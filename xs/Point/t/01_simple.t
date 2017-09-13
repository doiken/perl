use strict;
use Test::More;

use Point;

use Point;
ok my $p = Point->new(5,9);
is $p->x, 5;
is $p->y, 9;
is $p->dist(Point->new(2,6)), 4.24264068711928;

done_testing;

