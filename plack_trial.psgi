#!/usr/bin/env perl

package Cache;

my $cache = {};
sub new {
    my $class = shift;
    return bless {}, $class;
}

sub set {
    my ($self, $key, $val) = @_;
    $cache->{$key} = $val;
}
sub get {
    my ($self, $key) = @_;
    return $cache->{$key};
}
sub dump {
    return $cache;
}

package main;
use strict;
use warnings;

use lib './lib';

use Plack::Builder;
use Plack::Request;
use Plack::Response;

# http://dqn.sakusakutto.jp/2011/08/plackplackhello_world.html
# eval ```perl -Mlocal::lib=~/Documents/perl/local``` perl -Mlocal::lib=~/Documents/perl/local ./local/bin/plackup --server Starlet --server-software Starlet --port 8080 --max-workers 2 --max-reqs-per-child 2 --max-keepalive-reqs=1 plack_trial.psgi
# curl http://localhost:5000/

our $foo = {};
my $app = sub {
    my $env = shift;
    my $req = Plack::Request->new($env);

    my $res = Plack::Response->new(200);
    my $cache1 = Cache->new();
    my $cache2 = Cache->new();
    $res->content_type('application/json; charset=utf-8');
    $res->body(q|{content: "OK!"}|);
    if (%{$req->parameters}) {
        $cache1->set($_, $req->parameters->{$_}) for keys %{$req->parameters};
    }
    use Data::Dumper;
    print Dumper $cache2->dump;

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
