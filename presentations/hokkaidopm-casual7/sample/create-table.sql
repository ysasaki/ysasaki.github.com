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
