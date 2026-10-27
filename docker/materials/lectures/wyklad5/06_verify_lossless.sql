-- Run separately before steps 07-09. Both EXCEPT results must be empty.
SELECT * FROM flat_enrollments EXCEPT SELECT * FROM enrollment_report;
SELECT * FROM enrollment_report EXCEPT SELECT * FROM flat_enrollments;

-- All foreign keys should have convalidated = true.
SELECT conrelid::regclass AS table_name, conname, convalidated
FROM pg_constraint WHERE connamespace = 'public'::regnamespace AND contype = 'f'
ORDER BY conrelid::regclass::text, conname;
