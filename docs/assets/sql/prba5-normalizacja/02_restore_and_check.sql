-- Restore the known source value, not an arbitrary MIN/MAX choice.
UPDATE flat_enrollments SET room_name = 'Sala szkoleniowa' WHERE room_id = 'S1';
-- Run checks separately: every result must be empty before decomposition.
SELECT room_id FROM flat_enrollments GROUP BY room_id
HAVING COUNT(DISTINCT room_name) > 1 OR COUNT(DISTINCT room_capacity) > 1;
SELECT participant_id FROM flat_enrollments GROUP BY participant_id
HAVING COUNT(DISTINCT participant_name) > 1;
SELECT course_id FROM flat_enrollments GROUP BY course_id
HAVING COUNT(DISTINCT course_name) > 1;
SELECT instructor_id FROM flat_enrollments GROUP BY instructor_id
HAVING COUNT(DISTINCT instructor_name) > 1;
SELECT edition_id FROM flat_enrollments GROUP BY edition_id
HAVING COUNT(DISTINCT course_id) > 1 OR COUNT(DISTINCT starts_at) > 1
    OR COUNT(DISTINCT ends_at) > 1 OR COUNT(DISTINCT room_id) > 1
    OR COUNT(DISTINCT instructor_id) > 1 OR COUNT(DISTINCT seat_limit) > 1;
