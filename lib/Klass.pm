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

sub echo_hoge {
    print $_[0]->{hoge}, "\n";
}

sub age {
    my $self = shift;
    print $self, "\n";
    return $self->{Age};
}
sub says {
    my $self = shift;
    print "I'm ". $self->age() . " year old\n";
    print "Hello, I am " . $self->{Name} . " !\n";
}

1;

__END__

=encoding utf-8

=head1 名前

Klass

=head1 概要

Klassの挙動確認

http://perldoc.perl.org/perlobj.html

1. オブジェクトは所属クラスを知るデータ構造(using bless)
2. クラスはただのパッケージ(@ISAで親を管理. base NG, parent推奨)
3. メソッドはオブジェクトのreferenceを期待する只のサブルーチン

=cut

