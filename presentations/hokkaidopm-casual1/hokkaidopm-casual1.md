fluxflex
========

Hokkaido.pm Casual#1
[@aloelight](https://twitter.com/#!/aloelight)


fluxflexとは
------------

 - The fastest way to launch your web services.
 - PaaS
 - perl-5.10.1
 - Apache 2.2.17 + mod\_fastcgi(?)
 - MySQL 5.5.12

PaaS比較
--------

 - heroku
   - Perl使えません
 - dotCloud
   - 値段とか考えると個人向けじゃないっぽい
 - fluxflex
   - 個人向けっぽい[価格設定](https://www.fluxflex.com/settings/billing)

なんでPaaS？
-----------

 - Webアプリを作ってすぐ公開したい
 - サーバ設定・運用って大変
 - rails + heroku が羨ましかった

Dancerを動かしてみよう
----------------------

1. アカウント登録
-----------------

[登録画面](http://www.fluxflex.com/registrations?)から普通に登録

登録方法は以下の3つ

 - email + password
 - twitter
 - facebook

2. SSH公開鍵の登録
--------------

公開鍵を登録する

 1. `ssh-keygen -t rsa -b 2048 -f fluxfex`
 1. pbcopy < fluxflex.pub
 1. [登録画面](http://www.fluxflex.com/settings/pubkeys)に貼り付け

3. プロジェクト作成
-------------------

 - デフォルトのを削除して、新規作成
 - Setup > Git からclone用のコマンドをコピー
 - 自分のローカルにclone

4. プロジェクト修正
-------------------------

        dancer -a MyApp
        cp -r MyApp/ clone-path/
        cd clone-path/
        ln -s public public_html
        vim public_html/.htaccess
        vim .flx

5. .htaccess
------------

        AllowOverride None
        Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
        Order allow,deny
        Allow from all
        AddHandler fastcgi-script .fcgi
        RewriteEngine On
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteRule ^(.*)$ /dispatch.fcgi$1 [QSA,L]

6. .flx
-------

        [deploy]
        cpanm -L local -v --notest --installdeps .

        [setup]
        bash cpanm-setup.sh

6-2. cpanm-setup.sh
-------------------

        #!/bin/bash
        curl -kL http://install.perlbrew.pl | bash
        echo 'source ~/perl5/perlbrew/etc/bashrc' >> ~/.bashrc
        bash
        perlbrew install-cpanm
        cpanm -L local YAML Dancer Plack
        cpanm -L local --notest --installdeps .

7. Setup & Deployを実行
-----------------------

 - pushしたらdeployされるけど、setupを行いたいので手動で実行
 - 完了したらサイトにアクセス！

残念でした！動きません！
-------------------

試行錯誤してみる
------------

 1. "|"が食われた
   - setupをshell scriptに変更
 1. deploy操作が600secでタイムアウトする
   - cpanmに--notestを追加
 1. まだタイムアウト
   - cpanm -Lを-lに変更

やっぱりダメでした
------------------

次回に続くかも……
