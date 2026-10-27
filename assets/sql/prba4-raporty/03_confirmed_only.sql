SELECT edition_id, COUNT(*) AS confirmed
FROM enrollments WHERE status = 'confirmed'
GROUP BY edition_id ORDER BY edition_id;
