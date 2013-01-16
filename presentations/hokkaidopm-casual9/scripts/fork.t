use strict;
use warnings;
use Test::More;
use Test::SharedFork;

plan tests => 10;

my $pid = fork();
if ( $pid == 0 ) {
    ok 1, "child $_" for 1 .. 5;
}
elsif ($pid) {
    ok 1, "parent $_" for 1 .. 5;
    waitpid($pid, 0);
}
else {
    die "eheheh";
}

#done_testing; # ←これは上手く動かない
