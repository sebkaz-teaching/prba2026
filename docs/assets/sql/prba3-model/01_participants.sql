CREATE TABLE participants (
    participant_id TEXT NOT NULL PRIMARY KEY,
    name TEXT NOT NULL
);
INSERT INTO participants VALUES
    ('U1', 'Ada'), ('U2', 'Bartek'), ('U3', 'Celina');
SELECT * FROM participants ORDER BY participant_id;
