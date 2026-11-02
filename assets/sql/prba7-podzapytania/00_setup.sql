-- Run once in prba7_pokaz. Existing schemas are never overwritten.
BEGIN;
CREATE SCHEMA prba7_demo;
CREATE TABLE prba7_demo.participants (
    participant_id text PRIMARY KEY, name text NOT NULL
);
CREATE TABLE prba7_demo.courses (
    course_id text PRIMARY KEY, name text NOT NULL
);
CREATE TABLE prba7_demo.editions (
    edition_id text PRIMARY KEY,
    course_id text NOT NULL REFERENCES prba7_demo.courses,
    seat_limit integer NOT NULL CHECK (seat_limit > 0)
);
CREATE TABLE prba7_demo.enrollments (
    participant_id text NOT NULL REFERENCES prba7_demo.participants,
    edition_id text NOT NULL REFERENCES prba7_demo.editions,
    status text NOT NULL CHECK (status IN ('confirmed', 'cancelled')),
    PRIMARY KEY (participant_id, edition_id)
);
INSERT INTO prba7_demo.participants VALUES
    ('P1', 'Anna'), ('P2', 'Bartek'), ('P3', 'Celina'), ('P4', 'Dawid');
INSERT INTO prba7_demo.courses VALUES ('SQL', 'Podstawy SQL'), ('PY', 'Python');
INSERT INTO prba7_demo.editions VALUES ('E1', 'SQL', 2), ('E2', 'SQL', 3), ('E3', 'PY', 5), ('E4', 'PY', 2);
INSERT INTO prba7_demo.enrollments VALUES
    ('P1', 'E1', 'confirmed'), ('P1', 'E2', 'confirmed'),
    ('P2', 'E1', 'confirmed'), ('P3', 'E2', 'cancelled'), ('P3', 'E3', 'confirmed');
COMMIT;
SELECT * FROM prba7_demo.editions ORDER BY edition_id;
SELECT * FROM prba7_demo.enrollments ORDER BY participant_id, edition_id;
