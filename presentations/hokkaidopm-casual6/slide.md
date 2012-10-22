Hokkaido.pm Casual#6
====================

@aloelight

今回のテーマはORM
-----------------

主なORM
-------

* Class::DBI
* DBIx::Class
* Data::ObjectDriver
* Rose::DB
* Data::Model
* DBIx::MoCo
* DBIx::Skinny
* Teng
* 等々

私のDB関連モジュール遍歴
------------------------

1. DBI
2. DBI + SQL::Abstract
3. Data::ObjectDriver
4. DBIx::Skinny
5. Teng

最近の流れ
----------

 - 基本は薄く，軽くの方向
   - 目立つ人が大規模な現場にいるからかも
 - ORMいるよ派
   - DBIx::ClassからDBIx::Skinny，Tengへ
   - 今からならTengでいいと思う
   - 最低限の機能が入ってる
 - ORMいらないよ派
   - DBIのsubclassで戦ったりしてる
   - Amon2::DBI
   - DBIx::Sunny

DBIのsubclass
--------------

[DBIx::Sunny](p3rl.org/DBIx::Sunny)を見るといいじゃないかと思います

参考リンク
----------

以下を読むといいんじゃないかと思います

「モダンPerlの世界へようこそ」
 - [第36回　SQL::Abstract：簡単なSQLはより簡単に](http://gihyo.jp/dev/serial/01/modern-perl/0036)
 - [第38回　DBIx::Class：拡張性の高さが売りではありますが](http://gihyo.jp/dev/serial/01/modern-perl/0038)
 - [第39回　DBIx::Skinny：DBIx::Classに不満を感じたら](http://gihyo.jp/dev/serial/01/modern-perl/0039)

その他
 - [very simple ORMapper Teng](http://yapcasia.org/2012/talk/show/3570fad2-d484-11e1-964b-37a36aeab6a4)
 - [Perl Advent Calendar Teng 2011](http://perl-users.jp/articles/advent-calendar/2011/teng/)
