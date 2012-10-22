
use open IN => ':encoding(utf8)', OUT => ':encoding(utf8)';
use open IO => ':encoding(utf8)';
use open ':encoding(utf8)';

open my $fh, '<', 'foobar.txt';
while(<$fh>) {
    my $text = decode_utf8($_)
}
close $fh;


use open ':std', ':encoding(utf8)';
use open ':encoding(utf8)', ':std';
#use open ':encoding(utf8)';

while (<STDIN>) {
    my $text = decode_utf8($_)
}

use open ':encoding(utf8)';
binmode STDIN, ':encoding(utf8)';
binmode STDOUT, ':encoding(utf8)';
binmode STDERR, ':encoding(utf8)';









