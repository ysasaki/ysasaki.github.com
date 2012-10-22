#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use Test::More;
use Encode;

my $text = "あいうえお";

my $binary = encode_utf8($text);

isnt $binary, $text;
is decode_utf8($binary), $text;

done_testing;
