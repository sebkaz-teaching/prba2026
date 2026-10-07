-- Run once after creating the agreed schema in a fresh database.
PRAGMA foreign_keys=ON;
BEGIN;
INSERT INTO participants VALUES ('U1','Ada'),('U2','Bartek'),('U3','Celina');
INSERT INTO instructors VALUES ('I1','Igor'),('I2','Ewa');
INSERT INTO rooms VALUES ('S1','Sala 1',2),('S2','Sala 2',4);
INSERT INTO courses VALUES ('K1','Obsługa wyposażenia'),('K2','Pierwsza pomoc');
INSERT INTO editions VALUES
('E1','K1','S1','I1','2027-02-01 08:00','2027-02-01 10:00',2),
('E2','K1','S2','I2','2027-02-01 10:00','2027-02-01 12:00',4),
('E3','K2','S2','I2','2027-02-01 12:00','2027-02-01 14:00',4);
INSERT INTO enrollments VALUES
('U1','E1','confirmed'),('U2','E1','confirmed'),
('U3','E2','confirmed'),('U2','E2','cancelled');
COMMIT;
