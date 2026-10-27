-- Run before creating the additional index. Save the full plan.
SELECT indexname, indexdef FROM pg_indexes
WHERE schemaname = 'prba6_demo' AND tablename = 'enrollments';
EXPLAIN (ANALYZE, BUFFERS)
SELECT participant_id
FROM prba6_demo.enrollments
WHERE edition_id = 42 AND status = 'confirmed'
ORDER BY participant_id;
