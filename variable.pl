use strict;
use warnings;

package test;

##
## scala
##
my $num1 = 1;
my $num2 = 2;


print("num: " . ($num1 + $num2) . " \n");

my $str1 = 'str1';
my $str2 = 'str2';

print("str: " . $str1 . $str2 . "\n");

##
## list/hash
##
my @l = (1, 2, 3);
my $l_ref = [4, 5, 6];

my %h = (a => 1, b => 2, c => 3);

print("list: " . @l . $l[0] . "\n");
print("hash: " . %h . $h{a} . "\n");

print "foreach: ";
foreach my $elm (@l)
{
    print $elm;
}

print "\n";

print "foreach_ref: ";
foreach my $elm (@{$l_ref})
{
    print $elm;
}

print "\n";

##
## subroutine
##
sub to2 {
    my ($str) = @_;

    return substr($str, 0, 2);
}

print "to2: " . to2('aaa') . "\n";

sub joinList {
    my ($list) = @_;
    print @{$list};

    return join(",", @{$list});
}

my @list = ("a", "b", "c");
print "join: " . joinList(\@list) . "\n";
