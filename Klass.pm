use strict;
use warnings;

package Klass;

sub new {
    my $class = shift;
    my $self = {
        Name => 'none',
        Age => 10,
        @_,
    };
    return bless $self, $class;
}

sub age {
    my $self = shift;
    return $self->{Age};
}
sub says {
    my $self = shift;
    print $self->age() . "\n";
    print "Hello, I am " . $self->{Name} . " !\n";
}

1;