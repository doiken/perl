package Skinny::Model::Schema;
use strict;
use warnings;

use DBIx::Skinny::Schema;

install_table webmemo => schema {
            pk 'id';
            columns qw/ id title body created_at updated_at /;
        };
1;

