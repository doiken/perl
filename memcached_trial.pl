#!/usr/bin/perl
use strict;
use warnings;

{ # Cache::Memcached::Fast::Safe
=pod
    use constant KEY => 'some_key';
    use Cache::Memcached::Fast::Safe;

    my $memd = Cache::Memcached::Fast::Safe->new({
        servers => [ { address => 'localhost:11211' } ]
    });
    $memd->set(KEY, +{i => 100});
    print ${$memd->get(KEY)}{i};
    #$memd->get_or_set('key:941',sub {
    #        DB->retrieve(941)
    #    },10);

    #This module supports all method that Cache::Memcached::Fast has.
=cut
}

{ # Cache::Memcached::AnyEvent
    # http://search.cpan.org/~dmaki/Cache-Memcached-AnyEvent-0.00023/lib/Cache/Memcached/AnyEvent.pm
    # use ketama algorithm instead of the traditional one
    use Cache::Memcached::AnyEvent;
    my $memd = Cache::Memcached::AnyEvent->new({
        servers => [ '127.0.0.1:11211' ],
        compress_threshold => 10_000,
        namespace => 'myapp.',
#        selector_class => 'Ketama',
    });
   # use AE;
   my $cv = AnyEvent->condvar;
   $cv->begin( sub {
       use Data::Dumper;
       print Dumper \@_;
       $cv->end();
   }); # first watcher
   $memd->set("foo", 'bar', $cv);
   $memd->get("foo", $cv );
   $cv->recv;

}

