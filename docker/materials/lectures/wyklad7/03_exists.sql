-- EXISTS tests membership without multiplying outer rows.
SELECT p.participant_id, p.name FROM prba7_demo.participants AS p
WHERE EXISTS (
    SELECT 1 FROM prba7_demo.enrollments AS z
    JOIN prba7_demo.editions AS e ON e.edition_id = z.edition_id
    WHERE z.participant_id = p.participant_id
      AND z.status = 'confirmed' AND e.course_id = 'SQL'
)
ORDER BY p.participant_id;
-- No confirmed enrollment -> Dawid (P4).
SELECT p.participant_id, p.name FROM prba7_demo.participants AS p
WHERE NOT EXISTS (
    SELECT 1 FROM prba7_demo.enrollments AS z
    WHERE z.participant_id = p.participant_id AND z.status = 'confirmed'
)
ORDER BY p.participant_id;
