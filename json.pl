#!/usr/bin/perl

package json_trial;
{
    use Data::Dumper;
    use JSON::XS;
    use JSON;
    my $json = q|{"a": "https://imp.ebis.ne.jp/imp.php?ai\\u003dtdv57833e1045e48\\u0026argument\\u003dWnXAVwJa\\u0026tag_id\\u003dtag57833e1045292\\u0026dn\\u003daemthaTJfbG9n"}|;
    $json = JSON::decode_json($json);
    print $json->{a};
}


