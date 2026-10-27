SELECT c.course_id, c.name,
 COUNT(z.participant_id) AS confirmed_registrations,
 COUNT(DISTINCT z.participant_id) AS distinct_participants
FROM courses AS c
LEFT JOIN editions AS e ON e.course_id = c.course_id
LEFT JOIN enrollments AS z
 ON z.edition_id = e.edition_id AND z.status = 'confirmed'
GROUP BY c.course_id, c.name ORDER BY c.course_id;
