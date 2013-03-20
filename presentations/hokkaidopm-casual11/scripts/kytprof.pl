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

my $users = $dbh->selectall_arrayref('SELECT * FROM users', { Slice => {} });
say Dumper($users);
