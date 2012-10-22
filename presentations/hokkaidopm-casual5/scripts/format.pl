#!/usr/bin/env perl

use v5.14;
use warnings;

# Header部分
format STDOUT_TOP =
@<<<<< @|||||||||| @>>>>>>>>>>>>>>>
qw/Time Speaker Title/
.

# 出力したいデータ
my @line = (
    ['19:00', 'techno_neko', 'opening'],
    ['19:10', 'someone', 'foobar'],
);

# 出力
for (@line) {
    format STDOUT =
@<<<<< @|||||||||| @>>>>>>>>>>>>>>>
@$_
.
    write;
}

format STDOUT =
@<<<<< @|||||||||| @>>>>>>>>>>>>>>>
qw/aa bbbbb cccc/
@<<<<< @|||||||||| @>>>>>>>>>>>>>>>
qw/aa bbbbb cccc/
@<<<<< @|||||||||| @>>>>>>>>>>>>>>>
qw/aa bbbbb cccc/
.

write;


