package Gender;
use strict;
use warnings;

use Mouse::Role;

requires 'gender';

##
## Roleのsubは継承でなく、「展開」されるイメージ。
## よって、上書きにはsubで再定義、もしくはaround(roleのメソッドを参照したい場合)を利用
##
sub declar_gender {
    my ($self) = $_;

    return "I'm " . $self->gender . "!\n";
}

no Mouse;

#__PACKAGE__->meta->make_immutable;

1;