use strict;
use warnings;
use Test::More;
use Test::Exception;
use Foo;

is Foo::sum(1), 1;
is Foo::sum( 1, 2 ), 3;
is Foo::sum( 1, 2, 3 ), 6;
is Foo::sum( 1, 2, 3, 'foo' ), 6, 'skip strings';
is Foo::sum( [ 1, 2, 3 ] ), 6, 'ArrayRef';
dies_ok { Foo::sum( {} ) }, 'die if arg1 is a HashRef';

done_testing;
