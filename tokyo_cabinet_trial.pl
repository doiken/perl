#!/usr/bin/perl
use strict;
use warnings;

##
## インストール手順
##
# brew install tokyo-cabinet
# wget http://fallabs.com/tokyocabinet/perlpkg/tokyocabinet-perl-1.34.tar.gz
# tar xzf tokyocabinet-perl-1.34.tar.gz
# cd tokyocabinet-perl-1.34
# eval $(perl -Mlocal::lib=./extlib) # install pathの正しい設定に必要
# perl Makefile.PL
# make && make install
use local::lib 'extlib';

use TokyoCabinet;

# create the object
my $hdb = TokyoCabinet::HDB->new();

# open the database
if(!$hdb->open("casket.tch", $hdb->OWRITER | $hdb->OCREAT)){
    my $ecode = $hdb->ecode();
    printf STDERR ("open error: %s\n", $hdb->errmsg($ecode));
}

# store records
if(!$hdb->put("foo", "hop") ||
    !$hdb->put("bar", "step") ||
    !$hdb->put("baz", "jump")){
    my $ecode = $hdb->ecode();
    printf STDERR ("put error: %s\n", $hdb->errmsg($ecode));
}

# retrieve records
my $value = $hdb->get("foo");
if(defined($value)){
    printf("%s\n", $value);
} else {
    my $ecode = $hdb->ecode();
    printf STDERR ("get error: %s\n", $hdb->errmsg($ecode));
}

# traverse records
$hdb->iterinit();
while(defined(my $key = $hdb->iternext())){
    my $value = $hdb->get($key);
    if(defined($value)){
        printf("%s:%s\n", $key, $value);
    }
}

# close the database
if(!$hdb->close()){
    my $ecode = $hdb->ecode();
    printf STDERR ("close error: %s\n", $hdb->errmsg($ecode));
}

# tying usage
my %hash;
if(!tie(%hash, "TokyoCabinet::HDB", "casket.tch", TokyoCabinet::HDB::OWRITER)){
    printf STDERR ("tie error\n");
}
$hash{"quux"} = "touchdown";
printf("%s\n", $hash{"quux"});
while(my ($key, $value) = each(%hash)){
    printf("%s:%s\n", $key, $value);
}
untie(%hash);
system('rm casket.tch')
