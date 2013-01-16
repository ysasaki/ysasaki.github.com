Hokkaido.pm Casual#8
====================

[@aloelight](https://twitter.com/aloelight)


モジュール定義入門
------------------

 - どうやってモジュール定義を書くのか
 - クラスビルダーを使って楽をしたい
   - Moose, Mouse, Class::Accessorとか

有名な例
--------

Moose有り・無しの比較を[Introduction to Moose](http://www.houseabsolute.com/presentations/intro-moose-class/index.html)から抜粋


Moose有り
---------

        package Person;
        use Moose;

        has last_name => (
            is  => 'rw',
            isa => 'Str',
        );

        1;


Moose無し
---------

        package Person;
        use strict;
        use warnings;
        use Carp 'confess';

        sub new {
            my $class = shift;
            my %args  = @_;
            my $self  = {};

            if (exists $args{last_name}) {
                confess "Attribute (last_name) does not pass the type constraint because: "
                        . "Validation failed for 'Str' with value $args{last_name}"
                    if ref($args{last_name});
                $self->{last_nane} = $args{last_name};
            }

            return bless $self, $class;
        }

        sub last_name {
            my $self = shift;

            if (@_) {
                my $value = shift;
                confess "Attribute (last_name) does not pass the type constraint because: "
                        . "Validation failed for 'Str' with value $value"
                    if ref($value);
                $self->{last_name} = $value;
            }

            return $self->{last_name};
        }

        1;


コードが短いことは正義
----------------------

 - どちらも普通に読み下せるレベルのコードなら、コードが短い方がバグは少ない
 - ビジネスロジックに集中すべきであって、アクセサでプログラミングの時間を取るべきではない
 - クラスビルダーを使っていいなら、使ってしまおう


クラスビルダー紹介
------------------

Moose系
-------

 - Moose
   - 多機能だけどコンパイルタイムが長い、メモリ食う。依存モジュール多し
 - Mouse
   - Mooseのサブセットでコンパイルタイム問題を多少解消してる。動作も速い。標準モジュールのみに依存
 - Moo
   - Mouseよりもさらに小さいサブセット。最近人気上昇中
 - Any::Moose
   - MooseなければMouseをかわりにロードする


Class::Accessor系
-----------------

 - Class::Accessor
   - アクセサを生成。いつのまにかMoose-likeな書き方も可能になった
 - Class::Accessor::Fast
   - Class::Accessorよりもちょっと速い。Class::Accessorに含まれる。
 - Class::Accessor::Faster
   - Class::Accessor::Fastよりもちょっと速い。Class::Accessorに含まれる。
 - Class::XSAccessor
   - XSなので速い
 - Class::Accessor::Fast::XS
   - Class::Accessor::Fast互換をXSで実装。速い
 - Class::Accessor::Lite
   - 小さい。Class::Accessorの依存問題を解決してたりとか

その他
------

 - Class::Struct
   - 標準モジュール
 - Object::Simple
   - Mojo::Baseっぽい感じ


どれを使えばいいのか
--------------------

一概にコレとは言えません


自分で使っているもの
--------------------

 - Moose
 - Mouse
 - Moo
 - Class::Accessor::Lite


選択方針
--------

 - Any::Mooseは使わない
   - 書き方が気に食わない。憶えるのもめんどくさい
 - プロジェクトで既に使っているモジュールに合わせる
   - Mooseが既にあるなら、Mooseでもよいではないか
 - 他のプロジェクトでも使用するライブラリは依存の少ないものを選ぶ
   - Class::Accessor, Class::Accessor::Liteあたりは有り
   - もしくは使わない
 - プロジェクトの規模がある程度あれば、Moo(Mouse)はあり
   - 自前クラスに親子関係がある or 二桁に届きそうなくらいの規模感から
   - before, after, around等のmethod modifierはあると便利
   - 2,30モジュール入れるなら、Moo(Mouse)が増えてもどうってことない


サンプルコード
--------------

大体同じ感じの処理を書いてみる

ビルダーを使わない場合

        package Person;

        use strict;
        use warnings;

        sub new {
            my $class = shift;
            my %self  = (
                first_name => undef,
                last_name  => undef,
                @_
            );
            bless \%self, $class;
        }

        sub first_name {
            my $self = shift;
            if ( @_ ) {
                $self->{first_name} = $_[0];
            }
            $self->{first_name};
        }

        sub last_name {
            my $self = shift;
            if ( @_ ) {
                $self->{last_name} = $_[0];
            }
            $self->{last_name};
        }

        1;

Mooで書く

        packge Person;

        use Moo;

        has first_name => (is => 'rw');
        has last_name  => (is => 'rw');

        1;


Class::Accessor::Liteで書く

        package Person;

        use strict;
        use warnings;
        use Class::Accessor::Lite (
            new => 1,
            rw  => [qw(first_name last_name)]
        );

        1;


まとめ
------

 - 自分の環境にあったクラスビルダーを使いましょう
 - 個人的にはMoo, Class::Accessor::Liteが良いと思います
