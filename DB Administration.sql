CREATE USER programski_dostop IDENTIFIED BY "geslo123";
CREATE USER tadej_roskaric IDENTIFIED BY "geslo321";

GRANT SELECT, INSERT, UPDATE, DELETE ON baza_tadej.* TO programski_dostop;

GRANT SELECT ON *.* TO tadej_roskaric;
