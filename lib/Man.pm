package Man;
use strict;
use warnings;

use Mouse;
use Gender;

extends 'Person';
with 'Gender';

has username => (
    is      => 'rw',
    isa     => 'Str',
    default => ''
);

has hoge => (
    is      => 'rw',
    isa     => 'Str',
    lazy_build => 1,
);

has foo => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
);

has foo_star => (
    is      => 'rw',
    isa     => 'Str',
    lazy    => 1,
    default => sub { "**${ \$_[0]->foo }**" },
    clearer => 'clear_foo_star',
    predicate => 'has_foo_star',
);

sub _build_hoge {
    use Data::Dumper;
    print Dumper @_;
    return 'piyo';
#    my $val = shift;
#    print $val;
#    return 'hoge';
}


sub gender {
    return 'man';
}

__PACKAGE__->meta->make_immutable;

1;