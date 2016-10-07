#!/usr/bin/perl
use strict;
use warnings;

package SuperRole {
    use Mouse::Role;
    requires 'should_be_implemented';
    no Mouse::Role;
    1;
}

package SubRole {
    use Mouse::Role;
    with 'SuperRole';

    # not implemented in SubRole
    # requires 'should_be_implemented';
    no Mouse::Role;
    1;
}

package MainMouse {
    use Mouse;
    with 'SubRole';
    
    sub should_be_implemented {
        return 1;
    }
    no Mouse;
    __PACKAGE__->meta->make_immutable;
    1;
}

package MainMouseTrial {
    print MainMouse->new()->should_be_implemented;
}
