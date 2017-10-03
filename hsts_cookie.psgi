#!/usr/bin/env perl
use strict;
use warnings;

use lib './lib';

use Plack::Builder;
use Plack::Request;
use Plack::Response;

# eval ```perl -Mlocal::lib=~/Documents/perl/local``` sudo perl -Mlocal::lib=~/Documents/perl/local ./local/bin/plackup --server HTTP::Server::PSGI  --ssl-key-file ../fout_infra/puppet/files/ssl/nginx/fout.key --ssl-cert-file ../fout_infra/puppet/files/ssl/nginx/fout.crt --ssl 1 --server-software Starlet --port 80 --max-workers 2 --max-reqs-per-child 2 --max-keepalive-reqs=1 hsts_cookie.psgi
# curl http://localhost:5000/

my $app = sub {
    my $env = shift;
    my $req = Plack::Request->new($env);
    my $res = Plack::Response->new(200);
    if ($req->path eq '/') {
        $res->content_type('text/html');
        $res->body('<html><head><script src="hsts.js"></script></head><body></body></html>');
    } elsif ($req->path eq '/h.gif') {
        $res->header('Access-Control-Allow-Origin', '*');
        if ($req->scheme eq 'https') {
            $res->header('Strict-Transport-Security', 'max-age=31536000');
        }
        $res->content_type('image/gif');
        $res->body("GIF89a\1\0\1\0\200\0\0\0\0\0\0\0\0!\371\4\1\0\0\0\0,\0\0\0\0\1\0\1\0\0\2\2D\1\0\n");
    } elsif ($req->path eq '/hsts.js') {
        my $content = q|var hsts={token:null,tokenHex:null,tokenBin:null,tokenArray:[],hostname:"[HOSTNAME]",doTest:!0,i:0,init:function(){hsts.httpGet("http://wts."+hsts.hostname+"/h.gif")},generateToken:function(){hsts.token=Math.floor(16777215*Math.random()),hsts.tokenBin=(new Array(24).join("0")+hsts.token.toString(2)).slice(-24),hsts.tokenHex=hsts.token.toString(16),hsts.printTokens()},dropTokens:function(){var t=0,s=null;for(console.log("First visit. Dropping tokens."),hsts.doTest=!1,hsts.httpGet("https://wts."+hsts.hostname+"/h.gif"),t=0;t<hsts.tokenBin.length;t+=1)"1"===hsts.tokenBin.charAt(t)&&(s="w"+(t<10?"0"+t:t)+"."+hsts.hostname,hsts.httpGet("https://"+s+"/h.gif"))},readTokens:function(){var t=0,s=null;for(console.log("Return visit. Retrieving tokens."),t=0;t<24;t+=1)s="http://w"+(t<10?"0"+t:t)+"."+hsts.hostname+"/h.gif",hsts.httpGet(s)},parseTokenArray:function(){console.log("Parsing token array."),hsts.tokenBin=hsts.tokenArray.join(""),hsts.token=parseInt(hsts.tokenBin,2),hsts.tokenHex=hsts.token.toString(16),hsts.printTokens()},printTokens:function(){console.log(hsts.tokenBin),console.log(hsts.tokenBin),console.log(hsts.tokenHex)},httpGet:function(t){var s=new XMLHttpRequest,n=null,e=null,o=0;s.onreadystatechange=function(){if(4===s.readyState&&200===s.status){var t=s.responseURL.match(/\/\/w(.*?)\./)[1],h="s"===s.responseURL.charAt(4);if("ts"===t){if(!hsts.doTest)return;h?hsts.readTokens():(hsts.generateToken(),hsts.dropTokens())}else{for(n=parseInt(t,10),hsts.tokenArray[n]=h?1:0,e=!0,o=0;o<24;o+=1)void 0===hsts.tokenArray[o]&&(e=!1);e&&hsts.parseTokenArray()}}},s.open("GET",t,!0),s.send(null)}};hsts.init();|;
        $content =~ s/\[HOSTNAME\]/fout.jp/;
        $res->content_type('text/html');
        $res->body($content);
    }

    return $res->finalize;
};

builder {
    $app;
};
