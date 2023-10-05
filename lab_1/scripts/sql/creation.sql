CREATE TABLE if not exists fighters
(
    id              SERIAL  PRIMARY KEY,
    first_name      VARCHAR(100),
    last_name       VARCHAR(100),
    age             INTEGER,
    gender          VARCHAR(6),
    club_id         INTEGER
);

CREATE TABLE if not exists clubs
(
    id              SERIAL  PRIMARY KEY,
    club_name       VARCHAR(100),
    found_date      DATE,
    branch_count    INTEGER,    
    town            VARCHAR(50)
);

CREATE TABLE if not exists nominations
(
    id              SERIAL  PRIMARY KEY,
    nomination_name VARCHAR(100),
    min_age         INTEGER,
    max_age         INTEGER,
    weight_category VARCHAR(10),
    gender          VARCHAR(6),
    battle_scheme   VARCHAR(20)
);

CREATE TABLE if not exists judges
(
    id              SERIAL  PRIMARY KEY,
    first_name      VARCHAR(100),
    last_name       VARCHAR(100),
    experience      FLOAT,
    category        SMALLINT,
    salary          INTEGER
);

CREATE TABLE if not exists tournament
(
    id              SERIAL  PRIMARY KEY,
    fighter_id      SERIAL,
    nomination_id   SERIAL,
    warnings        INTEGER,
    applied_hits    INTEGER,
    skipped_hits    INTEGER
);

CREATE TABLE if not exists judging
(
    id              SERIAL  PRIMARY KEY,
    judge_id        SERIAL,
    nomination_id   SERIAL
);