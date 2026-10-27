-- A room is still described once per edition.
UPDATE editions_2nf SET room_name = 'Sala Alfa' WHERE edition_id = 'E1';
SELECT edition_id, room_id, room_name, room_capacity, seat_limit
FROM editions_2nf ORDER BY edition_id;
