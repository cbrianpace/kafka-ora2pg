CREATE DATABASE sport;

\c sport

DROP TABLE IF EXISTS team;

CREATE TABLE team (
	team_id      INT8 NOT NULL,
	team_name    VARCHAR(50) NULL,
	city         VARCHAR(100) NULL,
	abbreviation VARCHAR(3) NULL,
	venue_id     INT8 NULL,
	logo_src     VARCHAR(200) NULL,
	CONSTRAINT team_pkey PRIMARY KEY (team_id)
);

INSERT INTO team (team_id,team_name,city,abbreviation,venue_id,logo_src) VALUES
	 (127,'Mets','New York','NYM',109,'https://www.mlbstatic.com/team-logos/121.svg'),
	 (128,'Marlins','Miami','MIA',118,'https://www.mlbstatic.com/team-logos/146.svg'),
	 (129,'Phillies','Philadelphia','PHI',110,'https://www.mlbstatic.com/team-logos/143.svg'),
	 (131,'Cubs','Chicago','CHC',133,'https://www.mlbstatic.com/team-logos/112.svg'),
	 (132,'Pirates','Pittsburgh','PIT',125,'https://www.mlbstatic.com/team-logos/134.svg'),
	 (135,'Reds','Cincinnati','CIN',116,'https://www.mlbstatic.com/team-logos/113.svg'),
	 (136,'Giants','San Francisco','SF',106,'https://www.mlbstatic.com/team-logos/137.svg'),
	 (138,'Rockies','Colorado','COL',112,'https://www.mlbstatic.com/team-logos/115.svg'),
	 (139,'Padres','San Diego','SD',124,'https://www.mlbstatic.com/team-logos/135.svg'),
	 (140,'Diamondbacks','Arizona','ARI',108,'https://www.mlbstatic.com/team-logos/109.svg'),
	 (120,'Twins','Minnesota','MIN',129,'null'),
	 (122,'Astros','Houston','HOU',120,'null'),
	 (125,'Athletics','Oakland','OAK',64,'null'),
	 (126,'Nationals','Washington','WAS',121,'null'),
	 (130,'Braves','Atlanta','ATL',136,'null'),
	 (133,'Cardinals','St. Louis','STL',107,'null'),
	 (134,'Brewers','Milwaukee','MIL',119,'null'),
	 (137,'Dodgers','Los Angeles','LAD',113,'null'),
	 (111,'Orioles','Baltimore','BAL',123,'https://www.mlbstatic.com/team-logos/110.svg'),
	 (112,'Blue Jays','Toronto','TOR',127,'https://www.mlbstatic.com/team-logos/141.svg'),
	 (113,'Red Sox','Boston','BOS',114,'https://www.mlbstatic.com/team-logos/111.svg'),
	 (114,'Yankees','New York','NYY',134,'https://www.mlbstatic.com/team-logos/147.svg'),
	 (115,'Rays','Tampa Bay','TB',130,'https://www.mlbstatic.com/team-logos/139.svg'),
	 (116,'Guardians','Cleveland','CLE',126,'https://www.mlbstatic.com/team-logos/114.svg'),
	 (117,'Tigers','Detroit','DET',111,'https://www.mlbstatic.com/team-logos/116.svg'),
	 (118,'Royals','Kansas City','KC',117,'https://www.mlbstatic.com/team-logos/118.svg'),
	 (119,'White Sox','Chicago','CWS',132,'https://www.mlbstatic.com/team-logos/145.svg'),
	 (121,'Rangers','Texas','TEX',153,'https://www.mlbstatic.com/team-logos/140.svg'),
	 (123,'Mariners','Seattle','SEA',128,'https://www.mlbstatic.com/team-logos/136.svg'),
	 (124,'Angels','Los Angeles','LAA',105,'https://www.mlbstatic.com/team-logos/108.svg');

DROP TABLE IF EXISTS game;

CREATE TABLE game (
	game_id         INT8 NOT NULL,
	schedule_status VARCHAR(15) NULL,
	original_date   TIMESTAMP NULL,
	game_date       TIMESTAMP NULL,
	away_team_id    INT8 NOT NULL,
	home_team_id    INT8 NOT NULL,
	game_status     VARCHAR(40) NULL DEFAULT 'SCHEDULED'::character varying,
	away_score      INT2 NULL,
	home_score      INT2 NULL,
	season          VARCHAR(30) NULL,
	away_hits       INT4 NULL,
	home_hits       INT4 NULL,
	away_errors     INT4 NULL,
	home_errors     INT4 NULL,
	venue_id        INT8 NULL,
	attendance      INT8 NULL,
	CONSTRAINT game_pkey PRIMARY KEY (game_id)
);

CREATE INDEX game_idx1 ON game USING btree (home_team_id, away_team_id);

INSERT INTO game (game_id,schedule_status,original_date,game_date,away_team_id,home_team_id,game_status,away_score,home_score,season,away_hits,home_hits,away_errors,home_errors,venue_id,attendance) VALUES
	 (70737,'NORMAL',NULL,'2022-09-07 20:40:00',140,139,'COMPLETED',3,6,'2022-regular',6,10,0,1,124,36948),
	 (70738,'NORMAL',NULL,'2022-09-07 20:10:00',116,118,'COMPLETED',1,2,'2022-regular',8,6,0,0,117,13394),
	 (70735,'NORMAL',NULL,'2022-09-07 20:10:00',121,122,'COMPLETED',3,4,'2022-regular',5,4,0,1,120,26239),
	 (70740,'NORMAL',NULL,'2022-09-07 19:45:00',126,133,'COMPLETED',5,6,'2022-regular',10,9,0,0,107,34715),
	 (70741,'NORMAL',NULL,'2022-09-07 19:40:00',135,131,'COMPLETED',7,1,'2022-regular',10,12,0,1,133,27945),
	 (70733,'NORMAL',NULL,'2022-09-07 19:05:00',112,111,'COMPLETED',4,1,'2022-regular',9,3,0,1,123,11488),
	 (70728,'POSTPONED','2022-09-06 19:05:00','2022-09-07 19:05:00',120,114,'COMPLETED',1,7,'2022-regular',8,6,0,0,134,30157),
	 (70743,'NORMAL',NULL,'2022-09-07 18:45:00',128,129,'COMPLETED',3,4,'2022-regular',10,8,0,0,110,17755),
	 (70734,'NORMAL',NULL,'2022-09-07 18:40:00',113,115,'COMPLETED',0,1,'2022-regular',6,4,0,0,130,8696),
	 (70744,'NORMAL',NULL,'2022-09-07 18:35:00',127,132,'COMPLETED',10,0,'2022-regular',17,4,0,0,125,9824),
	 (70721,'NORMAL',NULL,'2022-09-07 16:10:00',136,137,'COMPLETED',3,7,'2022-regular',8,11,0,0,113,39237),
	 (70731,'NORMAL',NULL,'2022-09-07 16:10:00',119,123,'COMPLETED',9,6,'2022-regular',8,8,1,3,128,15264),
	 (70745,'NORMAL',NULL,'2022-09-07 16:07:00',117,124,'COMPLETED',5,4,'2022-regular',13,11,0,0,105,15756),
	 (70732,'NORMAL',NULL,'2022-09-07 15:37:00',130,125,'COMPLETED',7,3,'2022-regular',10,3,0,0,64,5332),
	 (70739,'NORMAL',NULL,'2022-09-07 15:10:00',134,138,'COMPLETED',4,8,'2022-regular',7,9,1,0,112,20278),
	 (70742,'NORMAL',NULL,'2022-09-07 15:05:00',120,114,'COMPLETED',4,5,'2022-regular',11,9,4,0,134,NULL),
	 (70715,'POSTPONED','2022-09-05 12:35:00','2022-09-07 12:35:00',127,132,'COMPLETED',5,1,'2022-regular',10,7,0,0,125,8717);

DROP TABLE IF EXISTS venue;

CREATE TABLE venue (
	venue_id   INT8 NOT NULL,
	venue_name VARCHAR(100) NULL,
	city       VARCHAR(100) NULL,
	country    VARCHAR(10) NULL,
	CONSTRAINT venue_pk PRIMARY KEY (venue_id)
);

INSERT INTO venue (venue_id,venue_name,city,country) VALUES
	 (109,'Citi Field','New York, NY','USA'),
	 (110,'Citizens Bank Park','Philadelphia, PA','USA'),
	 (125,'PNC Park','Pittsburgh, PA','USA'),
	 (107,'Busch Stadium','St. Louis, MO','USA'),
	 (108,'Chase Field','Phoenix, AZ','USA'),
	 (111,'Comerica Park','Detroit, MI','USA'),
	 (112,'Coors Field','Denver, CO','USA'),
	 (113,'Dodger Stadium','Los Angeles, CA','USA'),
	 (106,'Oracle Park','San Francisco, CA','USA'),
	 (132,'Guaranteed Rate Field','Chicago, IL','USA'),
	 (118,'LoanDepot Park','Miami, FL','USA'),
	 (124,'Petco Park','San Diego, CA','USA'),
	 (127,'Rogers Centre','Toronto, ON','Canada'),
	 (128,'T-Mobile Park','Seattle, WA','USA'),
	 (130,'Tropicana Field','St. Petersburg, FL','USA'),
	 (133,'Wrigley Field','Chicago, IL','USA'),
	 (134,'Yankee Stadium','Bronx, NY','USA'),
	 (123,'Oriole Park at Camden Yards','Baltimore, MD','USA'),
	 (126,'Progressive Field','Cleveland, OH','USA'),
	 (157,'Field of Dreams','Dyersville, IA','USA'),
	 (119,'American Family Field','Milwaukee, WI','USA'),
	 (120,'Minute Maid Park','Houston, TX','USA'),
	 (121,'Nationals Park','Washington, DC','USA'),
	 (129,'Target Field','Minneapolis, MN','USA'),
	 (136,'Truist Park','Atlanta, GA','USA'),
	 (149,'BB&T Ballpark','Charlotte, NC','USA'),
	 (153,'Globe Life Field','Arlington, TX','USA'),
	 (116,'Great American Ball Park','Cincinnati, OH','USA'),
	 (64,'Oakland-Alameda County Coliseum','Oakland, CA','USA'),
	 (105,'Angel Stadium','Anaheim, CA','USA'),
	 (114,'Fenway Park','Boston, MA','USA'),
	 (117,'Kauffman Stadium','Kansas City, MO','USA');
