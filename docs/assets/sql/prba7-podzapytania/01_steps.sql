-- Step 1: SQL editions -> E1, E2.
SELECT edition_id FROM prba7_demo.editions WHERE course_id = 'SQL' ORDER BY edition_id;
-- Step 2: matching confirmed enrollments -> P1/E1, P1/E2, P2/E1.
SELECT participant_id, edition_id FROM prba7_demo.enrollments
WHERE status = 'confirmed' AND edition_id IN (
    SELECT edition_id FROM prba7_demo.editions WHERE course_id = 'SQL'
)
ORDER BY participant_id, edition_id;
-- Step 3: participant membership -> Anna, Bartek (one row per participant).
SELECT p.participant_id, p.name FROM prba7_demo.participants AS p
WHERE p.participant_id IN (
    SELECT z.participant_id FROM prba7_demo.enrollments AS z
    WHERE z.status = 'confirmed' AND z.edition_id IN (
        SELECT e.edition_id FROM prba7_demo.editions AS e WHERE e.course_id = 'SQL'
    )
)
ORDER BY p.participant_id;
