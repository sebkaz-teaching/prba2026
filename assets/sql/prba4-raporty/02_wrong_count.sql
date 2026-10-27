SELECT edition_id, COUNT(*) AS registrations
FROM enrollments GROUP BY edition_id ORDER BY edition_id;
