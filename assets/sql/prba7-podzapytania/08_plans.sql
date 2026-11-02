-- These statements execute SELECT only. Compare plans, not a single timing sample.
EXPLAIN (ANALYZE, BUFFERS)
SELECT p.participant_id, p.name FROM prba7_demo.participants AS p
WHERE p.participant_id IN (
    SELECT z.participant_id FROM prba7_demo.enrollments AS z
    JOIN prba7_demo.editions AS e ON e.edition_id = z.edition_id
    WHERE z.status = 'confirmed' AND e.course_id = 'SQL'
);
EXPLAIN (ANALYZE, BUFFERS)
SELECT DISTINCT p.participant_id, p.name
FROM prba7_demo.participants AS p
JOIN prba7_demo.enrollments AS z ON z.participant_id = p.participant_id
JOIN prba7_demo.editions AS e ON e.edition_id = z.edition_id
WHERE z.status = 'confirmed' AND e.course_id = 'SQL';
