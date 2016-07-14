#!/usr/bin/perl
use strict;
use warnings;

use lib './lib';
use Skinny::Model;

##
## http://t.nzk.me/entry/20100128/1264667446
##
my $db = Skinny::Model->new;
$db->connect(
    {
        dsn      => 'dbi:mysql:hostname=127.0.0.1;dbname=perl_test',
        username => 'root',
        password => 'test'
    }
);

# INSERT INTO webmem
# を実行
my $row = $db->create('webmemo',
    {
        title => 'test',
        body  => 'http://example.com',
    }
);

$row->update({title => 'test' . localtime});

$row = $db->single('webmemo', { title => 'test'});
print $row->id, "\n";
print $row->title, "\n";
print $row->body, "\n";

$row->delete('webmemo');

1;
