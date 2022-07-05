# Kateri delavci so zaposleni na delovnem mestu "uradnik za varnost"?
SELECT * FROM delavec, delovno_mesto_delavec, delovno_mesto WHERE delavec.id_delavec=delovno_mesto_delavec.tk_delavec 
AND delovno_mesto_delavec.tk_delovno_mesto=delovno_mesto.id_delovno_mesto AND delovno_mesto.naziv="uradnik za varnost";

# Izpisite vse kategorije lokalov in pripadajoce lokale. Kategorije naj se izpisejo, tudi ce v njih ni se nobenega lokala.
SELECT * FROM tip_lokala LEFT JOIN lokal ON lokal.tk_tip_lokala=tip_lokala.id_tip_lokala;

# Izpisite vsakega delavca in datum zaposlitve. Izracunajte trenutno stevilo dni zaposlitve vsakega delavca.
SELECT ime, priimek, od, DATEDIFF(CURDATE(), od) "število dni zaposlitve" FROM delavec, delovno_mesto_delavec WHERE delavec.id_delavec=delovno_mesto_delavec.tk_delavec AND delovno_mesto_delavec.do IS NULL;

# Koliko lokalov posameznega tipa se nahaja na posameznem nadstropju?
SELECT nadstropje, naziv, COUNT(id_tip_lokala) "število lokalov" FROM lokal, tip_lokala, nadstropje 
WHERE tip_lokala.id_tip_lokala=lokal.tk_tip_lokala AND lokal.tk_nadstropje=nadstropje.id_nadstropje GROUP BY id_tip_lokala, id_nadstropje ORDER BY nadstropje;

# Katera letalska druzba je v prejsnjem mesecu imela najvec odhodnih letov?
SELECT letalska_družba.naziv, COUNT(*) število_odhodnih_letov FROM let, letalska_družba, destinacija_let,tip_leta, destinacija WHERE MONTH(let.čas) = MONTH(CURDATE())-1
AND let.tk_letalska_družba=letalska_družba.id_letalska_družba 
AND destinacija_let.tk_let=let.id_let AND destinacija_let.tk_tip_leta=tip_leta.id_tip_leta AND (št_postankov=0 OR (št_postankov!=0 AND tip_leta.naziv="začetni")) AND destinacija.id_destinacija=destinacija_let.tk_destinacija AND destinacija.naziv!="Ljubljana" GROUP BY letalska_družba.naziv 

HAVING število_odhodnih_letov = (SELECT MAX(število_odhodnih_letov) FROM 
(SELECT letalska_družba.naziv, COUNT(*) število_odhodnih_letov FROM let, letalska_družba, destinacija_let,tip_leta, destinacija WHERE MONTH(let.čas) = MONTH(CURDATE())-1
AND let.tk_letalska_družba=letalska_družba.id_letalska_družba 
AND destinacija_let.tk_let=let.id_let AND destinacija_let.tk_tip_leta=tip_leta.id_tip_leta AND (št_postankov=0 OR (št_postankov!=0 AND tip_leta.naziv="začetni")) AND destinacija.id_destinacija=destinacija_let.tk_destinacija AND destinacija.naziv!="Ljubljana" GROUP BY letalska_družba.naziv)temp);

# Na katera druga letalisca smo imeli lani vec odhodnih letov, kot je povprecje evidentirano za ta letalisca?
SELECT destinacija.naziv, COUNT(*) število_odhodnih_letov FROM destinacija_let, tip_leta, destinacija, let 
WHERE destinacija_let.tk_tip_leta=tip_leta.id_tip_leta AND (št_postankov=0 OR (št_postankov!=0 AND tip_leta.naziv="začetni"))
AND destinacija.id_destinacija=destinacija_let.tk_destinacija AND YEAR(let.čas) = YEAR(CURDATE())-1  AND destinacija_let.tk_let=let.id_let AND destinacija.naziv!="Ljubljana" GROUP BY destinacija.naziv

HAVING število_odhodnih_letov > (SELECT AVG(število_odhodnih_letov) FROM (SELECT destinacija.naziv, COUNT(*) število_odhodnih_letov FROM destinacija_let, tip_leta, destinacija, let 
WHERE destinacija_let.tk_tip_leta=tip_leta.id_tip_leta AND (št_postankov=0 OR (št_postankov!=0 AND tip_leta.naziv="začetni"))
AND destinacija.id_destinacija=destinacija_let.tk_destinacija AND YEAR(let.čas) = YEAR(CURDATE())-1  AND destinacija_let.tk_let=let.id_let AND destinacija.naziv!="Ljubljana" GROUP BY destinacija.naziv)temp);

# Spremeni naziv letalske druzbe Swiss International" v Swiss International Air Lines".
UPDATE letalska_družba SET naziv="Šwiss International Air Lines" WHERE naziv="Šwiss International" AND letalska_družba.id_letalska_družba != 0;

# Izbrisi trgovino "Ljubljancek".
DELETE FROM lokal WHERE lokal.ime_lokala="Ljubljanček" AND lokal.id_lokal != 0