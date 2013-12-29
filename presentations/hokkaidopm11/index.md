今年書いたPerlのコード
======================

Hokkaido.pm#11
@aloelight


EnvDir
------

    # Load environment variables from ./env
    use EnvDir -autoload;

    # You can specify a directory.
    use EnvDir -autoload => '/path/to/dir';

    # envdir function returns a guard object.
    use EnvDir 'envdir';

    $ENV{PATH} = '/bin';
    {
        my $guard = envdir('/path/to/dir');
    }
    # PATH is /bin from here


Text::Sass::XS
--------------

 - libsassのperl binding
 - Text::Sass
   - 別の人のPure Perl実装
 - CSS::Sass(libsass binding)
   - 元々あったやつ
   - ぶっ壊れてるから別に作った

P::M::Assets::RailsLike
-----------------------

 - RailsのAsset Pipelineのパクり
 - デフォルトの設定でもそこそこ動く
 - productionで使う場合はprecompilerを利用してください


        use strict;
        use warnings;
        use MyApp;
        use Plack::Builder;

        my $app = MyApp->new->to_app;
        builder {
            enable 'Assets::RailsLike', root => './htdocs';
            $app;
        };


Tamanegi
--------

 - PSGI Web Server
 - libonionを使用
   - Lightweight C library to add web server functionality to your program
   - pthread + epoll
     - kqueue対応がなかったので、MacOSで動かすために実装した
 - mod_perlを参考にしてpthread周りを書いたけど、負荷をかけると死ぬので未公開


Webistrano::Lite
----------------

 - capistrano3のWeb Frontend
 - Webistranoはcapistrano2系しか対応してない
 - 最低限できたところで放置
