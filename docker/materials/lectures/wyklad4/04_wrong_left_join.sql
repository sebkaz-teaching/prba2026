SELECT e.edition_id, COUNT(z.participant_id) AS confirmed
FROM editions AS e
LEFT JOIN enrollments AS z ON z.edition_id = e.edition_id
WHERE z.status = 'confirmed'
GROUP BY e.edition_id ORDER BY e.edition_id;
