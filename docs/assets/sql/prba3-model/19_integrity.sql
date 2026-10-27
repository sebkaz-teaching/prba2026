-- List declared constraints and their validation state.
SELECT conrelid::regclass AS table_name, conname, contype, convalidated
FROM pg_constraint WHERE connamespace = 'public'::regnamespace
ORDER BY conrelid::regclass::text, conname;
