package Child;
use strict;
use warnings FATAL => 'all';

use parent qw(Klass);

sub says {
    my $self = shift;
    $self->SUPER::says;
    print "And, His Son!\n";
}

1;