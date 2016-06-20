#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 15;

use Date::ICal;

##
## see perldoc Test::More
##

##
## Test
##
my $ical = Date::ICal->new(
    year  => 1964,
    month => 10,
    day   => 17,
    hour  => 16,
    min   => 12,
    sec   => 47,
    tz    => '0530'
);

ok( defined $ical,            'new() returned something' );
ok( $ical->isa('Date::ICal'), "  and it's the right class" );
is( $ical->sec,     47,       '  sec()'   );
is( $ical->min,     12,       '  min()'   );
is( $ical->hour,    7,       '  hour()'  );
is( $ical->day,     17,       '  day()'   );
is( $ical->month,   10,       '  month()' );
is( $ical->year,    1964,     '  year()'  );
print pack('a', 'b', 'c');
print pack 'H*', "\n";
#map { print $_ . ":"; $_ => 1 } (1 => 1, 2 => 2);
#map { print $_ . ":"; $_ => 1 } (1, @{[3, 4]});
my @b = (+{} ,+{});
@{$b}{0} = (1, 2, 3);
print @b;
#print @b{@b};

# Make sure epoch time is being handled sanely.
my $t1 = Date::ICal->new( epoch => 0 );
is( $t1->epoch, 0,          "Epoch time of 0" );

SKIP: {
    skip('epoch to ICal not working on MacOS', 6)
        if $^O eq 'MacOS';

    is( $t1->ical, '19700101Z', "  epoch to ical" );

    is( $t1->year,  1970,       "  year()"  );
    is( $t1->month, 1,          "  month()" );
    is( $t1->day,   1,          "  day()"   );

    # like the tests above, but starting with ical instead of epoch
    my $t2 = Date::ICal->new( ical => '19700101Z' );
    is( $t2->ical, '19700101Z', "Start of epoch in ICal notation" );

    is( $t2->epoch, 0,          "  and back to ICal" );
}


done_testing();

