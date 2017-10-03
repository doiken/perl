#!/usr/bin/env perl

use strict;
use warnings;

use lib './lib';

use Plack::Builder;
use Plack::Request;
use Plack::Response;
use Try::Tiny qw(try catch finally);
# eval $(perl -Mlocal::lib=~/Documents/perl/local) NYTPROF=start=no perl -d:NYTProf ./local/bin/plackup --server Starlet --server-software Starlet --port 8080 --max-workers 2 --max-reqs-per-child 3 --min-reqs-per-child 3 plack_prof_trial.psgi
# ※ when enable/disable_profile, start=no is necessary
# curl http://localhost:8080/
# eval $(perl -Mlocal::lib=~/Documents/perl/local) nytprofmerge --out=nytprof-merged.out ./nytprof.out.* && nytprofhtml -f nytprof-merged.out -o html
# 次のエラーが出るがprofileは正しく取れそう
# Can't resolve fid of '0' at /Users/doi_kenji/Documents/perl/local/bin/nytprofhtml line 1395.

my $suffix = 0;

sub foo {
    print "foo: $$.$suffix!\n";
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
    if (defined $req->parameters->{profile}) {
        # be careful not to make huge amount of files
        DB::enable_profile("/tmp/nytprof/nytprof.out.$$.${\ $suffix++}");
        foo();
        DB::finish_profile();
    } else {
        bar();
    }

    return $res->finalize;
};

builder {
    $app;
};
