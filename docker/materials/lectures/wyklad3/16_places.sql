SELECT e.edition_id, e.seat_limit,
       COUNT(z.participant_id) AS confirmed,
       e.seat_limit - COUNT(z.participant_id) AS free_places
FROM editions AS e
LEFT JOIN enrollments AS z
  ON z.edition_id = e.edition_id
 AND z.status = 'confirmed'
GROUP BY e.edition_id, e.seat_limit
ORDER BY e.edition_id;
