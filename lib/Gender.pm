package Gender;
use strict;
use warnings;

use Mouse::Role;

requires 'gender';

sub declar_gender {
    my ($self) = $_;

    return "I'm " . $self->gender . "!\n";
}

no Mouse;

#__PACKAGE__->meta->make_immutable;

1;