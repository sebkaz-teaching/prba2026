SELECT e.edition_id, COUNT(*) AS confirmed
FROM editions AS e
LEFT JOIN enrollments AS z
 ON z.edition_id = e.edition_id AND z.status = 'confirmed'
GROUP BY e.edition_id ORDER BY e.edition_id;
