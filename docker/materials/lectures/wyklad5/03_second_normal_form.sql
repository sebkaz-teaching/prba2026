CREATE TABLE participants_2nf (
    participant_id TEXT NOT NULL PRIMARY KEY,
    name TEXT NOT NULL
);
CREATE TABLE editions_2nf (
    edition_id TEXT NOT NULL PRIMARY KEY,
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
    CHECK (starts_at < ends_at)
);
CREATE TABLE enrollments_2nf (
    participant_id TEXT NOT NULL REFERENCES participants_2nf(participant_id),
    edition_id TEXT NOT NULL REFERENCES editions_2nf(edition_id),
    status TEXT NOT NULL CHECK (status IN ('confirmed', 'cancelled')),
    PRIMARY KEY (participant_id, edition_id)
);
INSERT INTO participants_2nf (participant_id, name)
SELECT DISTINCT participant_id, participant_name FROM flat_enrollments;
INSERT INTO editions_2nf (
    edition_id, course_id, course_name, starts_at, ends_at,
    room_id, room_name, room_capacity, instructor_id, instructor_name, seat_limit
)
SELECT DISTINCT edition_id, course_id, course_name, starts_at, ends_at,
    room_id, room_name, room_capacity, instructor_id, instructor_name, seat_limit
FROM flat_enrollments;
INSERT INTO enrollments_2nf (participant_id, edition_id, status)
SELECT participant_id, edition_id, status FROM flat_enrollments;
SELECT * FROM editions_2nf ORDER BY edition_id;
