SELECT p.name, e.edition_id, c.name AS course,
       z.status
FROM enrollments AS z
JOIN participants AS p USING (participant_id)
JOIN editions AS e USING (edition_id)
JOIN courses AS c USING (course_id)
ORDER BY e.edition_id, p.participant_id;
