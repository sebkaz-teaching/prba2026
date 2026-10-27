-- Remove only the additional teaching index; keep all data and constraints.
DROP INDEX IF EXISTS prba6_demo.enrollments_edition_status_participant_idx;
ANALYZE prba6_demo.enrollments;
-- Repeat 01_before.sql, 02_index.sql and 03_after.sql in order.
