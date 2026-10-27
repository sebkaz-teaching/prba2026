SELECT p.participant_id, p.name, z.edition_id
FROM enrollments AS z
JOIN participants AS p ON p.participant_id = z.participant_id
WHERE z.edition_id = 'E1' AND z.status = 'confirmed'
ORDER BY p.name, p.participant_id;
