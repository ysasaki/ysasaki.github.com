Hokkaido.pm Casual#17
=====================

@aloelight

はじめてのPerlデバッグ
----------------------

* perl -d
  * perldoc perldebug

printデバッグ
-------------

* print文を書いていく


        use strict;
        use warnings;
        use Data::Dumper;

        my $foo = [1,2,3];
        print Dumper($foo);

Smart::Comments
---------------

* [Smart::Comments](http://p3rl.org/Smart::Comments)
* ###等を使ってプリントデバッグできる
* use Smart::Commentsは書かないほうがいい
* perl -MSmart::Comments smart-comments.pl

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

perl -d
-------

* perldoc perldebug
* gdbライクなCUIのデバッガ
* ブレークポイント置いたり、ステップ実行したりできる

        perl -d foo.pl

dtrace
------

* 5.10から徐々にサポート
* usedtraceを有効にしてbuildする必要あり
* perldoc perldtrace

その他
------

* Data::Dumper array, hashに
* Devel::Peek perlのデータ構造が見れる
* Devel::Cycle 循環参照を探す
* Vim::Debug vim上からperl debuggerを動かす。vimを--with-perl付きでbuildする必要あり
