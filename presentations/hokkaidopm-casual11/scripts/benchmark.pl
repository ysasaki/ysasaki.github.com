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
            '-E', 'production'
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
