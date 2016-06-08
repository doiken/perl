package Person;
use strict;
use warnings;

use Mouse;

has 'ssn' => (
        is      => 'rw',
        isa     => 'Int',
        default => 0
    );

no Mouse;

__PACKAGE__->meta->make_immutable;

1;