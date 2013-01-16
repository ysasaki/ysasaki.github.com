#!/usr/bin/env perl

use strict;
use warnings;

print <<EOM;
1..2
ok 1 - 1番成功
# これはコメント
not ok 2 - 2番は失敗
EOM
