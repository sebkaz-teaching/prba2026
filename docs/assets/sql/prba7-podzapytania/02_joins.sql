-- A JOIN returns matching combinations: Anna appears twice.
SELECT p.participant_id, p.name, e.edition_id
FROM prba7_demo.participants AS p
JOIN prba7_demo.enrollments AS z ON z.participant_id = p.participant_id
JOIN prba7_demo.editions AS e ON e.edition_id = z.edition_id
WHERE z.status = 'confirmed' AND e.course_id = 'SQL'
ORDER BY p.participant_id, e.edition_id;
-- Match the participant list returned by IN. Deduplicate by identity, not name alone.
SELECT DISTINCT p.participant_id, p.name
FROM prba7_demo.participants AS p
JOIN prba7_demo.enrollments AS z ON z.participant_id = p.participant_id
JOIN prba7_demo.editions AS e ON e.edition_id = z.edition_id
WHERE z.status = 'confirmed' AND e.course_id = 'SQL'
ORDER BY p.participant_id;
