use utf8;
use strict;
use warnings;
use open ':encoding(utf8)';

open my $out, '>', 'out.txt';
open my $in,  '<', 'word.txt';

while (<$in>) {
    warn utf8::is_utf8($_) ? "Text strings" : "Binary strings";
    print $out $_;
}

close $in;
close $out;
