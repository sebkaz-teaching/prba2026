-- Deliberately change only one copy of the current room name.
UPDATE flat_enrollments SET room_name = 'Sala Alfa'
WHERE participant_id = 'U1' AND edition_id = 'E1';
SELECT edition_id, participant_id, room_id, room_name
FROM flat_enrollments ORDER BY edition_id, participant_id;
