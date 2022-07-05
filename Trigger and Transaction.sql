# Prožilec za štetje števila postankov

DELIMITER &
CREATE TRIGGER štetje_števila_postankov 
AFTER INSERT ON destinacija_let
FOR EACH ROW 
BEGIN
    IF (NEW.tk_tip_leta) != (SELECT id_tip_leta FROM tip_leta WHERE tip_leta.naziv="končni") THEN
        UPDATE let SET št_postankov = št_postankov + 1 WHERE NEW.tk_let = let.id_let;
    END IF;
END&
DELIMITER ;

# Transakcija
START TRANSACTION;

SAVEPOINT točka;

INSERT INTO cona VALUES (NULL, "U2", 150, 11, 3);

INSERT INTO parkirišče_cenik VALUES (NULL, 5.50, "2022-01-01", NULL, (SELECT MAX(id_cona) FROM cona), 2);

COMMIT;
ROLLBACK;
