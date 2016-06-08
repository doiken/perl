package Man;
use strict;
use warnings;

use Mouse;
use Gender;

extends 'Person';
with 'Gender';

has 'username' => (
    is      => 'rw',
    isa     => 'Str',
    default => ''
);

sub gender {
    return 'man';
}

__PACKAGE__->meta->make_immutable;

1;