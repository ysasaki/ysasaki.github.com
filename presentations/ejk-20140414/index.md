Hack/HHVM
======================

Yoshihiro Sasaki &lt;yosasaki at reado.jp&gt;


概要
----

 * facebookが開発
 * HipHopVirtualMachineの略
   * JITコンパイラ
 * PHPとHack用の実行環境
   * Hack = PHP + 静的型
 * 実行環境HHVMと言語のHack or PHPの組み合わせ
   * Java/JVM, C#/CLR, JavaScript/V8と一緒
 * 人気のフレームワーク（WAF以外も含む）を20個対応する予定らしい
   * [hphp/test/frameworks/frameworks.yaml](https://github.com/facebook/hhvm/blob/master/hphp/test/frameworks/frameworks.yaml)
   * codeigniter, composer, drupal, facebookphpsdk, kohana, laravel, mediawiki, meganto2, pear, phpunit, phpmyadmin, slim, symfonyなどなど

歴史的な話し
------------

1. PHPが遅いのでサーバコスト半端ねぇ
1. 2008年、HipHop作成
  * PHPをC++に変換してコンパイルすれば速くなる
  * 当時のZendより6倍速かったらしい
  * コンパイラ HPHPc, インタプリタ HPHPi, デバッガー HPHPd
1. 2010年 HPHPをOSSとして公開
1. 2010年 HHVMを作成
  * HPHPcとHPHPdのつじつまが合わなくなってきた
  * C++からコンパイルするのがしんどい
  * 速度的に頭打ちがみえてきた
1. 2012年 HHVMがHPHPcの速度を越える
1. 2013年 facebook.comをHHVMで稼働
1. 2014年 HHVM 3.0.0とHackをOSS化

Hackの機能
----------

 * Type Annotations
 * Generics
 * Nullable
 * Collections
 * Shapes
 * Type Aliasing
 * Async
 * Continuations
 * Constructor Argument Promotion

Type Annotations
----------------

PHP

    <?php
    class MyClass {
      const MyConst = 0;

      private $x;

      public function increment($x) {
        $y = $x + 1;
        return $y;
      }
    }

Hack

    <?hh
    class MyClass {
      const int MyConst = 0;

      private string 1x = '';

      public function increment(int 1x): int {
        1y = 1x + 1;
        return 1y;
      }
    }


Generics
--------


    <?hh
    class Box<T> {
      protected T $data;

      public function __construct(T $data) {
        $this->data = $data;
      }

      public function getData(): T {
        return $this->data;
      }
    }

    function main_gen() {
      $gi = new Box(3);
      $gs = new Box("Hi");
      $ga = new Box(array());
      echo $gi->getData()."\n";
      echo $gs->getData()."\n";
      echo $ga->getData()."\n";
    }

    main_gen();


Nullable
--------

    <?hh
    function check_not_null(?int $x): int {
      if ($x === null) {
        return -1;
      } else {
        return $x;
      }
    }

Collections
-----------

 * Vector/ImmVector
 * Map/ImmMap
 * Set/ImmSet
 * Pair


Vector

    $vector = Vector {5, 10, 15};

    $vector[] = 20;
    echo $vector[0] . "\n";
    echo $vector->get(1) . "\n";
    $vector[0] = 999;
    $vector->removeKey(2);

    foreach ($vector as $v) {
      echo $v . "\n";
    }

    for ($i = 0; $i < count($vector); ++$i) {
      echo $vector[$i] . "\n";
    }

    foreach ($vector as $k => $v) {
      echo $k . ": " . $v . "\n";
    }

Arrays
------

所謂PHPのArrayに相当する。Collectionsの方を使ってね

    class HackArrays<T> {
      private array $arr = null;
      private array<T> $arr2 = null;
      private array<string, string> $arr3 = null;

      public function __construct(T $data) {
        $this->arr2[0] = $data;
      }

      public function bar(T $data): void {
        $this->arr = array();
        var_dump($this->arr);
        $this->arr2[] = $data;
        var_dump($this->arr2);
        $this->arr3["hi"] = new Foo();
        var_dump($this->arr3);
      }
    }

Type Aliasing
-------------

Type Aliasing

    <?hh
    type MyInt = int;
    function foo(MyInt $mi): void {}

Opaque Type Aliasing

    <?hh
    newtype MyInt = int;
    function foo(MyInt $mi): void {}

Opaque Type Aliasingはファイルでスコープが区切られる

File1.php

    <?hh
    newtype MyInt = int;

File2.php

    <?hh
    require_once "File1.php";

    function foo(): MyInt { // Error!!
      return 1;
    }


Shapes
------


    type Point2D = shape('x' => int, 'y' => int);

    function dotProduct(Point2D $a, Point2D $b): int {
      var_dump($a);
      var_dump($b);
      return $a['x'] * $b['x'] + $a['y'] * $b['y'];
    }

    function main_sse(): void {
      echo dotProduct(shape('x' => 3, 'y' => 3), shape('x' => 4, 'y' => 4));
    }

    main_sse();


Async
-----

async/awaitが使える

    <?hh

    class Foo{}
    class Bar {
      public function getFoo(): Foo {
        return new Foo();
      }
    }

    async function gen_foo(int $a): Awaitable<?Foo> {
      if ($a === 0) {
        return null;
      }

      $bar = await gen_bar($a);
      if ($bar !== null) {
        return $bar->getFoo();
      }

      return null;
    }

    async function gen_bar(int $a): Awaitable<?Bar> {
      if ($a === 0) {
        return null;
      }

      return new Bar();
    }


    gen_foo(4);

Tuples
------

固定サイズのArray

    $tup = tuple('3', 2, 3, 4, 'hi');

Override Attribute
------------------

    // file1.php
    <?hh

    class CParent {
      public function doStuff(): void {
        return $this->implementation();
      }
      protected function implementation(): void {
        echo 'parent implementation', "\n";
      }
    }

    // file2.php
    <?php
    class Child extends CParent {
      <<Override>> protected function implementation(): void {
        echo 'child implementation', "\n";
      }
    }

Constructor Argument Promotion
------------------------------


よくあるクラス定義

    <?hh

    class Person {
      private string $name;
      private int $age;

      public function __construct(string $name, int $age) {
        $this->name = $name;
        $this->age = $age;
      }
    }

短く書ける

    <?hh
    class Person {
      public function __construct(private string $name, private int $age) {}
    }

HHVMの機能
----------

 * FastCGIプロトコルを使用
   * 2系まではHTTPもサポートしていたが、3系から廃止
   * Nginx or Apacheあたりをフロントに置く必要がある
 * アプリケーション用サーバの他にいろいろあるけど、Administration Server以外は試してない
   * Administration Server
   * RPC Server
   * Internal Page Server
   * Xbox Server
     - cross-machine communication
   * Proxy Server
 * Single Process, Multi-Threads, Non-blockingなアーキテクチャ
   * I/O worker x1 がコネクション待ち受け
   * I/O worker xn がその後を担当
   * HHVM worker xn がアプリケーションコードを実行

サーバの起動
------------

こんな感じで起動する

    > hhvm --mode server -vServer.Type=fastcgi -vServer.Port=9000

FastCGIプロトコルなのでNginx等を挟んでアクセスする。

Nginxの設定

    root /path/to/your/www/root/goes/here;
    fastcgi_pass   127.0.0.1:9000;
    fastcgi_index  index.php;
    fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include        fastcgi_params;

サーバの設定
------------

config.hdfに書いて読み込ませる。php.iniも読むらしい。
色々とドキュメントが不足していて、どれが有効でどれが無効かわからない。
廃止されているのも混じってたりする

config.hdf

    Server {
      Mode = fastcgi
      Port = 9000
    }
    Eval {
      JitASize = 10485760 # 10 MB
      JitAStubsSize = 10485760 # 10 MB
      JitGlobalDataSize = 2097152 # 2 MB
      EnableZendCompat = true
    }
    MySQL {
      ReadTimeout = 5000
    }
    ErrorHandling {
      NoticeFrequency = 1
      WarningFrequency = 1
    }

php.ini

    [date]
    date.timezone = Asia/Tokyo

    [php]
    error_reporting = E_ALL & ~E_NOTICE

    [hhvm]
    hhvm.eval.jit = false

結局使えるのか
--------------

既存プロジェクトの場合

 * まだ早い
   * ドキュメントの整備不足
   * 既存プロジェクトが動くか大分怪しい
 * 使える時期が来ないかも知れない
   * KohanaくらいならGWでHack対応できるんじゃね？

新規プロジェクトの場合

 * きちんと動くWAFがあるならいいかも
 * PHPに型をつけただけなので、乗り換えやすい
 * メンバーがPHP以外も書けるようなら、別言語でいい気がする

終わり
-----

ご清聴ありがとうございました。
