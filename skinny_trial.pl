# http://perldoc.jp/docs/modules/DBI-1.612/DBI.pod
package Skinny::Model;
use strict;
use warnings;
use DBIx::Skinny;

package Skinny::Model::Schema;
use strict;
use warnings;

use DBIx::Skinny::Schema;

install_table webmemo => schema {
    pk 'id';
    columns qw/ id title body created_at updated_at /;
};
install_table sample => schema {
    pk 'id';
    columns qw/ id val /;
};

package main;

#!/usr/bin/perl
use strict;
use warnings;

use lib './lib';

my $db = Skinny::Model->new;
$db->connect(
    {
        dsn      => 'dbi:mysql:hostname=127.0.0.1;dbname=perl_test',
        username => 'root',
        password => 'test'
    }
);

## sample
{
    $db->{dbh}->do(<<EOL
create table IF NOT EXISTS sample (
  id  int unsigned not null auto_increment primary key,
  val int not null default 0
);
EOL
    );

    # bulk insert
    # $db->bulk_insert('sample', [ map { +{ val => $_ } } (1 .. 100_000) ]);
    
    print "--- before ----\n";
    system("/bin/ps -o pid,vsz,args -p $$ >&2");
    my $iter = $db->search('sample');
    my $sth = $db->dbh->prepare('SELECT * FROM sample');
    $sth->execute();
    while (my $cpns = $sth->fetchall_arrayref(+{}, 100)) {
        last;
    }
#    use Data::Dumper;
    print "--- search ----\n";
    system("/bin/ps -o pid,vsz,args -p $$ >&2");
#        print Dumper $iter->{sth};
#    my @all = $iter->all();
        pop $iter->all();
    print "--- all ----\n";
    system("/bin/ps -o pid,vsz,args -p $$ >&2");
}

__END__
##
## http://t.nzk.me/entry/20100128/1264667446
##
{
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

    $row = $db->single('webmemo', { title => 'piyo'});
    use Data::Dumper;
    print Dumper $row // 'undef';
}

