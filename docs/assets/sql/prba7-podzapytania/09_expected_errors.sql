-- Run each example SEPARATELY with Auto commit enabled. Expected errors.
-- 21000: two SQL editions cannot be used as one scalar value.
SELECT (SELECT edition_id FROM prba7_demo.editions WHERE course_id = 'SQL');
-- 44000: CHECK OPTION rejects a row outside the view predicate; E1 stays unchanged.
UPDATE prba7_demo.small_editions SET seat_limit = 10 WHERE edition_id = 'E1';
