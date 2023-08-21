CREATE TABLE streamingService(
    serviceID VARCHAR(10) NOT NULL PRIMARY KEY, --ssid
    ssType VARCHAR(20),
    ssName VARCHAR(20)
);
CREATE TABLE writer(
    writerID VARCHAR(10) NOT NULL PRIMARY KEY, --wtrid
    experience INT,
    firstName VARCHAR(20),
    lastName VARCHAR(20),
    salary INT
);
CREATE TABLE manga(
    mangaID VARCHAR(10) NOT NULL PRIMARY KEY, --mgid
    dateReleased TIMESTAMP,
    genre VARCHAR(20),
    title VARCHAR(20),
    rating FLOAT,
    writerID VARCHAR(10),
    serviceID VARCHAR(10),
    FOREIGN KEY (writerID) REFERENCES writer(writerID),
    FOREIGN KEY (serviceID) REFERENCES streamingService(serviceID)
);
CREATE TABLE award(
    awardID VARCHAR(10) NOT NULL PRIMARY KEY, --awdid
    title VARCHAR(50),
    awdCategory VARCHAR(50)
);
CREATE TABLE director(
    directorID VARCHAR(10) NOT NULL PRIMARY KEY, --dirid
    experience INT,
    firstName VARCHAR(20),
    lastName VARCHAR(20),
    salary INT,
    awardID VARCHAR(10),
    FOREIGN KEY (awardID) REFERENCES award(awardID)
);
CREATE TABLE anime(
    animeID VARCHAR(10) NOT NULL PRIMARY KEY, --anmid
    genre VARCHAR(20),
    title VARCHAR(20),
    rating FLOAT,
    budget INT,
    income INT,
    serviceID VARCHAR(10),
    directorID VARCHAR(10),
    mangaID VARCHAR(10),
    FOREIGN KEY (serviceID) REFERENCES streamingService(serviceID),
    FOREIGN KEY (directorID) REFERENCES director(directorID),
    FOREIGN KEY (mangaID) REFERENCES manga(mangaID)
);
CREATE TABLE episode(
    epNumber INT,
    animeID VARCHAR(10),
    PRIMARY KEY (epNumber,animeID),
    FOREIGN KEY (animeID) REFERENCES anime(animeID),
    title VARCHAR(80),
    dateReleased TIMESTAMP
);
CREATE TABLE voiceActor(
    voiceActorID VARCHAR(10) NOT NULL PRIMARY KEY, --vacid
    experience INT,
    firstName VARCHAR(20),
    lastName VARCHAR(20),
    salary INT,
    awardID VARCHAR(10),
    FOREIGN KEY (awardID) REFERENCES award(awardID)
);
CREATE TABLE animator(
    animatorID VARCHAR(10) NOT NULL PRIMARY KEY, --amtid
    qualification VARCHAR(80),
    experience INT,
    firstName VARCHAR(20),
    lastName VARCHAR(20),
    salary INT,
    awardID VARCHAR(10),
    FOREIGN KEY (awardID) REFERENCES award(awardID)
);
CREATE TABLE musicComposer(
    musicComposerID VARCHAR(10) NOT NULL PRIMARY KEY, --mcid
    experience INT,
    firstName VARCHAR(20),
    lastName VARCHAR(20),
    salary INT,
    awardID VARCHAR(10),
    FOREIGN KEY (awardID) REFERENCES award(awardID)
);
CREATE TABLE voiceOverBy(
    voiceActorID VARCHAR(10),
    animeID VARCHAR(10),
    PRIMARY KEY (voiceActorID,animeID),
    FOREIGN KEY (animeID) REFERENCES anime(animeID),
    FOREIGN KEY (voiceActorID) REFERENCES voiceActor(voiceActorID)
);
CREATE TABLE animatedBy(
    animatorID VARCHAR(10),
    animeID VARCHAR(10),
    PRIMARY KEY (animatorID,animeID),
    FOREIGN KEY (animeID) REFERENCES anime(animeID),
    FOREIGN KEY (animatorID) REFERENCES animator(animatorID)
);
CREATE TABLE soundTrack(
    title VARCHAR(80),
    musicComposerID VARCHAR(10),
    PRIMARY KEY(musicComposerID,title),
    FOREIGN KEY (musicComposerID) REFERENCES musicComposer(musicComposerID)
);
CREATE TABLE hasBGM(
    title VARCHAR(80),
    musicComposerID VARCHAR(10),
    epNumber INT,
    animeID VARCHAR(10),
    PRIMARY KEY (epNumber,animeID,musicComposerID,title),
    FOREIGN KEY (musicComposerID,title) REFERENCES soundTrack(musicComposerID,title),
    FOREIGN KEY (epNumber,animeID) REFERENCES episode(epNumber,animeID)
);

INSERT INTO writer VALUES('wtr001', 7, 'Eiichiro', 'Oda', 145000);
INSERT INTO writer VALUES('wtr002', 9, 'Masashi', 'Kishimoto', 355000);
INSERT INTO writer VALUES('wtr003', 5, 'Kentaro', 'Miura', 465000);
INSERT INTO writer VALUES('wtr004',12, 'Akira', 'Toriyama', 140000);
INSERT INTO writer VALUES('wtr005',10, 'Hirohiko', 'Araki', 290000);
INSERT INTO writer VALUES('wtr006',14, 'Hajime', 'Isayama', 351000);
INSERT INTO writer VALUES('wtr007', 8, 'Keisuke', 'Itagaki', 30000);
INSERT INTO writer VALUES('wtr008',15, 'Naoki', 'Urasawa', 515000);
INSERT INTO writer VALUES('wtr009',13, 'Jang', 'Sung-Rak', 500000);
INSERT INTO writer VALUES('wtr010',11, 'Moto', 'Hagio', 465000);
SELECT * FROM writer;

INSERT INTO streamingService VALUES ('ss001','website for anime','crunchyroll');
INSERT INTO streamingService VALUES ('ss002','App for anime','netflix');
INSERT INTO streamingService VALUES ('ss003','Website for both','9anime');
INSERT INTO streamingService VALUES ('ss004','App for manga','mangazone');
INSERT INTO streamingService VALUES ('ss005','website for manga','mangatoon');
SELECT * FROM streamingService;

INSERT INTO manga VALUES ('mg001',TIMESTAMP '2003-01-15 23:00:00', 'Post-Apocalyptic', 'Attack on Titan', 9.3, 'wtr006', 'ss003');
INSERT INTO manga VALUES ('mg002',TIMESTAMP '1997-12-15 13:00:00', 'Adventure', 'ONE PIECE', 8.0, 'wtr004', 'ss004');
INSERT INTO manga VALUES ('mg003',TIMESTAMP '1999-11-17 20:00:00', 'Action', 'NARUTO', 8.6, 'wtr002', 'ss003');
INSERT INTO manga VALUES ('mg004',TIMESTAMP '2003-01-16 23:00:00', 'Martial Arts', 'BAKI', 7.9, 'wtr007', 'ss003');
INSERT INTO manga VALUES ('mg005',TIMESTAMP '2006-01-14 18:00:00', 'Supernatural', 'JOJO', 9.8, 'wtr005', 'ss003');
INSERT INTO manga VALUES ('mg006',TIMESTAMP '2005-01-01 08:00:00', 'Dark Fantasy', 'Berserk', 9.7, 'wtr003', 'ss004');
INSERT INTO manga VALUES ('mg007',TIMESTAMP '2007-01-05 21:00:00', 'Science Fiction', 'DR.SLUMP', 8.3, 'wtr001', 'ss005');
INSERT INTO manga VALUES ('mg008',TIMESTAMP '2004-03-25 22:00:00', 'Comedy', 'Slam Dunk', 8.8, 'wtr008', 'ss004');
INSERT INTO manga VALUES ('mg009',TIMESTAMP '2003-04-27 23:00:00', 'Bildungsroman', 'The Heart of Thomas', 8.0, 'wtr010','ss005');
INSERT INTO manga VALUES ('mg010',TIMESTAMP '2001-01-30 23:00:00', 'Action', 'SOLO LEVELING', 7.0,'wtr009','ss005');
SELECT * FROM manga;

INSERT INTO award VALUES ('awd001', 'MetaVerse Achievement Award', 'Animation');
INSERT INTO award VALUES ('awd002', 'TechnoWizard Innovation Prize', 'Direction');
INSERT INTO award VALUES ('awd003', 'Stellar Narrative Award', 'Direction');  
INSERT INTO award VALUES ('awd004', 'Pixel Pioneer Medal', 'Direction');  
INSERT INTO award VALUES ('awd005', 'Melodious Maestro Trophy ', 'Music');  
INSERT INTO award VALUES ('awd006', 'Virtual Voice Virtuoso', 'Voice over');  
INSERT INTO award VALUES ('awd007', 'Imagination Architect Prize', 'Animation');  
INSERT INTO award VALUES ('awd008', 'Harmony Virtuoso Award', 'Music');  
INSERT INTO award VALUES ('awd009', 'Rhythmic Innovator Trophy', 'Music');  
INSERT INTO award VALUES ('awd010', 'Vocal Artistry Honor', 'Voice over');  
INSERT INTO award VALUES ('awd011', 'Dramatic Delivery Distinction', 'Voice over');
INSERT INTO award VALUES ('awd012', 'Character Conjurer Award', 'Animation');
SELECT * FROM award;

INSERT INTO director VALUES ('dir001', 5, 'Megumi','Ishitani', 100000, 'awd003');
INSERT INTO director VALUES ('dir002', 3, 'Masashi','Kishimoto', 80000, 'awd002');
INSERT INTO director VALUES ('dir003', 6, 'Shin','Itagaki', 120000, 'awd003');
INSERT INTO director VALUES ('dir004', 2, 'Naokatsu','Tsuda', 60000, NULL);
INSERT INTO director VALUES ('dir005', 4, 'Masayuki','Kojima', 90000, NULL);
INSERT INTO director VALUES ('dir006', 7, 'Shuhei','Morita', 150000, 'awd004');
INSERT INTO director VALUES ('dir007', 1, 'Sarah', 'Wang', 50000, NULL);
INSERT INTO director VALUES ('dir008', 5, 'Nobutaka','Nishizawa', 100000, 'awd004');
INSERT INTO director VALUES ('dir009', 3, 'Yuichiro','Hayashi', 80000, NULL);
INSERT INTO director VALUES ('dir010', 4, 'Toshiki','orasaki', 90000, 'awd002');
SELECT * FROM director;

INSERT INTO voiceActor VALUES ('vac001', 5, 'Mayumi', 'Tanaka', 50000, 'awd006');
INSERT INTO voiceActor VALUES ('vac002', 8, 'Maile','Flanagan', 80000, NULL);
INSERT INTO voiceActor VALUES ('vac003', 3, 'Kirk','Thornton', 40000, 'awd011');
INSERT INTO voiceActor VALUES ('vac004',10, 'Yuki','Kaji', 100000, 'awd010');
INSERT INTO voiceActor VALUES ('vac005', 2, 'Tomokazu','Sugita', 30000, NULL);
INSERT INTO voiceActor VALUES ('vac006', 2, 'Marc','Diraison', 30000, NULL);
SELECT * FROM voiceActor;

INSERT INTO animator VALUES ('amt001', 'Bachelor in Graphic', 8,  'Ayumi',' Kurashima', 45000, 'awd012');
INSERT INTO animator VALUES ('amt002', 'Bachelor in Animation', 2,  'Sh?ji ', 'Yonemura', 45000, 'awd012');
INSERT INTO animator VALUES ('amt003', 'Master in Fine Arts', 5, 'Shingo', ' Yamashita' , 55000, NULL);
INSERT INTO animator VALUES ('amt004', 'Certificate in Animation', 1, 'Makoto ', 'Fukami' , 35000, NULL);
INSERT INTO animator VALUES ('amt005', 'Bachelor in Graphic Design', 4, 'Junichi', 'Hayama', 60000, 'awd001');
INSERT INTO animator VALUES ('amt006', 'Bachelor in Fine Arts', 3, 'Arifumi ', ' Arifumi Imai' , 50000, NULL);
INSERT INTO animator VALUES ('amt007', 'Master in Animation', 7,' Tomonaga', 'KeKazuhide', 75000, 'awd007');
INSERT INTO animator VALUES ('amt008', 'Master in Fine Arts', 8,'Hideaki','Anno', 45000, NULL);
INSERT INTO animator VALUES ('amt009', 'Master in Animation', 9,' Kitar?','K?saka', 79000,'awd007');
INSERT INTO animator VALUES ('amt010', 'Bachelor in Graphic Design', 7,'Kimio','Yabuki', 55000, NULL);
SELECT * FROM animator;

INSERT INTO musicComposer VALUES ('mc001',10,'Kohei','Tanaka', 1000000, 'awd005');
INSERT INTO musicComposer VALUES ('mc002', 5,'Yasuharu','Takanashi', 800000, 'awd008');
INSERT INTO musicComposer VALUES ('mc003',10,'Yûgo','Kanno', 1000000, 'awd008');
INSERT INTO musicComposer VALUES ('mc004',10,'Kenji','Fujisawa', 1000000, 'awd009');
INSERT INTO musicComposer VALUES ('mc005',15,'JHiroyuki','Sawano', 1200000, NULL);
INSERT INTO musicComposer VALUES ('mc006', 8,'Susumu','Hirasawa', 900000, 'awd005');
INSERT INTO musicComposer VALUES ('mc007',10,'Yoko','Kanno', 1000000, 'awd005');
INSERT INTO musicComposer VALUES ('mc008', 5,'Joe','Hisaishi', 800000, 'awd008');
INSERT INTO musicComposer VALUES ('mc009',16,'Yuki','Kajiura', 1000000, 'awd008');
INSERT INTO musicComposer VALUES ('mc010',10,'royuki','hinata', 1000000, 'awd009');
INSERT INTO musicComposer VALUES ('mc011',15,'Ryuichi','Sakamoto', 1200000, NULL);
INSERT INTO musicComposer VALUES ('mc012', 8,'Nobuo','Uematsu', 900000, NULL);
INSERT INTO musicComposer VALUES ('mc013', 7,'Shir?', 'Sagisu', 900000, NULL);
INSERT INTO musicComposer VALUES ('mc014', 4,'yoko', 'Shimomura', 900000, NULL);
INSERT INTO musicComposer VALUES ('mc015', 8,'Toshio','Masuda', 900000,NULL);
SELECT * FROM musicComposer;

INSERT INTO anime VALUES ('anm001', 'Post-Apocalyptic', 'attack on titan', 8.5, 3000000, 5000000, 'ss001', 'dir006', 'mg001');
INSERT INTO anime VALUES ('anm002', 'Adventure', 'ONE PIECE', 9.0, 2500000, 6000000, 'ss002', 'dir001', 'mg002');
INSERT INTO anime VALUES ('anm003', 'Action',  'NARUTO', 11.5, 2000000, 4000000, 'ss003', 'dir002', 'mg003');
INSERT INTO anime VALUES ('anm004', 'Martial Arts', 'baki', 8.82, 3500000, 5500000, 'ss001', 'dir010', 'mg004');
INSERT INTO anime VALUES ('anm005', 'Supernatural', 'JOJO', 9.5, 4000000, 7000000, 'ss003', 'dir004', 'mg005');
INSERT INTO anime VALUES ('anm006', 'Dark Fantasy', 'BERSERK', 8.5, 3000000, 5000000, 'ss002', 'dir005','mg006');
SELECT * FROM anime;

INSERT INTO voiceOverBy VALUES ('vac002', 'anm001');
INSERT INTO voiceOverBy VALUES ('vac006', 'anm001');
INSERT INTO voiceOverBy VALUES ('vac005', 'anm002');
INSERT INTO voiceOverBy VALUES ('vac003', 'anm002');
INSERT INTO voiceOverBy VALUES ('vac006', 'anm003');
INSERT INTO voiceOverBy VALUES ('vac001', 'anm003');
INSERT INTO voiceOverBy VALUES ('vac002', 'anm003');
INSERT INTO voiceOverBy VALUES ('vac003', 'anm004');
INSERT INTO voiceOverBy VALUES ('vac006', 'anm004');
INSERT INTO voiceOverBy VALUES ('vac005', 'anm004');
INSERT INTO voiceOverBy VALUES ('vac001', 'anm005');
INSERT INTO voiceOverBy VALUES ('vac002', 'anm005');
INSERT INTO voiceOverBy VALUES ('vac003', 'anm005');
INSERT INTO voiceOverBy VALUES ('vac003', 'anm006');
INSERT INTO voiceOverBy VALUES ('vac004', 'anm006');
INSERT INTO voiceOverBy VALUES ('vac006', 'anm006');
SELECT * FROM voiceOverBy;

INSERT INTO animatedBy VALUES ('amt001', 'anm001');
INSERT INTO animatedBy VALUES ('amt002', 'anm001');
INSERT INTO animatedBy VALUES ('amt003', 'anm002');
INSERT INTO animatedBy VALUES ('amt004', 'anm002');
INSERT INTO animatedBy VALUES ('amt005', 'anm003');
INSERT INTO animatedBy VALUES ('amt006', 'anm003');
INSERT INTO animatedBy VALUES ('amt007', 'anm003');
INSERT INTO animatedBy VALUES ('amt008', 'anm004');
INSERT INTO animatedBy VALUES ('amt009', 'anm004');
INSERT INTO animatedBy VALUES ('amt010', 'anm004');
INSERT INTO animatedBy VALUES ('amt001', 'anm005');
INSERT INTO animatedBy VALUES ('amt004', 'anm005');
INSERT INTO animatedBy VALUES ('amt003', 'anm005');
INSERT INTO animatedBy VALUES ('amt005', 'anm006');
INSERT INTO animatedBy VALUES ('amt006', 'anm006');
INSERT INTO animatedBy VALUES ('amt007', 'anm006');
SELECT * FROM animatedBy;

INSERT INTO episode VALUES (1, 'anm001', 'The Beginning', TIMESTAMP'2003-01-01 00:00:00');
INSERT INTO episode VALUES (2, 'anm001', 'The Next Chapter', TIMESTAMP'2003-01-08 00:00:00');
INSERT INTO episode VALUES (3, 'anm001', 'The Turning Point', TIMESTAMP'2003-01-15 00:00:00');
INSERT INTO episode VALUES (4, 'anm001', 'A New World', TIMESTAMP'2003-01-23 00:00:00');
INSERT INTO episode VALUES (5, 'anm001', 'The Journey Begins', TIMESTAMP'2003-01-30 05:00:00');
INSERT INTO episode VALUES (1, 'anm003', 'A Meeting With Destiny', TIMESTAMP'2014-02-01 05:00:00');
INSERT INTO episode VALUES (2, 'anm003', 'A Shinobi Determination', TIMESTAMP'2014-02-08 05:00:00');
INSERT INTO episode VALUES (3, 'anm003', 'Five Kage Summit', TIMESTAMP'2014-02-15 05:00:00');
INSERT INTO episode VALUES (4, 'anm003', 'Akatsuki suppression mission', TIMESTAMP'2014-02-23 00:00:00');
INSERT INTO episode VALUES (5, 'anm003', 'A Dubious Offer! Tsunade Choice', TIMESTAMP'2014-01-30 00:00:00');
INSERT INTO episode VALUES (1, 'anm002', 'East Blue Saga', TIMESTAMP'2019-02-01 05:00:00');
INSERT INTO episode VALUES (2, 'anm002', 'Arabasta Saga', TIMESTAMP'2019-03-08 05:00:00');
INSERT INTO episode VALUES (3, 'anm002', 'Water 7 Saga', TIMESTAMP'2019-03-15 05:00:00');
INSERT INTO episode VALUES (4, 'anm002', '', TIMESTAMP'2019-03-23 05:00:00');
INSERT INTO episode VALUES (5, 'anm002', 'Thriller Bark Saga', TIMESTAMP'2019-03-30 05:00:00');
INSERT INTO episode VALUES (1, 'anm004', 'Baki The Grappler', TIMESTAMP'2013-02-01 05:00:00');
INSERT INTO episode VALUES (2, 'anm004', 'The Ultimate Fighter,Baki The Grappler', TIMESTAMP'2013-03-08 05:00:00');
INSERT INTO episode VALUES (3, 'anm004', 'Most Evil Death Row Convicts Special Anime', TIMESTAMP'2013-03-15 05:00:00');
INSERT INTO episode VALUES (4, 'anm004', 'Baki: Most Evil Death Row Convicts Special Anime.', TIMESTAMP'2013-03-23 00:00:00');
INSERT INTO episode VALUES (5, 'anm004', 'Thriller Bark Saga', TIMESTAMP'2013-03-30 00:00:00');       
INSERT INTO episode VALUES (1, 'anm005', 'Silver Chariot', TIMESTAMP'2012-05-01 05:00:00');
INSERT INTO episode VALUES (2, 'anm005','Dark Blue Moon', TIMESTAMP'2012-05-08 05:00:00');
INSERT INTO episode VALUES (3, 'anm005','Strength', TIMESTAMP'2012-03-15 05:00:00');
INSERT INTO episode VALUES (4, 'anm005', 'Battle Tendency', TIMESTAMP'2012-11-23 00:00:00');
INSERT INTO episode VALUES (5, 'anm005', 'Thriller Bark Saga', TIMESTAMP'2012-11-30 00:00:00'); 
INSERT INTO episode VALUES (1, 'anm006', 'Kuroi kenshi', TIMESTAMP'1999-03-01 05:00:00');
INSERT INTO episode VALUES (2, 'anm006','Taka no dan', TIMESTAMP'1999-05-08 05:00:00');
INSERT INTO episode VALUES (3, 'anm006','Uijin ', TIMESTAMP'1999-05-15 05:00:00');
INSERT INTO episode VALUES (4, 'anm006', 'Kami no te', TIMESTAMP'2013-05-23 00:00:00');
INSERT INTO episode VALUES (5, 'anm006', 'TFushi no Zodd', TIMESTAMP'2013-05-30 00:00:00');
SELECT * FROM episode ORDER BY animeID,epNumber;

INSERT INTO soundTrack VALUES ('Vogel im Käfig','mc001');
INSERT INTO soundTrack VALUES ('Guren no Yumiya','mc001');
INSERT INTO soundTrack VALUES ('Ashes on The Fire','mc013');
INSERT INTO soundTrack VALUES ('We Are!','mc014');
INSERT INTO soundTrack VALUES ('BRAND NEW WORLD','mc002');
INSERT INTO soundTrack VALUES ('OVER THE TOP','mc003');
INSERT INTO soundTrack VALUES ('Sadness and Sorrow ','mc003');
INSERT INTO soundTrack VALUES ('Naruto Daily Life','mc004');
INSERT INTO soundTrack VALUES ('Next Hokage ','mc004');
INSERT INTO soundTrack VALUES ('STAND PROUD','mc005');
INSERT INTO soundTrack VALUES ('Giorno Theme','mc015');
INSERT INTO soundTrack VALUES ('Great Days','mc006');
INSERT INTO soundTrack VALUES ('Treasure Pleasure','mc007');
INSERT INTO soundTrack VALUES ('The Gong of Knockout','mc008');
INSERT INTO soundTrack VALUES ('RESOLVE','mc009');
INSERT INTO soundTrack VALUES ('Behelit','mc010');
INSERT INTO soundTrack VALUES ('Ghosts','mc011');
INSERT INTO soundTrack VALUES ('Murder','mc012');
SELECT * FROM soundTrack;

INSERT INTO hasBGM VALUES ('Vogel im Käfig','mc001',1,'anm001');
INSERT INTO hasBGM VALUES ('Vogel im Käfig','mc001',2,'anm001');
INSERT INTO hasBGM VALUES ('Guren no Yumiya','mc001',3,'anm001');
INSERT INTO hasBGM VALUES ('Ashes on The Fire','mc013',4,'anm001');
INSERT INTO hasBGM VALUES ('Guren no Yumiya','mc001',5,'anm001');
INSERT INTO hasBGM VALUES ('We Are!','mc014',1,'anm002');
INSERT INTO hasBGM VALUES ('BRAND NEW WORLD','mc002',2,'anm002');
INSERT INTO hasBGM VALUES ('We Are!','mc014',3,'anm002');
INSERT INTO hasBGM VALUES ('BRAND NEW WORLD','mc002',4,'anm002');
INSERT INTO hasBGM VALUES ('OVER THE TOP','mc003',5,'anm002');
INSERT INTO hasBGM VALUES ('Sadness and Sorrow ','mc003',1,'anm003');
INSERT INTO hasBGM VALUES ('Sadness and Sorrow ','mc003',2,'anm003');
INSERT INTO hasBGM VALUES ('Naruto Daily Life','mc004',3,'anm003');
INSERT INTO hasBGM VALUES ('Next Hokage ','mc004',4,'anm003');
INSERT INTO hasBGM VALUES ('Naruto Daily Life','mc004',5,'anm003');
INSERT INTO hasBGM VALUES ('STAND PROUD','mc005',1,'anm004');
INSERT INTO hasBGM VALUES ('Giorno Theme','mc015',2,'anm004');
INSERT INTO hasBGM VALUES ('STAND PROUD','mc005',3,'anm004');
INSERT INTO hasBGM VALUES ('Giorno Theme','mc015',4,'anm004');
INSERT INTO hasBGM VALUES ('Giorno Theme','mc015',5,'anm004');
INSERT INTO hasBGM VALUES ('Treasure Pleasure','mc007',1,'anm005');
INSERT INTO hasBGM VALUES ('The Gong of Knockout','mc008',2,'anm005');
INSERT INTO hasBGM VALUES ('Treasure Pleasure','mc007',3,'anm005');
INSERT INTO hasBGM VALUES ('RESOLVE','mc009',4,'anm005');
INSERT INTO hasBGM VALUES ('The Gong of Knockout','mc008',5,'anm005');
INSERT INTO hasBGM VALUES ('RESOLVE','mc009',4,'anm006');
INSERT INTO hasBGM VALUES ('Behelit','mc010',1,'anm006');
INSERT INTO hasBGM VALUES ('Ghosts','mc011',5,'anm006');
INSERT INTO hasBGM VALUES ('Murder','mc012',2,'anm006');
INSERT INTO hasBGM VALUES ('Behelit','mc010',3,'anm006');
SELECT * FROM hasBGM;

/
SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER checkRating 
BEFORE INSERT ON anime
FOR EACH ROW
DECLARE
boundExpRating EXCEPTION;
inAppExpRating EXCEPTION;
dupRating FLOAT;
BEGIN
    IF :new.rating > 9.9 OR :new.rating < 0.1 THEN
        RAISE boundExpRating;
    END IF;
    dupRating := :new.rating;
    IF dupRating != dupRating*100 THEN
        RAISE inAppExpRating;
    END IF;
EXCEPTION 
    WHEN boundExpRating THEN 
        IF :new.rating < 0.1 THEN 
            :new.rating := 0.1;
        ELSIF :new.rating > 9.9 THEN
            :new.rating := 9.9;
        END IF;
    WHEN inAppExpRating THEN
        :new.rating := ROUND(:new.rating,1);
END;
/

--1
SELECT hasBGM.title AS bgmTitle,epNumber FROM
anime JOIN hasBGM 
ON anime.animeID=hasBGM.animeID
WHERE anime.title LIKE 'attack on titan'
ORDER BY epNumber;

--2
SELECT mangaID,mangaTitle,writer.writerID,writer.firstName,writer.lastName
FROM (SELECT manga.mangaID,manga.title AS mangaTitle,writerID
FROM manga LEFT JOIN anime
ON manga.mangaID=anime.mangaID
WHERE anime.mangaID IS NULL) T JOIN writer 
ON writer.writerID=T.writerID;

--3
SELECT animatorID,firstName,lastName,
award.awardID,title FROM 
(SELECT animator.animatorID,
firstName,lastName,awardID FROM
(SELECT * FROM 
anime JOIN animatedBy 
ON anime.animeID=animatedBy.animeID
WHERE title LIKE 'NARUTO') T1 JOIN animator
ON T1.animatorID=animator.animatorID
WHERE awardID IS NOT NULL) T2 JOIN award
ON T2.awardID=award.awardID;















