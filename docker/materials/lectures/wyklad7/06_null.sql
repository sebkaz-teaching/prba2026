-- UNKNOWN, not TRUE: WHERE would discard this result.
SELECT 'P4' NOT IN ('P1', NULL) AS not_in_with_null;
-- A nullable imported list is deliberately separate from the constrained course tables.
WITH imported_ids(participant_id) AS (VALUES ('P1'::text), (NULL::text))
SELECT p.participant_id FROM prba7_demo.participants AS p
WHERE p.participant_id NOT IN (SELECT participant_id FROM imported_ids)
ORDER BY p.participant_id;
-- NOT EXISTS ignores the unmatched NULL: P2, P3, P4.
WITH imported_ids(participant_id) AS (VALUES ('P1'::text), (NULL::text))
SELECT p.participant_id FROM prba7_demo.participants AS p
WHERE NOT EXISTS (
    SELECT 1 FROM imported_ids AS i WHERE i.participant_id = p.participant_id
)
ORDER BY p.participant_id;
