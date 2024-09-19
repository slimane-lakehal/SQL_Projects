-- Goal: Keep a permanent record of the global score as it changes throughout the life of the game.
-- Tasks:
-- 1) Create an Append-Only Ledger Table to store the global score log.
-- 2) Write a Stored Procedure to log the current global score.
-- 3) Create a trigger that will record the current global score any time an update occurs on the Players table.

USE GameScoresDB;
GO

-- Create ledger table
CREATE TABLE Game.ScoreLedger
(
    LogID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Date DATETIME2 NOT NULL CONSTRAINT DF_Ledger_Date DEFAULT GETDATE(),
    GlobalScore INT
)
WITH 
(
 LEDGER = ON (APPEND_ONLY = ON)
);

GO

-- Create the stored procedure to populate ledger table
CREATE OR ALTER PROCEDURE Game.RecordGlobalScore
AS
BEGIN
    DECLARE @Score INT;
    -- Calculate total score using custom function
    SELECT @Score = Game.CalculateGlobalScore();
    -- Insert score into ScoreLedger table
    INSERT INTO Game.ScoreLedger
        (GlobalScore)
    VALUES
        (@Score);
END;
GO

-- Execute and test the procedure
EXEC Game.RecordGlobalScore;

SELECT *
FROM Game.ScoreLedger;
GO

-- Create trigger to record the global score whenever Players table is updated
CREATE OR ALTER TRIGGER Game.LogGlobalScore
    ON Game.Players
    AFTER INSERT, UPDATE, DELETE
    AS
        SET NOCOUNT ON;
        EXEC Game.RecordGlobalScore;
        PRINT 'Current global score has been recorded.'
;
GO

-- Test the trigger
INSERT INTO Game.ScoreEvents
    (PlayerID, Score)
VALUES
    (2, 25);

SELECT *
FROM Game.ScoreEvents;
SELECT *
FROM Game.Players;
SELECT *
FROM Game.ScoreLedger;
