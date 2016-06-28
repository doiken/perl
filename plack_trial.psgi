#!/usr/bin/env perl

use strict;
use warnings;

use lib './lib';
use lib './extlib/lib/perl5';

use Plack::Builder;
use Plack::Request;

# http://dqn.sakusakutto.jp/2011/08/plackplackhello_world.html
# プロジェクトコンフィギュレーションで -I移行を入力し、working directoryをプロジェクトルートに
# perl -I lib/ -I extlib/lib/perl5/ ./extlib/bin/plackup
# curl http://localhost:5000/

my $app = sub {
    my $env = shift;
    print $env;
    return [
        200,
        [ 'Content-Type' => 'text/plain' ],
        [ "Hello World2" ],
    ];
};

builder {
    enable sub {
            my $app = shift;
            sub {
                my $env = shift;
                my $res = $app->($env);

                my $req = Plack::Request->new( $env );

                $res->[2]  = [ $req->query_string . ':' . $env->{'QUERY_STRING'} . "Good Morning!"];
                return $res;
            };
        };
    $app;
};
#return $app;
