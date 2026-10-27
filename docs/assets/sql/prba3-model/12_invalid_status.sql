-- Expected error: run separately with Auto commit enabled.
UPDATE enrollments SET status = 'banana'
WHERE participant_id = 'U2' AND edition_id = 'E2';
