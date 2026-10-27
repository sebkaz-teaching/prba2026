-- Run once in a new, empty PostgreSQL database.
CREATE TABLE flat_enrollments (
    participant_id TEXT NOT NULL,
    participant_name TEXT NOT NULL,
    edition_id TEXT NOT NULL,
    course_id TEXT NOT NULL,
    course_name TEXT NOT NULL,
    starts_at TIMESTAMP NOT NULL,
    ends_at TIMESTAMP NOT NULL,
    room_id TEXT NOT NULL,
    room_name TEXT NOT NULL,
    room_capacity INTEGER NOT NULL CHECK (room_capacity > 0),
    instructor_id TEXT NOT NULL,
    instructor_name TEXT NOT NULL,
    seat_limit INTEGER NOT NULL CHECK (seat_limit > 0),
    status TEXT NOT NULL CHECK (status IN ('confirmed', 'cancelled')),
    PRIMARY KEY (participant_id, edition_id),
    CHECK (starts_at < ends_at)
);
-- Every row supplies all fourteen columns explicitly; no hidden JOIN.
INSERT INTO flat_enrollments (
    participant_id, participant_name, edition_id, course_id, course_name,
    starts_at, ends_at, room_id, room_name, room_capacity,
    instructor_id, instructor_name, seat_limit, status
) VALUES
    ('U1', 'Ada', 'E1', 'K1', 'Obsluga wyposazenia',
     '2027-02-01 08:00', '2027-02-01 10:00', 'S1', 'Sala szkoleniowa', 20,
     'P1', 'Jan Nowak', 2, 'confirmed'),
    ('U2', 'Bartek', 'E1', 'K1', 'Obsluga wyposazenia',
     '2027-02-01 08:00', '2027-02-01 10:00', 'S1', 'Sala szkoleniowa', 20,
     'P1', 'Jan Nowak', 2, 'confirmed'),
    ('U3', 'Celina', 'E2', 'K1', 'Obsluga wyposazenia',
     '2027-02-01 10:00', '2027-02-01 12:00', 'S1', 'Sala szkoleniowa', 20,
     'P2', 'Ewa Lis', 4, 'confirmed'),
    ('U2', 'Bartek', 'E2', 'K1', 'Obsluga wyposazenia',
     '2027-02-01 10:00', '2027-02-01 12:00', 'S1', 'Sala szkoleniowa', 20,
     'P2', 'Ewa Lis', 4, 'cancelled');
SELECT * FROM flat_enrollments ORDER BY edition_id, participant_id;
