#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

my $n = my $m = 1;

say '1..2';
say $n == $m ?  'ok 1'  : "not ok 1";
say $n != $m ?  'ok 2'  : "not ok 2";
