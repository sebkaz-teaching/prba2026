-- 90% of rows match. Compare this plan with the selective edition query.
EXPLAIN (ANALYZE, BUFFERS)
SELECT participant_id, edition_id, status
FROM prba6_demo.enrollments
WHERE status = 'confirmed';

SELECT pg_size_pretty(pg_relation_size('prba6_demo.enrollments')) AS table_size,
       pg_size_pretty(pg_indexes_size('prba6_demo.enrollments')) AS indexes_size;
