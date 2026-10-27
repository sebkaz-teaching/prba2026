-- Add a known requirement absent from the original enrollment-only sheet.
-- E3 cannot be inferred from a sheet containing no registrations for E3.
INSERT INTO courses (course_id, name) VALUES ('K2', 'Pierwsza pomoc');
INSERT INTO rooms (room_id, name, capacity) VALUES ('S2', 'Sala medyczna', 12);
INSERT INTO editions (
    edition_id, course_id, starts_at, ends_at, room_id, instructor_id, seat_limit
) VALUES ('E3', 'K2', '2027-02-01 12:00', '2027-02-01 14:00', 'S2', 'P1', 4);
SELECT e.edition_id, e.seat_limit,
       COUNT(z.participant_id) AS confirmed,
       e.seat_limit - COUNT(z.participant_id) AS free_places
FROM editions AS e
LEFT JOIN enrollments AS z
 ON z.edition_id = e.edition_id AND z.status = 'confirmed'
GROUP BY e.edition_id, e.seat_limit ORDER BY e.edition_id;
