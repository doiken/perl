#!/usr/bin/perl
package Foo;
use Mouse;

has hash_ref => (is => 'ro', isa => 'HashRef[Str]', default => sub { {} });

package main;
use strict;
use warnings;

my $foo = Foo->new;
undef = $foo->hash_ref->{foo}{bar};
$foo = Foo->new(hash_ref => $foo->hash_ref);
# Attribute (hash_ref) does not pass the type constraint because: Validation failed for 'HashRef[Str]' with value HASH(0x7f882b86dec0) at /Users/doi_kenji/Documents/perl/local/lib/perl5/darwin-thread-multi-2level/Mouse/Util.pm line 386.
# Mouse::Util::throw_error('Mouse::Meta::Attribute=HASH(0x7f882b0035a0)', 'Attribute (hash_ref) does not pass the type constraint becaus...', 'data', 'HASH(0x7f882b86dec0)', 'depth', -1) called at /Users/doi_kenji/Documents/perl/mouse.pl line 13