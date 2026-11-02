-- The aggregate returns one row: average limit = 3. E3 is above average.
SELECT edition_id, seat_limit FROM prba7_demo.editions
WHERE seat_limit > (SELECT AVG(seat_limit) FROM prba7_demo.editions)
ORDER BY edition_id;
-- A nonaggregate scalar subquery returning zero rows has the value NULL.
SELECT (SELECT edition_id FROM prba7_demo.editions WHERE course_id = 'MISSING') AS no_match;
-- Correlated aggregate: P1=2, P2=1, P3=1, P4=0.
SELECT p.participant_id, p.name, (
    SELECT COUNT(*) FROM prba7_demo.enrollments AS z
    WHERE z.participant_id = p.participant_id AND z.status = 'confirmed'
) AS confirmed_count
FROM prba7_demo.participants AS p ORDER BY p.participant_id;
