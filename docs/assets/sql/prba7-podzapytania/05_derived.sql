-- Aggregate first, filter the resulting relation: E1=2, E2=1, E3=1; result E1.
SELECT q.edition_id, q.confirmed_count FROM (
    SELECT edition_id, COUNT(*) AS confirmed_count
    FROM prba7_demo.enrollments WHERE status = 'confirmed' GROUP BY edition_id
) AS q
WHERE q.confirmed_count >= 2 ORDER BY q.edition_id;
-- The same logical operation using HAVING.
SELECT edition_id, COUNT(*) AS confirmed_count
FROM prba7_demo.enrollments WHERE status = 'confirmed'
GROUP BY edition_id HAVING COUNT(*) >= 2 ORDER BY edition_id;
-- LEFT JOIN preserves E4. COUNT(z.participant_id) ignores the null-extended row.
SELECT e.edition_id, COUNT(z.participant_id) AS confirmed_count
FROM prba7_demo.editions AS e
LEFT JOIN prba7_demo.enrollments AS z
    ON z.edition_id = e.edition_id AND z.status = 'confirmed'
GROUP BY e.edition_id ORDER BY e.edition_id;
