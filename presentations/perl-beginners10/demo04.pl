use strict;
use warnings;
use feature qw(say);

sub subtract {
    my ($x, $y) = @_;
    ### check: $x >= $y
    say $x - $y;
}

subtract(2,1);
subtract(2,2);
subtract(2,3);

say "スクリプト終了";
