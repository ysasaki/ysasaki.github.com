use strict;
use warnings;
use feature qw(say);

my $foo = [1,2,3,4,5];
### $foo

my $bar = { foo => 1, bar => 2 };
### $bar

for (1..10) { ### Working--->  done
    sleep 10;
}

say "スクリプト終了";
