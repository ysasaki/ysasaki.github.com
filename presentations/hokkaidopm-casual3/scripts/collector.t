use strict;
use Test::More;
use PerlIO::via::Collector64;

my $out = '';

open my $fh, '>:via(Collector64)', \$out;
print $fh 'aaaaaa';
close $fh;

is $out, 'YWE=', $out;

done_testing;
