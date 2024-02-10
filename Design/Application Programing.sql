--
-- File generated with SQLiteStudio v3.4.4 on Fri Feb 9 19:51:37 2024
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: Bench Press Table
DROP TABLE IF EXISTS [Bench Press Table];

CREATE TABLE IF NOT EXISTS [Bench Press Table] (
    benchId       INTEGER PRIMARY KEY AUTOINCREMENT,
    currentWeight INTEGER,
    goalWeight    INTEGER,
    goalReps      INTEGER
)
STRICT;


-- Table: Deadlift Table
DROP TABLE IF EXISTS [Deadlift Table];

CREATE TABLE IF NOT EXISTS [Deadlift Table] (
    deadliftId    INTEGER PRIMARY KEY,
    currentWeight INTEGER,
    goalWeight    INTEGER,
    goalReps      INTEGER
)
STRICT;


-- Table: ListofLifts
DROP TABLE IF EXISTS ListofLifts;

CREATE TABLE IF NOT EXISTS ListofLifts (
    listOfLifts       INTEGER PRIMARY KEY,
    benchIdPointer    INTEGER REFERENCES [Bench Press Table] (benchId) 
                              NOT NULL,
    deadliftIdPointer INTEGER REFERENCES [Deadlift Table] (deadliftId) 
                              NOT NULL,
    squatIdPointer    INTEGER REFERENCES [Squat Table] (squatId) 
                              NOT NULL
)
STRICT;


-- Table: Squat Table
DROP TABLE IF EXISTS [Squat Table];

CREATE TABLE IF NOT EXISTS [Squat Table] (
    squatId       INTEGER PRIMARY KEY,
    currentWeight INTEGER,
    goalWeight    INTEGER,
    goalReps      INTEGER
)
STRICT;


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
