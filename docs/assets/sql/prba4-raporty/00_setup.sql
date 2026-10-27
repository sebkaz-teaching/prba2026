-- Run once in a new PostgreSQL database.
BEGIN;
CREATE TABLE participants (
    participant_id TEXT NOT NULL PRIMARY KEY,
    name TEXT NOT NULL
);
INSERT INTO participants VALUES
    ('U1', 'Ada'), ('U2', 'Bartek'), ('U3', 'Celina');
SELECT * FROM participants ORDER BY participant_id;

CREATE TABLE courses (
    course_id TEXT NOT NULL PRIMARY KEY,
    name TEXT NOT NULL
);
INSERT INTO courses VALUES
    ('K1', 'Obsluga wyposazenia'),
    ('K2', 'Pierwsza pomoc');

CREATE TABLE editions (
    edition_id TEXT NOT NULL PRIMARY KEY,
    course_id TEXT NOT NULL REFERENCES courses(course_id),
    starts_at TIMESTAMP NOT NULL,
    seat_limit INTEGER NOT NULL CHECK (seat_limit > 0)
);
INSERT INTO editions VALUES
    ('E1', 'K1', '2027-02-01 08:00', 2),
    ('E2', 'K1', '2027-02-01 10:00', 4),
    ('E3', 'K2', '2027-02-01 12:00', 4);

CREATE TABLE enrollments (
    participant_id TEXT NOT NULL
        REFERENCES participants(participant_id),
    edition_id TEXT NOT NULL REFERENCES editions(edition_id),
    status TEXT NOT NULL
        CHECK (status IN ('confirmed', 'cancelled')),
    PRIMARY KEY (participant_id, edition_id)
);
INSERT INTO enrollments VALUES
    ('U1', 'E1', 'confirmed'),
    ('U2', 'E1', 'confirmed'),
    ('U3', 'E2', 'confirmed'),
    ('U2', 'E2', 'cancelled');

COMMIT;
