DROP TABLE IF EXISTS delovno_mesto_delavec;
DROP TABLE IF EXISTS delavec_let;
DROP TABLE IF EXISTS delavec_lokal;
DROP TABLE IF EXISTS destinacija_let;
DROP TABLE IF EXISTS destinacija;
DROP TABLE IF EXISTS lokal;
DROP TABLE IF EXISTS let;
DROP TABLE IF EXISTS parkirišče_cenik; 
DROP TABLE IF EXISTS delovno_mesto;
DROP TABLE IF EXISTS tip_lokala;
DROP TABLE IF EXISTS nadstropje;
DROP TABLE IF EXISTS trajanje;
DROP TABLE IF EXISTS izhod;
DROP TABLE IF EXISTS terminal;
DROP TABLE IF EXISTS letalska_družba;
DROP TABLE IF EXISTS tip_leta;
DROP TABLE IF EXISTS cona;
DROP TABLE IF EXISTS delavec;
DROP TABLE IF EXISTS del_letališča;

CREATE TABLE del_letališča(
	id_del_letališča INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	naziv VARCHAR(45) NOT NULL
);

CREATE TABLE let(
	id_let INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	čas DATETIME NOT NULL, 
	številka VARCHAR(45) NOT NULL, 
	št_postankov INT NOT NULL,
    	tk_letalska_družba INT NOT NULL,
    	tk_izhod INT NOT NULL
);

CREATE TABLE delovno_mesto(
	id_delovno_mesto INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	naziv VARCHAR(45) NOT NULL
);

CREATE TABLE delovno_mesto_delavec(
	id_delovno_mesto_delavec INT NOT NULL PRIMARY KEY AUTO_INCREMENT,  
	od DATE NOT NULL,
	do DATE,
    	tk_delovno_mesto INT NOT NULL,
    	tk_delavec INT NOT NULL
);

CREATE TABLE delavec_let(
	id_delavec_let INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    	tk_delavec INT NOT NULL,
    	tk_let INT NOT NULL,
    	tk_delovno_mesto INT NOT NULL
);

CREATE TABLE tip_lokala(
	id_tip_lokala INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	naziv VARCHAR(45) NOT NULL
);

CREATE TABLE nadstropje(
	id_nadstropje INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	nadstropje INT NOT NULL
);

CREATE TABLE delavec(
	id_delavec INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	ime VARCHAR(45) NOT NULL, 
	priimek VARCHAR(45) NOT NULL,
	datum_rojstva DATE
);

CREATE TABLE lokal(
	id_lokal INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	ime_lokala VARCHAR(45) NOT NULL, 
	velikost INT NOT NULL, 
	št_zaposlenih INT NOT NULL,
    	tk_tip_lokala INT NOT NULL,
    	tk_nadstropje INT NOT NULL,
    	tk_del_letališča INT NOT NULL
);

CREATE TABLE cona(
	id_cona INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    	cona VARCHAR(45) NOT NULL,
	št_mest INT NOT NULL,
    	tk_delavec INT NOT NULL,
    	tk_del_letališča INT NOT NULL
);

CREATE TABLE trajanje(
	id_trajanje INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	trajanje VARCHAR(50) NOT NULL
);

CREATE TABLE parkirišče_cenik(
	id_parkirišče_cenik INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	cena DECIMAL(6,2) NOT NULL,
	od DATE NOT NULL,
	do DATE,
    	tk_cona INT NOT NULL,
    	tk_trajanje INT NOT NULL
);

CREATE TABLE letalska_družba(
	id_letalska_družba INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	naziv VARCHAR(45) NOT NULL, 
	oznaka VARCHAR(45) NOT NULL,
	velikost_flote INT
);

CREATE TABLE tip_leta(
	id_tip_leta INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	naziv VARCHAR(45) NOT NULL
);

CREATE TABLE destinacija(
	id_destinacija INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	naziv VARCHAR(45) NOT NULL
);

CREATE TABLE destinacija_let(
	id_destinacija_let INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    	tk_destinacija INT NOT NULL,
    	tk_let INT NOT NULL,
    	tk_tip_leta INT NOT NULL
);

CREATE TABLE izhod(
	id_izhod INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	izhod VARCHAR(45) NOT NULL,
	tk_terminal INT NOT NULL
);

CREATE TABLE terminal(
	id_terminal INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	naziv VARCHAR(45) NOT NULL,
    	tk_del_letališča INT NOT NULL
);

CREATE TABLE delavec_lokal(
    	id_delavec_lokal INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    	tk_delavec INT NOT NULL,
    	tk_lokal INT NOT NULL
);

ALTER TABLE delovno_mesto_delavec ADD CONSTRAINT tk_delovno_mesto_delavec_delovno_mesto FOREIGN KEY (tk_delovno_mesto) REFERENCES delovno_mesto (id_delovno_mesto) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE delovno_mesto_delavec ADD CONSTRAINT tk_delovno_mesto_delavec_delavec FOREIGN KEY (tk_delavec) REFERENCES delavec (id_delavec) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE delavec_lokal ADD CONSTRAINT tk_delavec_lokal_delavec FOREIGN KEY (tk_delavec) REFERENCES delavec (id_delavec) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE delavec_lokal ADD CONSTRAINT tk_delavec_lokal_lokal FOREIGN KEY (tk_lokal) REFERENCES lokal (id_lokal) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE lokal ADD CONSTRAINT tk_lokal_tip_lokala FOREIGN KEY (tk_tip_lokala) REFERENCES tip_lokala (id_tip_lokala) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE lokal ADD CONSTRAINT tk_lokal_nadstropje FOREIGN KEY (tk_nadstropje) REFERENCES nadstropje (id_nadstropje) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE lokal ADD CONSTRAINT tk_lokal_del_letališča FOREIGN KEY (tk_del_letališča) REFERENCES del_letališča (id_del_letališča) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE cona ADD CONSTRAINT tk_cona_del_letališča FOREIGN KEY (tk_del_letališča) REFERENCES del_letališča (id_del_letališča) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE cona ADD CONSTRAINT tk_cona_delavec FOREIGN KEY (tk_delavec) REFERENCES delavec (id_delavec) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE parkirišče_cenik ADD CONSTRAINT tk_parkirišče_cenik_cona FOREIGN KEY (tk_cona) REFERENCES cona (id_cona) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE parkirišče_cenik ADD CONSTRAINT tk_parkirišče_cenik_trajanje FOREIGN KEY (tk_trajanje) REFERENCES trajanje (id_trajanje) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE terminal ADD CONSTRAINT tk_terminal_del_letališča FOREIGN KEY (tk_del_letališča) REFERENCES del_letališča (id_del_letališča) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE izhod ADD CONSTRAINT tk_izhod_terminal FOREIGN KEY (tk_terminal) REFERENCES terminal (id_terminal) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE let ADD CONSTRAINT tk_let_letalska_družba FOREIGN KEY (tk_letalska_družba) REFERENCES letalska_družba (id_letalska_družba) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE let ADD CONSTRAINT tk_let_izhod FOREIGN KEY (tk_izhod) REFERENCES izhod (id_izhod) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE destinacija_let ADD CONSTRAINT tk_destinacija_let_destinacija FOREIGN KEY (tk_destinacija) REFERENCES destinacija (id_destinacija) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE destinacija_let ADD CONSTRAINT tk_destinacija_let_let FOREIGN KEY (tk_let) REFERENCES let (id_let) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE destinacija_let ADD CONSTRAINT tk_destinacija_let_tip_leta FOREIGN KEY (tk_tip_leta) REFERENCES tip_leta (id_tip_leta) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE delavec_let ADD CONSTRAINT tk_delavec_let_delavec FOREIGN KEY (tk_delavec) REFERENCES delavec (id_delavec) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE delavec_let ADD CONSTRAINT tk_delavec_let_let FOREIGN KEY (tk_let) REFERENCES let (id_let) ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE delavec_let ADD CONSTRAINT tk_delavec_let_delovno_mesto FOREIGN KEY (tk_delovno_mesto) REFERENCES delovno_mesto (id_delovno_mesto) ON DELETE CASCADE ON UPDATE NO ACTION;

INSERT INTO delavec VALUES (NULL, "Tadej", "Roškarič", "2000-11-17");
INSERT INTO delavec VALUES (NULL, "Andrej", "Mahnič", "1985-02-05");
INSERT INTO delavec VALUES (NULL, "Sanja", "Novak", "1975-08-16");
INSERT INTO delavec VALUES (NULL, "Mitja", "Breznik", NULL);
INSERT INTO delavec VALUES (NULL, "Ines", "Horvat", "1992-10-02");
INSERT INTO delavec VALUES (NULL, "Jožica", "Horvat", "1972-11-02");
INSERT INTO delavec VALUES (NULL, "Andreja", "Smolar", "1982-12-05");
INSERT INTO delavec VALUES (NULL, "Marija", "Jovanovič", NULL);
INSERT INTO delavec VALUES (NULL, "Matjaž", "Potočnik", "2002-01-12");
INSERT INTO delavec VALUES (NULL, "Boris", "Kangler", "1969-01-29");
INSERT INTO delavec VALUES (NULL, "Marjan", "Podobnik", "1971-06-03");
INSERT INTO delavec VALUES (NULL, "Anica", "Kuhar", "1977-05-01");

INSERT INTO delovno_mesto VALUES (NULL, "kontrolor zračnega prometa");
INSERT INTO delovno_mesto VALUES (NULL, "uradnik za varnost");
INSERT INTO delovno_mesto VALUES (NULL, "pilot");
INSERT INTO delovno_mesto VALUES (NULL, "stevard");
INSERT INTO delovno_mesto VALUES (NULL, "kuhar");
INSERT INTO delovno_mesto VALUES (NULL, "trgovec");
INSERT INTO delovno_mesto VALUES (NULL, "natakar");
INSERT INTO delovno_mesto VALUES (NULL, "informator");
INSERT INTO delovno_mesto VALUES (NULL, "redar na parkirišču");

INSERT INTO letalska_družba VALUES (NULL, "Air Serbia", "AS", 120);
INSERT INTO letalska_družba VALUES (NULL, "Lufthansa", "LH", 350);
INSERT INTO letalska_družba VALUES (NULL, "Adria Airways", "AA", 50);
INSERT INTO letalska_družba VALUES (NULL, "KLM", "KL", NULL);
INSERT INTO letalska_družba VALUES (NULL, "Šwiss International", "SW", NULL);

INSERT INTO tip_lokala VALUES (NULL, "bar");
INSERT INTO tip_lokala VALUES (NULL, "restavracija");
INSERT INTO tip_lokala VALUES (NULL, "informativni kiosk");
INSERT INTO tip_lokala VALUES (NULL, "trgovina z darili");
INSERT INTO tip_lokala VALUES (NULL, "trgovina");
INSERT INTO tip_lokala VALUES (NULL, "disko");

INSERT INTO nadstropje VALUES (NULL, 1);
INSERT INTO nadstropje VALUES (NULL, 2);
INSERT INTO nadstropje VALUES (NULL, 3);
INSERT INTO nadstropje VALUES (NULL, 4);
INSERT INTO nadstropje VALUES (NULL, 5);

INSERT INTO del_letališča VALUES (NULL, "lokali");
INSERT INTO del_letališča VALUES (NULL, "terminali");
INSERT INTO del_letališča VALUES (NULL, "parkirišča");

INSERT INTO trajanje VALUES (NULL, "do 15 minut");
INSERT INTO trajanje VALUES (NULL, "do 2 uri");
INSERT INTO trajanje VALUES (NULL, "od 2 do 4 ure");
INSERT INTO trajanje VALUES (NULL, "do 24 ur");
INSERT INTO trajanje VALUES (NULL, "več kot 24 ur");

INSERT INTO destinacija VALUES (NULL, "Frankfurt");
INSERT INTO destinacija VALUES (NULL, "Dunaj");
INSERT INTO destinacija VALUES (NULL, "Ljubljana");
INSERT INTO destinacija VALUES (NULL, "Beograd");
INSERT INTO destinacija VALUES (NULL, "Pariz");
INSERT INTO destinacija VALUES (NULL, "New York");

INSERT INTO tip_leta VALUES (NULL, "začetni");
INSERT INTO tip_leta VALUES (NULL, "vmesni");
INSERT INTO tip_leta VALUES (NULL, "končni");

INSERT INTO delovno_mesto_delavec VALUES (NULL, "2015-03-02", NULL, 1, 1);
INSERT INTO delovno_mesto_delavec VALUES (NULL, "2014-05-15", NULL, 2, 2);
INSERT INTO delovno_mesto_delavec VALUES (NULL, "2008-07-07", NULL, 4, 3);
INSERT INTO delovno_mesto_delavec VALUES (NULL, "2000-09-22", "2007-01-20", 4, 2);
INSERT INTO delovno_mesto_delavec VALUES (NULL, "1995-01-12", NULL, 3, 4);
INSERT INTO delovno_mesto_delavec VALUES (NULL, "2010-08-07", "2015-11-11", 5, 3);
INSERT INTO delovno_mesto_delavec VALUES (NULL, "2015-12-01", NULL, 8, 6);
INSERT INTO delovno_mesto_delavec VALUES (NULL, "2017-05-01", NULL, 6, 7);
INSERT INTO delovno_mesto_delavec VALUES (NULL, "2018-02-19", NULL, 6, 10);
INSERT INTO delovno_mesto_delavec VALUES (NULL, "2003-06-15", NULL, 8, 8);
INSERT INTO delovno_mesto_delavec VALUES (NULL, "2013-03-17", NULL, 2, 5);
INSERT INTO delovno_mesto_delavec VALUES (NULL, "2019-03-19", NULL, 7, 9);
INSERT INTO delovno_mesto_delavec VALUES (NULL, "2015-12-05", NULL, 9, 10);
INSERT INTO delovno_mesto_delavec VALUES (NULL, "2015-12-02", NULL, 9, 11);
INSERT INTO delovno_mesto_delavec VALUES (NULL, "2015-12-02", NULL, 5, 12);


INSERT INTO lokal VALUES (NULL, "Ljubljanček", 50, 2, 5, 2, 1);
INSERT INTO lokal VALUES (NULL, "Informacije 1", 15, 1, 3, 1, 1);
INSERT INTO lokal VALUES (NULL, "Gurmanček", 55, 3, 2, 3, 1);
INSERT INTO lokal VALUES (NULL, "Bar AS", 35, 2, 1, 1, 1);
INSERT INTO lokal VALUES (NULL, "Darilko", 25, 1, 4, 1, 1);
INSERT INTO lokal VALUES (NULL, "Spar", 100, 4, 5, 3, 1);
INSERT INTO lokal VALUES (NULL, "Bar na letališču", 30, 2, 1, 4, 1);
INSERT INTO lokal VALUES (NULL, "Informacije 2", 15, 1, 3, 3, 1);
INSERT INTO lokal VALUES (NULL, "Mercator", 45, 2, 5, 5, 1);
INSERT INTO lokal VALUES (NULL, "Okrepčevalnica", 47, 0, 2, 4, 1);
INSERT INTO lokal VALUES (NULL, "Restavracija 29", 50, 3, 2, 4, 1);
INSERT INTO lokal VALUES (NULL, "Bar Letalko", 25, 2, 1, 1, 1);

INSERT INTO cona VALUES (NULL, "A1", 200, 10, 3);
INSERT INTO cona VALUES (NULL, "A2", 100, 10, 3);
INSERT INTO cona VALUES (NULL, "A3", 150, 10, 3);
INSERT INTO cona VALUES (NULL, "P1", 120, 10, 3);
INSERT INTO cona VALUES (NULL, "P2", 100, 10, 3);
INSERT INTO cona VALUES (NULL, "P3", 110, 11, 3);
INSERT INTO cona VALUES (NULL, "H1", 80, 11, 3);
INSERT INTO cona VALUES (NULL, "H2", 90, 11, 3);
INSERT INTO cona VALUES (NULL, "H3", 82, 11, 3);
INSERT INTO cona VALUES (NULL, "PH", 55, 11, 3);

INSERT INTO parkirišče_cenik VALUES (NULL, 0.00,"2015-01-01", NULL, 1, 1);
INSERT INTO parkirišče_cenik VALUES (NULL, 0.00,"2015-01-01", NULL, 2, 1);
INSERT INTO parkirišče_cenik VALUES (NULL, 0.00,"2015-01-01", NULL, 3, 1);
INSERT INTO parkirišče_cenik VALUES (NULL, 5.00,"2016-01-01", NULL, 1, 2);
INSERT INTO parkirišče_cenik VALUES (NULL, 6.00,"2016-01-01", NULL, 2, 2);
INSERT INTO parkirišče_cenik VALUES (NULL, 5.50,"2016-01-01", NULL, 3, 2);
INSERT INTO parkirišče_cenik VALUES (NULL, 7.00,"2016-03-01", NULL, 1, 3);
INSERT INTO parkirišče_cenik VALUES (NULL, 7.50,"2016-03-01", NULL, 2, 3);
INSERT INTO parkirišče_cenik VALUES (NULL, 7.00,"2016-03-01", NULL, 3, 3);
INSERT INTO parkirišče_cenik VALUES (NULL, 8.00,"2018-01-01", "2019-12-01", 3, 3);

INSERT INTO terminal VALUES (NULL, "Terminal 1", 2);
INSERT INTO terminal VALUES (NULL, "Terminal 2", 2);
INSERT INTO terminal VALUES (NULL, "Terminal 3", 2);
INSERT INTO terminal VALUES (NULL, "Terminal 4", 2);
INSERT INTO terminal VALUES (NULL, "Terminal 5", 2);
INSERT INTO terminal VALUES (NULL, "Terminal 6", 2);
INSERT INTO terminal VALUES (NULL, "Terminal 7", 2);
INSERT INTO terminal VALUES (NULL, "Terminal 8", 2);
INSERT INTO terminal VALUES (NULL, "Terminal 9", 2);
INSERT INTO terminal VALUES (NULL, "Terminal 10", 2);

INSERT INTO izhod VALUES (NULL, "A15", 2);
INSERT INTO izhod VALUES (NULL, "A23", 2);
INSERT INTO izhod VALUES (NULL, "C20", 2);
INSERT INTO izhod VALUES (NULL, "G03", 3);
INSERT INTO izhod VALUES (NULL, "B09", 3);
INSERT INTO izhod VALUES (NULL, "E12", 4);
INSERT INTO izhod VALUES (NULL, "F07", 5);
INSERT INTO izhod VALUES (NULL, "H30", 5);
INSERT INTO izhod VALUES (NULL, "D22", 7);
INSERT INTO izhod VALUES (NULL, "A10", 10);

INSERT INTO let VALUES (NULL, "2022-04-08 20:15:00", "AS085", 0, 1, 3);
INSERT INTO let VALUES (NULL, "2021-05-16 11:10:00", "LH107", 1, 2, 10);
INSERT INTO let VALUES (NULL, "2021-02-03 15:25:00", "AA069", 0, 3, 7);
INSERT INTO let VALUES (NULL, "2021-11-12 10:00:00", "SW122", 0, 5, 2);
INSERT INTO let VALUES (NULL, "2021-10-02 12:35:00", "KL101", 2, 4, 5);
INSERT INTO let VALUES (NULL, "2022-07-09 21:10:00", "LH208", 0, 2, 1);
INSERT INTO let VALUES (NULL, "2021-03-15 8:45:00", "AA180", 0, 3, 8);
INSERT INTO let VALUES (NULL, "2022-04-30 14:40:00", "AS022", 1, 1, 9);
INSERT INTO let VALUES (NULL, "2022-04-06 10:00:00", "SW155", 0, 5, 5);
INSERT INTO let VALUES (NULL, "2022-04-08 9:55:00", "LH086", 0, 2, 4);
INSERT INTO let VALUES (NULL, "2022-04-25 9:55:00", "LH069", 0, 2, 4);
INSERT INTO let VALUES (NULL, "2022-04-24 10:55:00", "LH239", 0, 2, 4);
INSERT INTO let VALUES (NULL, "2021-10-01 11:35:00", "KL105", 0, 4, 5);

INSERT INTO destinacija_let VALUES (NULL, 4, 1, 3);
INSERT INTO destinacija_let VALUES (NULL, 1, 2, 1);
INSERT INTO destinacija_let VALUES (NULL, 5, 2, 3);
INSERT INTO destinacija_let VALUES (NULL, 2, 5, 1);
INSERT INTO destinacija_let VALUES (NULL, 1, 5, 2);
INSERT INTO destinacija_let VALUES (NULL, 6, 5, 3);
INSERT INTO destinacija_let VALUES (NULL, 3, 3, 3);
INSERT INTO destinacija_let VALUES (NULL, 3, 6, 3);
INSERT INTO destinacija_let VALUES (NULL, 2, 8, 1);
INSERT INTO destinacija_let VALUES (NULL, 5, 8, 3);
INSERT INTO destinacija_let VALUES (NULL, 1, 11, 3);
INSERT INTO destinacija_let VALUES (NULL, 1, 12, 3);
INSERT INTO destinacija_let VALUES (NULL, 1, 10, 3);
INSERT INTO destinacija_let VALUES (NULL, 2, 13, 3);


INSERT INTO delavec_lokal VALUES (NULL, 8, 2);
INSERT INTO delavec_lokal VALUES (NULL, 6, 8);
INSERT INTO delavec_lokal VALUES (NULL, 7, 1);
INSERT INTO delavec_lokal VALUES (NULL, 7, 5);
INSERT INTO delavec_lokal VALUES (NULL, 9, 4);
INSERT INTO delavec_lokal VALUES (NULL, 9, 7);
INSERT INTO delavec_lokal VALUES (NULL, 12, 3);
INSERT INTO delavec_lokal VALUES (NULL, 12, 6);
INSERT INTO delavec_lokal VALUES (NULL, 10, 9);
INSERT INTO delavec_lokal VALUES (NULL, 9, 3);

INSERT INTO delavec_let VALUES (NULL, 4, 2, 3);
INSERT INTO delavec_let VALUES (NULL, 3, 2, 4);
INSERT INTO delavec_let VALUES (NULL, 4, 5, 3);
INSERT INTO delavec_let VALUES (NULL, 3, 5, 4);
INSERT INTO delavec_let VALUES (NULL, 4, 9, 3);
INSERT INTO delavec_let VALUES (NULL, 4, 7, 3);
INSERT INTO delavec_let VALUES (NULL, 3, 1, 4);
INSERT INTO delavec_let VALUES (NULL, 3, 7, 3);
INSERT INTO delavec_let VALUES (NULL, 4, 10, 3);
INSERT INTO delavec_let VALUES (NULL, 3, 4, 4);