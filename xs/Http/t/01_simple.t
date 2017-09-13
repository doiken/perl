use strict;
use Test::More;

use Http;

note 'hogehogehoge';
like(Http::get('yahoo.co.jp'), qr(^HTTP/1.1 200 OK));

done_testing;

