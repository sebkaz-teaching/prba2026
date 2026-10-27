-- Repair the deliberate anomaly before copying data.
UPDATE editions_2nf SET room_name = 'Sala szkoleniowa' WHERE room_id = 'S1';
CREATE TABLE participants (
    participant_id TEXT NOT NULL PRIMARY KEY,
    name TEXT NOT NULL
);
CREATE TABLE courses (
    course_id TEXT NOT NULL PRIMARY KEY,
    name TEXT NOT NULL
);
CREATE TABLE rooms (
    room_id TEXT NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    capacity INTEGER NOT NULL CHECK (capacity > 0)
);
CREATE TABLE instructors (
    instructor_id TEXT NOT NULL PRIMARY KEY,
    name TEXT NOT NULL
);
CREATE TABLE editions (
    edition_id TEXT NOT NULL PRIMARY KEY,
    course_id TEXT NOT NULL REFERENCES courses(course_id),
    starts_at TIMESTAMP NOT NULL,
    ends_at TIMESTAMP NOT NULL,
    room_id TEXT NOT NULL REFERENCES rooms(room_id),
    instructor_id TEXT NOT NULL REFERENCES instructors(instructor_id),
    seat_limit INTEGER NOT NULL CHECK (seat_limit > 0),
    CHECK (starts_at < ends_at)
);
CREATE TABLE enrollments (
    participant_id TEXT NOT NULL REFERENCES participants(participant_id),
    edition_id TEXT NOT NULL REFERENCES editions(edition_id),
    status TEXT NOT NULL CHECK (status IN ('confirmed', 'cancelled')),
    PRIMARY KEY (participant_id, edition_id)
);
INSERT INTO participants (participant_id, name)
SELECT participant_id, name FROM participants_2nf;
INSERT INTO courses (course_id, name)
SELECT DISTINCT course_id, course_name FROM editions_2nf;
INSERT INTO rooms (room_id, name, capacity)
SELECT DISTINCT room_id, room_name, room_capacity FROM editions_2nf;
INSERT INTO instructors (instructor_id, name)
SELECT DISTINCT instructor_id, instructor_name FROM editions_2nf;
INSERT INTO editions (
    edition_id, course_id, starts_at, ends_at, room_id, instructor_id, seat_limit
)
SELECT edition_id, course_id, starts_at, ends_at, room_id, instructor_id, seat_limit
FROM editions_2nf;
INSERT INTO enrollments (participant_id, edition_id, status)
SELECT participant_id, edition_id, status FROM enrollments_2nf;
CREATE VIEW enrollment_report AS
SELECT p.participant_id, p.name AS participant_name, e.edition_id,
       c.course_id, c.name AS course_name, e.starts_at, e.ends_at,
       r.room_id, r.name AS room_name, r.capacity AS room_capacity,
       i.instructor_id, i.name AS instructor_name, e.seat_limit, z.status
FROM enrollments AS z
JOIN participants AS p ON p.participant_id = z.participant_id
JOIN editions AS e ON e.edition_id = z.edition_id
JOIN courses AS c ON c.course_id = e.course_id
JOIN rooms AS r ON r.room_id = e.room_id
JOIN instructors AS i ON i.instructor_id = e.instructor_id;
SELECT * FROM enrollment_report ORDER BY edition_id, participant_id;
