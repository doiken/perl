#!/usr/bin/perl
BEGIN {
    $ENV{MOUSE_PUREPERL} = 1; # to use PUREPERL MOUSE
    $ENV{MOUSE_DEBUG} = 1; # for Mouse::Meta::Method::Accessor
}

package Foo1;
use Mouse;

has 'foo' => (is => 'ro', isa => 'Bool', default => sub { 0 });
has 'bar' => (is => 'rw', isa => 'Bool', trigger => sub { print $_[1] });

package main;
use strict;
use warnings;

{
    Foo1->new(bar => 1)->bar(0);
}

my $foo;

__END__
package Foo1;
#line 1 "ro-accessor for foo (/Users/doi_kenji/Documents/perl/local/lib/perl5/darwin-thread-multi-2level/Mouse/Meta/Method/Accessor.pm)"
sub {
Carp::confess("Cannot assign a value to a read-only accessor of $name") if scalar(@_) >= 2;
return $_[0]->{q{foo}};
}
package Foo1;
#line 1 "rw-accessor for bar (/Users/doi_kenji/Documents/perl/local/lib/perl5/darwin-thread-multi-2level/Mouse/Meta/Method/Accessor.pm)"
sub {
if (scalar(@_) >= 2) {

$compiled_type_constraint->($_[1]) or
                    $attribute->_throw_type_constraint_error($_[1], $constraint);
my @old_value = exists $_[0]->{q{bar}} ? $_[0]->{q{bar}} : ();
$_[0]->{q{bar}} = $_[1];
$trigger->($_[0], $_[1], @old_value);
}
return $_[0]->{q{bar}};
}
#line 1 "/Users/doi_kenji/Documents/perl/local/lib/perl5/darwin-thread-multi-2level/Mouse/Meta/Method/Constructor.pm"
    package Foo1;
    sub {
        my($meta, $instance, $args, $is_cloning) = @_;
        my @triggers;
# initialize foo
if (exists $args->{q{foo}}) {
$instance->{q{foo}} = $args->{q{foo}};
$checks[0]->($instance->{q{foo}})
  or $attrs[0]->_throw_type_constraint_error($instance->{q{foo}}, $attrs[0]->{type_constraint});

} else {
$instance->{q{foo}} = $attrs[0]->{default}->($instance);
$checks[0]->($instance->{q{foo}})
  or $attrs[0]->_throw_type_constraint_error($instance->{q{foo}}, $attrs[0]->{type_constraint});
}

# initialize bar
if (exists $args->{q{bar}}) {
$instance->{q{bar}} = $args->{q{bar}};
$checks[1]->($instance->{q{bar}})
  or $attrs[1]->_throw_type_constraint_error($instance->{q{bar}}, $attrs[1]->{type_constraint});
push @triggers, [$attrs[1]->{trigger}, $instance->{q{bar}}];

} else {
}

$_->[0]->($instance, $_->[1]) for @triggers;;
        return $instance;
    }
