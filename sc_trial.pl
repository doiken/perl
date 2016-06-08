#!/usr/bin/perl
use strict;
use warnings;

use lib './lib';
use lib './extlib/lib/perl5';

use Scope::Container;

use constant KEY => 'some_key';

sub getParam {
    my ($i) = @_;

    if ( my $param = scope_container(KEY) ) {
        print 'Cached', "\n";
        return $param;
    } else {
        print 'Newly Calculated', "\n";
        $param = {
            i    => $i,
            str  => 'str',
            list => [1, 2, 3],
            hash => { k => 'v'}
        };
        scope_container(KEY, $param);
        return $param;
    }
}

for my $i (1..3) {
    my $contaier = start_scope_container();
    print ${getParam($i)}{i}, "\n"; # do calculate
    print ${getParam($i)}{i}, "\n"; # from container
    print ${getParam($i)}{i}, "\n"; # from container
    # $container scope out and disconnect from db
}

print %{getParam(4)}, "\n";

