-- Delete a registration, not the person. This is a demonstration only.
DELETE FROM enrollments WHERE participant_id = 'U1' AND edition_id = 'E1';
SELECT * FROM participants WHERE participant_id = 'U1';
SELECT * FROM enrollments WHERE participant_id = 'U1';
-- Restore the registration so the closing report uses the familiar baseline.
INSERT INTO enrollments (participant_id, edition_id, status)
VALUES ('U1', 'E1', 'confirmed');
SELECT e.edition_id, e.seat_limit - COUNT(z.participant_id) AS free_places
FROM editions AS e LEFT JOIN enrollments AS z
 ON z.edition_id = e.edition_id AND z.status = 'confirmed'
GROUP BY e.edition_id, e.seat_limit ORDER BY e.edition_id;
