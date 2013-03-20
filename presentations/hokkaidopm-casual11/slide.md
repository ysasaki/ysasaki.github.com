Hokkaido.pm Casual#11
=====================

@aloelight

リクエスト特集
--------------

* ですが、気にせずなんかモジュール紹介

Benchmark
---------

    use v5.16;
    use warnings;
    use Benchmark qw(cmpthese);
    use Test::TCP;
    use Plack::Runner;
    use LWP::UserAgent;
    use Furl;

    my $server = Test::TCP->new(
        code => sub {
            my $port = shift;
            my $app = sub {
                [   200,
                    [ 'Content-Type' => 'text/plain' ],
                    ['Hello']
                ]
            };
            my $runner = Plack::Runner->new;
            $runner->parse_options(
                '--port', $port,
                '-E',     'production'
            );
            $runner->run($app);
        }
    );

    my $url = sprintf 'http://localhost:%d', $server->port;

    my $lwp  = LWP::UserAgent->new();
    my $furl = Furl->new;

    cmpthese(
        1000,
        {
            lwp  => sub { $lwp->get($url) },
            furl => sub { $furl->get($url) },
        }
    );


実行結果

                (warning: too few iterations for a reliable count)
           Rate  lwp furl
    lwp   840/s   -- -71%
    furl 2857/s 240%   --


Devel::NYTProf
--------------

* プロファイラ
* NYTはNewYorkTimes
* HTMLでいい感じに結果を表示できる
* Webアプリ用には[Plack::Middleware::Profiler::NYTProf](http://p3rl.org/Plack::Middleware::Profiler::NYTProf)とかある

----

使い方

    $ perl -d:NYTProf scripts/benchmark.pl
    実行してプロファイル結果をnytprof.outに吐き出す
    $ nytprofhtml
    nytporf/以下にhtml等が諸々と出てくる

Devel::KYTProf
--------------

* DBI, Furl, LWPとかその辺のプロファイラ
* *-d:KYTProf* or *use Devel::KYTProf* とかする

    $ perl -d:KYTProf scripts/kytprof.pl

例)

    use v5.16;
    use warnings;
    use DBI;
    use SQL::SplitStatement;
    use Data::Dumper;

    my $dbh = DBI->connect( 'dbi:SQLite:', '', '',
        { RaiseError => 1, AutoCommit => 1 } );

    my $sql = <<SQL;
    CREATE TABLE users (
        id integer primary key,
        name text not null
    );
    INSERT INTO users (name) VALUES ('ysasaki');
    INSERT INTO users (name) VALUES ('techno_neko');
    SQL

    my $splitter = SQL::SplitStatement->new;
    $dbh->do($_) for $splitter->split($sql);

    my @users = $dbh->selectall_arrayref('SELECT * FROM users', { Slice => {} });
    say Dumper(\@users);


----

使い方

    $ perl -d:KYTProf scripts/benchmark.pl
    $ perl -d:KYTProf scripts/kytprof.pl

Devel::Cycle
------------

* 循環参照を見つけられる

例)

    use v5.16;
    use warnings;
    use Devel::Cycle;

    my $test = {
        fred   => [qw(a b c d e)],
        ethel  => [qw(1 2 3 4 5)],
        george => {
            martha => 23,
            agnes  => 19
        }
    };
    $test->{george}{phyllis} = $test;
    $test->{fred}[3]         = $test->{george};
    $test->{george}{mary}    = $test->{fred};
    find_cycle($test);

おわり
------
