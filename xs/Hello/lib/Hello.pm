package Hello;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use XSLoader;
XSLoader::load(__PACKAGE__, $VERSION);

1;
__END__

=encoding utf-8

=head1 NAME

Hello - It's new $module

=head1 SYNOPSIS

    use Hello;

=head1 DESCRIPTION

Hello is ...

=head1 LICENSE

Copyright (C) doiken.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

doiken E<lt>doi_kenji@fout.jpE<gt>

=cut

