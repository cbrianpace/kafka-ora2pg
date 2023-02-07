CREATE USER sport IDENTIFIED BY welcome1;
GRANT CONNECT TO sport;
GRANT CREATE SESSION TO sport;
GRANT CREATE TABLE TO sport;
GRANT CREATE SEQUENCE TO sport;
ALTER USER sport QUOTA UNLIMITED ON users;

DROP TABLE sport.team;

CREATE TABLE sport.team (
	team_id      NUMBER NOT NULL,
	team_name    VARCHAR2(50),
	city         VARCHAR2(100),
	abbreviation VARCHAR2(3),
	venue_id     NUMBER,
	logo_src     VARCHAR2(200),
	CONSTRAINT team_pkey PRIMARY KEY (team_id)
);

ALTER TABLE sport.team ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;

DROP TABLE sport.game;

CREATE TABLE sport.game (
	game_id         NUMBER NOT NULL,
	schedule_status VARCHAR2(15),
	original_date   TIMESTAMP,
	game_date       TIMESTAMP,
	away_team_id    NUMBER NOT NULL,
	home_team_id    NUMBER NOT NULL,
	game_status     VARCHAR2(40),
	away_score      NUMBER,
	home_score      NUMBER,
	season          VARCHAR2(30),
	away_hits       NUMBER,
	home_hits       NUMBER,
	away_errors     NUMBER,
	home_errors     NUMBER,
	venue_id        NUMBER,
	attendance      NUMBER,
	CONSTRAINT game_pkey PRIMARY KEY (game_id)
);

ALTER TABLE sport.game ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;

CREATE INDEX sport.game_idx1 ON sport.game (home_team_id, away_team_id);

DROP TABLE sport.venue;

CREATE TABLE sport.venue (
	venue_id   NUMBER NOT NULL,
	venue_name VARCHAR2(100),
	city       VARCHAR2(100),
	country    VARCHAR2(10),
	CONSTRAINT venue_pk PRIMARY KEY (venue_id)
);

ALTER TABLE sport.venue ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;

exit;
