#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use feature qw(say);

my $n = my $m = 1;

plan tests => 2;
ok $n == $m;
ok $n != $m;
