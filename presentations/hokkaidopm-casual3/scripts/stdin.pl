use strict;
use warnings;
use feature 'say';
use open ':encoding(utf8)';

{
    use utf8;
    my $text = "あいうえお";
    say length $text;
}

{
    use open IN => ':encoding(utf8)', OUT => ":encoding(shift-jis)"
    open my $fh, '<', 'template.html';
    my $text_utf8 = join '', <$fh>;
    close $fh;
    print $text_utf8;
}

__END__
while (<>) {
    print $_;
    warn utf8::is_utf8($_) ? "Text strings" : "Binary strings";
}
