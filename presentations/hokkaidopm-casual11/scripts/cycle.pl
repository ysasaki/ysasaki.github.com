use v5.16;
use warnings;
use Devel::Cycle;

my $test = {
    fred   => [qw(a b c d e)],
    ethel  => [qw(1 2 3 4 5)],
    george => {
        martha => 23,
        agnes  => 19
    }
};
$test->{george}{phyllis} = $test;
$test->{fred}[3]         = $test->{george};
$test->{george}{mary}    = $test->{fred};
find_cycle($test);
