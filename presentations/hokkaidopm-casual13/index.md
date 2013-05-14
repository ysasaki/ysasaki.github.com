Hokkaido.pm Castual#13
======================

@aloelight

自己紹介
---------

 - Twitter @aloelight
 - github ysasaki
 - Webプログラマ
 - 業務ではPerlをメインで使う
 - 守備範囲はインフラからアプリ開発、保守・運用あたり

モダンModule入門
----------------

 - 今回はモジュールの作り方
 - blessを使わないOOPなモジュールの書き方は[Casual#8 モジュール定義入門](https://github.com/ysasaki/ysasaki.github.com/blob/master/presentations/hokkaidopm-casual8/slide.md)で解説済み

Perl Moduleの大事なお約束
-------------------------

 - ファイル構造をCPAN形式に合わせる
   - cpan, cpanmからinstallできる

CPAN形式の例
------------

    Bar/
    ├── Changes
    ├── MANIFEST  
    ├── Makefile.PL
    ├── README
    ├── lib
    │   └── Bar.pm
    └── t
        └── Bar.t

 - 手で作るのは面倒なので、こういう雛形を書きだすツールを使う
 - Makefile.PLやBulid.PLは必要な項目を思い出すのが大変
 - ツールを使うと必要なkeyは書いてあるので、書き換えるだけになる

雛形生成用ツール
----------------

 - h2xs
   - perlに添付されているので大体どこにでもある
   - どこでも使えるので、私はよくこれを使ってる
 - pmsetup
   - 1枚のスクリプト
   - githubとかで有名Perl Mongerが公開しているcodeをもってきて自分用に書き換えて使う
   - アップデートされないだろうし、お薦めしない
 - module-starter(Module::Starter)
   - Pluginが書けた気がする
   - h2xs使うならこっちのほうがいい
 - module-setup(Module::Setup)
   - プラガブルな作り
   - かなり柔軟で、このスライドの雛形もmodule-setupで作ってたりするが普段は使わない
 - dzil(Dist::Zilla)
   - Moose使ってたりと依存が多くてでかい
   - 超絶プラガブル
   - Pluginで雛形作成からCPANへリリースまで可能
   - どのPluginを使えばいいのか悩むので素人にはお薦めしない
 - milla(Dist::Milla)
   - 世界のmiyagawaがいい塩梅にdzilのpluginをまとめたもの
 - minil(Minilla)
   - dzilをsimpleにしたもの
   - 雛形生成からgithubへのpush, CPANにリリースまで出来る
 - dist-maker(Dist::Maker)
   - 使ったこと無いからよくわかりません
   - gfxさん作

独断で選ぶお薦めツール
----------------------

 1. minil(Minilla)
   - Pure Perlだとか色々制限があるが大抵は問題ないはず
   - Pluginとかないから迷う必要もない
   - 小さいのでインストールしやすい
   - まだまだ更新されそうなのでたまにアップデートしたほうがいいかも
 1. milla(Dist::Milla)
   - minilで足りなければこれ
 1. module-starter(Module::Starter)
   - ExtUtil::MakeMakerやModule::Build、Module::Installのどれを使うか選べる
   - リリース作業は別途shipitを使う
 1. h2xs
   - ExtUtil::MakeMakerしか使えないけど、標準で付いてくる
   - リリース作業は別途shipitを使う

おわり
-----
