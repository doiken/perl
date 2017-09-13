#!/usr/bin/env perl

use strict;
use warnings;

use lib './lib';

use Plack::Builder;
use Plack::Request;
use Plack::Response;
use Time::HiRes qw(time);
# http://dqn.sakusakutto.jp/2011/08/plackplackhello_world.html
# NYTPROF=sigexit=int:file=/tmp/nytprof/nytprof.out perl -Mlocal::lib=~/Documents/perl/local ./local/bin/plackup --port 8080 --max-workers 2 --max-reqs-per-child 3 --min-reqs-per-child 3 plack_trial.psgi
# curl http://localhost:8080/

sub foo {
    print 'foo!', "\n";
}

sub bar {
    print 'bar!', "\n";
}

my $app = sub {
    my $env = shift;
    my $req = Plack::Request->new($env);

    my $res = Plack::Response->new(200);
    $res->content_type('application/json; charset=utf-8');
    $res->body(q|{content: "OK!"}|);
    if ($req->parameters->{query} eq '?profile') {
        DB::enable_profile();
        foo();
    } else {
        DB::disable_profile();
    }

    return $res->finalize;
};

builder {
    $app;
};
