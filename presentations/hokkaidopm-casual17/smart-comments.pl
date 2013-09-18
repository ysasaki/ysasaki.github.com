use strict;
use warnings;

my $foo = [ 1, 2, 3 ];
### $foo

my $n = 1;
my $m = 2;

### require: $n < $m
print $m - $n, "\n";

eval {
    my $i = 2;
    my $j = 1;

    ### require: $i < $j
    print $m - $n, "\n";
};

my @values = ( 1 .. 10 );
for (@values) {    ### Progressing===>  done
    sleep 1;
}

### Done!!
