Perl Beginners#10 LT
====================

Hokkaido.pm
@aloelight

Smart::Comments
---------------

 * コメントを使ってprintデバッグ
 * 内部はSource Filtersを使って実装
   * 詳しく知りたい人はperldoc perlfilter

この資料について
----------------

 * Hokkaido.pm Casual#17でのLT資料の改変
 * スライド
   * https://ysasaki.github.io/presentations/perl-beginners10/
 * リポジトリ
   * https://github.com/ysasaki/ysasaki.github.com/presentations/perl-beginners10/

使用例
------

<font color="#ffcc00">###</font>を使ってprintデバッグ

    use strict;
    use warnings;
    use feature qw(say);

    my $foo = [1,2,3,4,5];
    ### $foo

    my $bar = { foo => 1, bar => 2 };
    ### $bar

    for (1..10) { ### Working--->  done
        sleep 1;
    }

    say "スクリプト終了";


実行結果

    > perl -MSmart::Comments demo01.pl
    ### $foo: [
    ###         1,
    ###         2,
    ###         3,
    ###         4,
    ###         5
    ###       ]
    
    ### $bar: {
    ###         bar => 2,
    ###         foo => 1
    ###       }
    スクリプト終了

ループ部分はプログレスバーが表示される

    Working>                       done
    Working------>                 done
    Working------------>           done
    Working-------------------->   done


ポイント
--------

 * コアモジュールじゃないので<font color="#ffcc00">cpanm Smart::Comments</font>でinstall
 * 通常のprintデバッグのように消し忘れがない
 * スクリプト内に<font color="#ffcc00">use Smart::Comments</font>しない
   * <font color="#ffcc00">perl -MSmart::Comments foo.pl</font>のように使う
   * 環境変数で指定する方法もあるけどお薦めしない


デバッグレベルの調整
--------------------

    use strict;
    use warnings;
    use feature qw(say);

    my $foo = [1,2,3,4,5];
    ### $foo

    my $bar = { foo => 1, bar => 2 };
    #### $bar

    for (1..10) { ##### Working--->  done
        sleep 1;
    }

    say "スクリプト終了";

* -MSmart::Comments=###だと$fooだけ出力
* -MSmart::Comments=####だと$barだけ出力
* -MSmart::Comments=#####だとループ部分だけ出力
* 複数のレベルを出したい時は<font color="#ffcc00">カンマ区切り</font>で指定
  * -MSmart::Comments=###,####


アサーション機能
----------------

    use strict;
    use warnings;
    use feature qw(say);

    sub subtract {
        my ($x, $y) = @_;
        ### require: $x >= $y
        say $x - $y;
    }

    subtract(2,1);
    subtract(2,2);
    subtract(2,3);

    say "スクリプト終了";

実行結果

    > perl -MSmart::Comments demo03.pl
    1
    0

    ### $x >= $y was not true at demo03.pl line 7.
    ###     $x was: 2
    ###     $y was: 3


まとめ
------

 * 消し忘れがないのは安心
 * プログレスバーはかっこいい
 * use Smart::Commentsじゃなくて、<font color="#ffcc00">perl -MSmart::Comments</font>する
 * Source Filters使ってるからあまり速くないよ


\__END__
-------

ご清聴ありがとうございました
