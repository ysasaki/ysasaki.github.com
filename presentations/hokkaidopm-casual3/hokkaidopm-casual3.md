Hokkaido.pm Casual#3
====================

@aloelight

ファイル入出力
--------------

 - 入出力と言えばPerlIO

その前に
--------

Text StringsとBinary strings
----------------------------

 - PerlIOの前におさらい
 - `perldoc unitut`を読むとわかる

Text stringsとBinary strings
----------------------------

        use utf8;
        use strict;
        use Encode;
        use Test::More;

        my $text = "あいうおえ";

        my $binary = encode_utf8($text);

        is $binary, $text;
        is decode_utf8($binary), $text;

        done_testing;


ここから本題
------------

PerlIO Layerの使い方
--------------------

 - `open` pragma
   - pragma以降に`open`するファイルハンドルに影響する
   - `${^OPEN}`を変更してる
 - `binmode`
   - 指定したファイルハンドルだけ変更


使い方
------

        use open IN => ':encoding(utf8)', OUT => ':encoding(utf8)';
        use open IO => ':encoding(utf8)';
        use open ':encoding(utf8)';

        # 以下2つは上記3つとは挙動が違う
        use open qw/:std :encoding(utf8)/; # STD(IN|OUT|ERR)のLayerを変更
        use open ':locale';                # $ENV{LANG}からencodingを指定

        # 標準入出力を変更
        binmode STDIN,  ':encoding(utf8)';
        binmode STDOUT, ':encoding(utf8)';


実例 1/2
--------

        use utf8;
        use strict;
        use warnings;
        use open ':encoding(utf8)';

        open my $out, '>', 'out.txt';
        open my $in,  '<', 'word.txt';

        while (<$in>) {
            warn utf8::is_utf8($_) ? "Text strings" : "Binary strings";
            print $out $_;
        }

        close $in;
        close $out;

実例 2/2
--------

        use utf8;
        use strict;
        use warnings;
        use open ':std' => ':encoding(utf8)';

        while (<>) {
            print $_;
            warn utf8::is_utf8($_) ? "Text strings" : "Binary strings";
        }


ワンライナーの場合
------------------

    $ echo あいうえお | perl -CIO -pE 'say utf8::is_utf8($_) ? 1 : 0'

PerlIOを触ってみる
------------------

PerlIOの例
-----------

 - [PerlIO::gzip](https://metacpan.org/module/PerlIO::gzip)
 - [PerlIO::tee](https://metacpan.org/module/PerlIO::tee)

XS!!!
-----

 - はい、むりー
 - Casualじゃないよ！

Perlで書くためのPerlIO::via
---------------------------

 - [PerlIO::via](https://metacpan.org/module/PerlIO::via)
 - `tie`っぽい感じで必要なhookをPerlで実装していく

PerlIO::via::Collector64
------------------------

        package PerlIO::via::Collector64;

        use strict;
        use warnings;
        use Acme::Collector64;

        our $INDEX_TABLE = undef;

        sub import {
            my $class = shift;
            my ($index_table) = @_;
            $INDEX_TABLE = $index_table;
        }

        sub PUSHED {
            my ( $class, $mode, $fh ) = @_;
            bless {
                collector => Acme::Collector64->new( index_table => $INDEX_TABLE ),
                buf       => '',
            }, $class;
        }

        sub WRITE {
            my $self = shift;
            my ( $buf, $fh ) = @_;
            $self->{buf} .= $buf;
            return length($buf);
        }

        sub FLUSH {
            my $self = shift;
            my $fh   = shift;
            print $fh $self->{collector}->encode( $self->{buf} )
                or return -1;
            $self->{buf} = '';
            return 0;
        }

        1;

使ってみる
----------

    use strict;
    use Test::More;
    use PerlIO::via::Collector64;

    my $out = '';

    open my $fh, '>:via(Collector64)', \$out;
    print $fh 'aa';
    close $fh;

    is $out, 'YWE=', $out;

    done_testing;


参考URL
-------

 - [404 Blog Not Found | perl - use encoding; #は黒歴史](http://blog.livedoor.jp/dankogai/archives/51221731.html)
 - [404 Blog Not Found | perl - ワンライナーの書き方入門](http://blog.livedoor.jp/dankogai/archives/51026593.html)
 - [PerlIO::via で遊ぶ - JPerl Advent Calendar 2010 Acme Track](http://perl-users.jp/articles/advent-calendar/2010/acme/23)
 - [Acme::Collector64](https://github.com/akiym/Acme-Collector64)
