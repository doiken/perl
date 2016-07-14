#!/usr/bin/env perl

use strict;
use warnings;

use lib './lib';

use Plack::Builder;
use Plack::Request;
use Plack::Response;

# http://dqn.sakusakutto.jp/2011/08/plackplackhello_world.html
# perl -Mlocal::lib=~/Documents/perl/local ./local/bin/plackup plack_trial.psgi
# curl http://localhost:5000/

my $app = sub {
    my $env = shift;
    print $env;

    my $res = Plack::Response->new(200);
    $res->content_type('application/json; charset=utf-8');
    $res->body(q|{content: "OK!"}|);

    return $res->finalize;
};

builder {
#    enable sub {
#            my $app = shift;
#            sub {
#                my $env = shift;
#                my $res = $app->($env);
#
#                my $req = Plack::Request->new( $env );
#
#                if ($req->query_string eq 'die') {
#                    print STDERR 'Errrrror', "\n";
#                }
#                $res->[2]  = [ $req->query_string . ':' . $env->{'QUERY_STRING'} . "Good Morning!"];
#                return $res;
#            };
#        };
    $app;
};
#return $app;
