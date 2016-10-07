#!/usr/bin/perl
use strict;
use warnings;

{
    use Scope::Guard ();

    my $guard = Scope::Guard->new(sub {
            print("$$ Scope guard fired!");
        });
    sleep 5;
}
