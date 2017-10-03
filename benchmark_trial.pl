#!/usr/bin/perl
use strict;
use warnings;

use Benchmark qw(:all) ;
use Digest::FarmHash qw(farmhash32 farmhash_fingerprint32);
use Digest::MurmurHash3 qw(murmur32);

sub generate_key_resolve_ref {
    return join ',', map {
         my $ref = ref $_;
         unless ($ref) {
              $_ // '';
         } elsif ($ref eq 'HASH') {
              %$_;
         } elsif ($ref eq 'ARRAY') {
              @$_;
         }
    } @_;
}

sub generate_key_scalar {
     return join ',', map {
          $_ // '';
     } @_;
}

sub generate_key_murmur {
    murmur32(\@_);
}
sub generate_key_farmhash {
    use Data::Dumper;
    print Dumper $_[0];
    print $_[0];
    farmhash32($_[0]);
}
my $hash = +{ map { $_ => $_ } (0 .. 3) };
my %hash = %$hash;

print {aaa => 1, 1 => 2, 2 => 1, }, "\n";
print {2 => 1, 1 => 2, aaa => 1}, "\n";
print generate_key_farmhash({1 => 2, 2 => 1}), "\n";
print generate_key_farmhash({2 => 1, 1 => 2}), "\n";
$hash->{0} = 6;
print generate_key_farmhash($hash), "\n";
#print generate_key_resolve_ref(1, 2, $hash), "\n";
#print generate_key_scalar(1, 2, %hash), "\n";
#print generate_key_murmur(1, 2, $hash), "\n";
#print generate_key_farmhash(1, 2, $hash), "\n";
#cmpthese(1_000_000, {
#    'generate_key_resolve_ref' => sub { generate_key_resolve_ref(1, 2, $hash)},
#    'generate_key_scalar' => sub { generate_key_scalar(1, 2, %hash); },
#    'generate_key_murmur' => sub { generate_key_murmur(1, 2, $hash); },
#    'generate_key_farmhash' => sub { generate_key_farmhash(1, 2, $hash); },
#});

__END__;

# hash=50件
generate_key_resolve_ref generate_key_murmur generate_key_farmhash
generate_key_scalar        30039/s                  --                     -20%                -98%                  -98%
generate_key_resolve_ref   37580/s                 25%                       --                -97%                  -98%
generate_key_murmur      1234568/s               4010%                    3185%                  --                  -25%
generate_key_farmhash    1639344/s               5357%                    4262%                 33%                    --

# hash=3件
/usr/bin/perl -I/Users/doi_kenji/Documents/perl/lib -I/Users/doi_kenji/Documents/perl/local/lib/perl5 /Users/doi_kenji/Documents/perl/benchmark_trial.pl
                              Rate generate_key_scalar generate_key_resolve_ref generate_key_murmur generate_key_farmhash
generate_key_scalar       294985/s                  --                      -7%                -83%                  -85%
generate_key_resolve_ref  316456/s                  7%                       --                -82%                  -84%
generate_key_murmur      1754386/s                495%                     454%                  --                  -11%
generate_key_farmhash    1960784/s                565%                     520%                 12%                    --

# hash=0件
/usr/bin/perl -I/Users/doi_kenji/Documents/perl/lib -I/Users/doi_kenji/Documents/perl/local/lib/perl5 /Users/doi_kenji/Documents/perl/benchmark_trial.pl
                              Rate generate_key_resolve_ref generate_key_scalar generate_key_murmur generate_key_farmhash
generate_key_resolve_ref  826446/s                       --                -23%                -53%                  -55%
generate_key_scalar      1075269/s                      30%                  --                -39%                  -41%
generate_key_murmur      1754386/s                     112%                 63%                  --                   -4%
generate_key_farmhash    1818182/s                     120%                 69%                  4%                    --

# hash=0件 128bit
generate_key_resolve_ref  833333/s                       --                -12%                -31%                  -47%
generate_key_scalar       943396/s                      13%                  --                -22%                  -41%
generate_key_murmur      1204819/s                      45%                 28%                  --                  -24%
generate_key_farmhash    1587302/s                      90%                 68%                 32%                    --

# refのみhash化
generate_key_scalar      289855/s                  --                      -6%                  -31%                -48%
generate_key_resolve_ref 307692/s                  6%                       --                  -26%                -44%
generate_key_farmhash    418410/s                 44%                      36%                    --                -24%
generate_key_murmur      552486/s                 91%                      80%                   32%                  --