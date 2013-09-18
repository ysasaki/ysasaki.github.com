use strict;
use warnings;
use Data::Dumper;

my $foo = [1,2,3];
print Dumper($foo);

my $bar = bar($foo);
print Dumper($bar);

sub bar {
    my $foo = shift;
    my @bar = map { $_ * 2 } @$foo;
    return \@bar;
}
