-- Use a fresh performance.db. This is synthetic performance data, not real enrollments.
CREATE TABLE report_events(event_id INTEGER PRIMARY KEY,edition_code TEXT NOT NULL,note TEXT) STRICT;
WITH RECURSIVE numbers(x) AS (VALUES(1) UNION ALL SELECT x+1 FROM numbers WHERE x<20000)
INSERT INTO report_events SELECT x,printf('E%03d',x%200),'demo' FROM numbers;
