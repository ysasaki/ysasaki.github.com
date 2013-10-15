Hokkaido.pm Casual#18
=====================

@aloelight

続・Perlの開発環境
------------------

* Perlでの開発で必要なもの
 * Perl処理系
 * エディタ

Perl処理系
----------

 * plenvで最新の安定版を入れる
   * 今なら5.18.1
 * とりあえずsystem perlじゃなければいい
   * cpanmで好きなモジュールを入れられる
 * 複数のバージョンが必要なとき
   * CPAN Author
   * 商用、開発でバージョンが違う
 * インストール方法はplenv/README.mdに書いてある

エディタ
-------

 * 好きなエディタでよい
 * 私はVim

Vim
---

 * vim 7.3以上
 * Plugin管理はNeoBundle
 * 開発時に使ってるPlugin
   * gtags.vim
   * vim-ref
   * emmet-vim (旧zen-coding)
   * perlvalidate-vim
   * syntastic
   * neocomplcache
   * neosnippet
   * unite.vim
   * taglist.vim
   * vim-quickrun
