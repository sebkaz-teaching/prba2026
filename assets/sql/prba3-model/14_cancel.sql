UPDATE enrollments SET status = 'cancelled'
WHERE participant_id = 'U2' AND edition_id = 'E1';
SELECT * FROM enrollments
WHERE participant_id = 'U2' ORDER BY edition_id;
