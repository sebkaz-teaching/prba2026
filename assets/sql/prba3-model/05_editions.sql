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
