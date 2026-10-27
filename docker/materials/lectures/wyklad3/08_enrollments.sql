CREATE TABLE enrollments (
    participant_id TEXT NOT NULL
        REFERENCES participants(participant_id),
    edition_id TEXT NOT NULL REFERENCES editions(edition_id),
    status TEXT NOT NULL
        CHECK (status IN ('confirmed', 'cancelled')),
    PRIMARY KEY (participant_id, edition_id)
);
INSERT INTO enrollments VALUES
    ('U1', 'E1', 'confirmed'),
    ('U2', 'E1', 'confirmed'),
    ('U3', 'E2', 'confirmed'),
    ('U2', 'E2', 'cancelled');
