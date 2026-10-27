UPDATE rooms SET name = 'Sala Alfa' WHERE room_id = 'S1';
SELECT edition_id, participant_id, room_id, room_name
FROM enrollment_report ORDER BY edition_id, participant_id;
SELECT e.edition_id, r.capacity, e.seat_limit
FROM editions AS e JOIN rooms AS r ON r.room_id = e.room_id
ORDER BY e.edition_id;
