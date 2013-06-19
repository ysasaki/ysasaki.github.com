Hokkaido.pm Casual#14
=====================

@aloelight

自己紹介
---------

![icon](http://www.gravatar.com/avatar/b4ff5cbfba3187bf486733b00653950c.png)

 - Twitter @aloelight
 - github ysasaki
 - Webプログラマ
 - 業務ではPerlがメイン
 - 守備範囲はインフラからアプリ開発、保守・運用あたり
 - 最近やっているゲームはWorld of Tanks, Scrollsとか

ワンライナー特集
----------------

 - `perl -E 'say "One Liner!!"'`
 - perlのオプションを幾つか覚えるとよい


覚えるべきオプション
--------------------

 - `perldoc perlrun`に書いてあるよ

-----

 - `-E`, `-e`
   - 引数を実行する。新しいperlだと`-E`を使えて、`say`とか使えるようになる
 - `-l`
   - `print`に改行を自動で付けてくれる。`-E`が使えない場合には`print`が`say`の変わりになる
 - `-M`
   - いわゆる`use`。`-MFile::Basename`なら`use File::Basename`になる
 - `-n` と`-p`
   - 標準入力を受け取るときに、各行毎に実行してくれる

            > cat user.dat
            techno-nantoka
            aloelight

            > cat user.dat | perl -nle 'print "$. $_"'
            1. techno-nantoka
            2. aloelight

   - `-p`の場合は最後に自動で`$_`をprintしてくれる
   
            > cat user.dat | perl -pe 's/nantoka/neko/'
            techno-neko
            aloelight

 - `-a` と `-F`
   - `$_`を`' '`でsplitして`@F`に入れる
   - `-F`でsplitに使うパターンを指定できる
 
            > cat user.dat | perl -F/-/ -naE 'say $F[0]'
            techno
            aloelight

 - `-i`
   - 出力したデータでファイルの書き換え
   - 引数で書き換え前のデータをrenameして保存できる

            > cat user.dat
            techno-nantoka
            aloelight

            > perl -i.bak -pe 's/nantoka/cat/' user.dat
            > cat user.dat
            techno-cat
            aloelight

            > ls -1
            user.dat
            user.dat.bak

困ったときのオプション
----------------------

挙動がよくわからないときは`-MO=Deparse`を付けると捗る

        perl -MO=Deparse -i.bak -pe 's/nantoka/neko/' user.dat
        BEGIN { $^I = ".bak"; }
        LINE: while (defined($_ = <ARGV>)) {
            s/nantoka/neko/;
        }
        continue {
            die "-p destination: $!\n" unless print $_;
        }
        -e syntax OK

イディオムっぽい感じ
--------------------

 - find(ack)と一緒に

        find . -type f | perl -MString::CamelCase=camelize -MFile::Basename -nE 'chomp; ($base, undef, $suffix) = fileparse($_, ".rb"); $dst = camelize($base) . $suffix; say $dst; rename $_, $dst'

 - find(ack) + xargsと一緒に

        find {bin,lib,t} -type f -name '*.pm' | xargs perl -i -pe 's/Dancer/Dancer2/g'

        ack 'Ads::C::' lib/ t/ -l | xargs perl -i -pe 's/Ads::C::/Ads::Controller::/g'
        

 - END blockを使って最後のみ表示

        cat cleaning-log | cut -d' ' -f1 | perl -nle '$t+=$_; END {print "total: $t"}'

 - なんとなくその場でstaticファイルを垂れ流したいとき
 
        plackup -ML -e 'Plack::App::Directory->new->to_app'

 - 適当な文字列がほしい

        perl -ML -E 'say String::Random->new->randregex("[0-9a-za-Z]{16}")'

 - 整形して違うコマンド実行

        cat slave | perl -nle 'chomp; system qw/whois -h whois.jprs.jp/, $_; sleep 5' | tee out

 - bytes数の単位の変換

        perl -le 'print 1774724773 / (1024**3)'

ワンライナー向けモジュール
--------------------------

 - [L](http://p3rl.org/L)
 - [IO::All](http://p3rl.org/IO::All)


おわり
-----
