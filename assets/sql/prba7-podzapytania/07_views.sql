CREATE VIEW prba7_demo.edition_summary AS
SELECT e.edition_id, e.course_id, e.seat_limit,
       COUNT(z.participant_id) AS confirmed_count,
       e.seat_limit - COUNT(z.participant_id) AS free_places
FROM prba7_demo.editions AS e
LEFT JOIN prba7_demo.enrollments AS z
    ON z.edition_id = e.edition_id AND z.status = 'confirmed'
GROUP BY e.edition_id, e.course_id, e.seat_limit;
SELECT * FROM prba7_demo.edition_summary ORDER BY edition_id;
SELECT edition_id, free_places FROM prba7_demo.edition_summary
WHERE free_places > 0 ORDER BY edition_id;
-- A regular view reflects source changes. ROLLBACK restores the dataset.
BEGIN;
UPDATE prba7_demo.enrollments SET status = 'cancelled'
WHERE participant_id = 'P2' AND edition_id = 'E1';
SELECT * FROM prba7_demo.edition_summary WHERE edition_id = 'E1';
ROLLBACK;
SELECT * FROM prba7_demo.edition_summary WHERE edition_id = 'E1';
CREATE VIEW prba7_demo.small_editions AS
SELECT edition_id, course_id, seat_limit FROM prba7_demo.editions
WHERE seat_limit <= 3 WITH CHECK OPTION;
-- Successful update through an automatically updatable view; then restore it.
BEGIN;
UPDATE prba7_demo.small_editions SET seat_limit = 3 WHERE edition_id = 'E1';
SELECT * FROM prba7_demo.small_editions ORDER BY edition_id;
ROLLBACK;
