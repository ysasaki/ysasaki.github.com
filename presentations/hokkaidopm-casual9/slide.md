Hokkaido.pm Casual#9
====================

@aloelight

今回のテーマは『テスト』
-----------------------

 * Perlのテストの仕組み
 * TDDの話し
 * 私が使うモジュール

Perlのテストの仕組み
--------------------

[TAP - Test Anything Protocol](http://en.wikipedia.org/wiki/Test_Anything_Protocol)を吐き出す個々のテストファイルを、prove(1)が[TAP::Harness](https://metacpan.org/module/TAP::Harness)を起動して、いい感じに解釈してくれる。

hirataraさんの[perlのテストの仕組み(TAP::Harness) - 北海道苫小牧市出身のPGが書くブログ](http://d.hatena.ne.jp/hiratara/20090320/1237542892)にもう少しちゃんとした解説があります。

TAPの概要
---------

標準出力に以下のようなフォーマットで出力する

    1..2                  # テストの数
    ok 1 - $n == $m       # 行頭が ok なら成功
                          # ハイフン以降にテスト名等を書ける
    # comment             # #はコメント文になる
    not ok 2 - $n !== $m  # 行頭が not ok なら失敗

通常自分では書かないでTest::More等を使う


テストの実行
------------

複数のテストを実行するときはprove(1)を使う

    prove scripts/*.t

prove(1)がTAPの出力を解析してくれるので、詳細な結果を見たい場合は直接実行するといいかもしれない

    perl scripts/foo.t

DEMO
----

 - モジュールを作成しながら、テストを書いてみる

        $ h2xs -AXc --skip-exporter -n Foo


私が使うTest::\*モジュール
--------------------------

 * Test::More
 * Test::Exception
 * Test::Base::Less
 * Test::MockObject
 * Test::Mock::Guard
 * Test::TCP
 * Test::mysqld
 * Test::Fixture::DBI
 * DBIx::DataFactory
 * Plack::Test

告知
----

Hokkaido.pm #9 2013年3月9日(土）

おわり
------
