use utf8;
use strict;
use warnings;
use FindBin qw($Bin);
use File::Spec::Functions qw(catdir catfile);
use lib catdir( $Bin, 'lib' );
use D::Schema;
use SQL::SplitStatement;
use Test::More;

my $dsn = sprintf 'dbi:SQLite:';
my $schema = D::Schema->connect( $dsn, '', '',
    { RaiseError => 1, AutoCommit => 1, sqlite_unicode => 1 } );

setup_db($schema);

subtest 'lookup artists.id == 1' => sub {

    # primary keyで取得
    my $artist = $schema->resultset('Artist')->find(1);
    isa_ok $artist, 'D::Schema::Result::Artist';
    is $artist->id,   1,             'id ok';
    is $artist->name, 'techno_neko', 'name ok';

    # 付属するCD情報をげっと
    my @cd = $artist->cds->all();

    subtest 'cds.id == 1' => sub {
        isa_ok $cd[0], 'D::Schema::Result::Cd';
        is $cd[0]->id, 1, 'id ok';
        is $cd[0]->title,
            '初代エルティニスト　スーパーベスト', 'title ok';
    };

    subtest 'cds.id == 2' => sub {
        isa_ok $cd[1], 'D::Schema::Result::Cd';
        is $cd[1]->id, 2, 'id ok';
        is $cd[1]->title, '根は飽きた', 'title ok';
    };

};

subtest 'search' => sub {
    my $artist = $schema->resultset('Artist')->search( { name => 'techno_neko' });
    while ( my $row = $artist->next ) {
        is $row->name, 'techno_neko', 'techno_neko!!';
    }
};

subtest 'insert' => sub {
    my $aloelight = $schema->resultset('Artist')->create(
        { name => 'aloelight' }
    );

    isa_ok $aloelight, 'D::Schema::Result::Artist';
    is $aloelight->id, 3, 'id ok';
    is $aloelight->name, 'aloelight', 'name ok';
};

subtest 'find_or_create' => sub {

    # INSERTするケース
    my $akiym = $schema->resultset('Artist')->find_or_create(
        { name => 'akiym' }
    );

    isa_ok $akiym, 'D::Schema::Result::Artist';
    is $akiym->id, 4, 'id ok';
    is $akiym->name, 'akiym', 'name ok';

    # INSERTしないケース
    my $aloelight = $schema->resultset('Artist')->find_or_create(
        { name => 'aloelight' }
    );

    isa_ok $aloelight, 'D::Schema::Result::Artist';
    cmp_ok $aloelight->id, '<', $akiym->id, 'aloeligt.id < akiym.id';
};

subtest 'update' => sub {

    # name == techno_nekoのレコードをアップデート
    my $ret = $schema->resultset('Artist')
        ->search({ name => 'techno_neko' })
        ->update({ name => 'LT大好き' });
    ok $ret, 'update techno_neko';

    # updateされたか確認
    my $techno_neko = $schema->resultset('Artist')->find(1);
    is $techno_neko->name, 'LT大好き', 'renamed';

    # 今度は別の方法でupdate
    $techno_neko->name('techno_neko');
    my $updated_techno_neko = $techno_neko->update;
    isa_ok $updated_techno_neko, 'D::Schema::Result::Artist';
    is $updated_techno_neko->id, $techno_neko->id, 'id ok';
    is $updated_techno_neko->name, 'techno_neko', 'renamed';
};

done_testing;

sub setup_db {
    my $schema = shift;
    $schema->storage->dbh_do(
        sub {
            my ( $storage, $dbh ) = @_;
            my $stmt = join '', <DATA>;
            my @statements = SQL::SplitStatement->new->split($stmt);
            for (@statements) {
                $dbh->do($_) or die $dbh->errstr;
            }
        },
    );
}

__DATA__
DROP TABLE IF EXISTS artists;
CREATE TABLE artists (
    id integer not null,
    name text not null,
    primary key(id)
);

DROP TABLE IF EXISTS cds;
CREATE TABLE cds (
    id integer not null,
    artists_id integer not null,
    title text not null,
    primary key(id),
    foreign key(artists_id) references artists(id)
);

INSERT INTO artists (name) VALUES ('techno_neko');
INSERT INTO artists (name) VALUES ('onagatani');
INSERT INTO cds (artists_id, title) VALUES (1, '初代エルティニスト　スーパーベスト');
INSERT INTO cds (artists_id, title) VALUES (1, '根は飽きた');
INSERT INTO cds (artists_id, title) VALUES (2, '活イカ到来');
