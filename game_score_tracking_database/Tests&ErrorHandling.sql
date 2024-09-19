USE GameScoresDB;
GO

-- Test with known-good scenario
INSERT INTO Game.ScoreEvents
    (PlayerID, Score)
VALUES
    (2, 125);

SELECT *
FROM Game.ScoreEvents;
SELECT *
FROM Game.Players;
SELECT *
FROM Game.ScoreLedger;

-- Test with negative score
INSERT INTO Game.ScoreEvents
    (PlayerID, Score)
VALUES
    (1, -50);

-- Test with new bonus multiplier
UPDATE Game.Players
SET BonusMultiplier += 1
WHERE PlayerID = 1;

-- Test with invalid multiple inserts
INSERT INTO Game.ScoreEvents
    (PlayerID, Score)
VALUES
    (1, 50),
    (2, 10);

-- Fix for invalid multiple inserts
CREATE OR ALTER TRIGGER Game.AddScore
ON Game.ScoreEvents
AFTER INSERT
AS
SET NOCOUNT ON;
BEGIN TRY   -- NEW
    UPDATE Game.Players
        SET Score += (SELECT Score
FROM Inserted)
        FROM Inserted
        WHERE Inserted.PlayerID = Game.Players.PlayerID;
    PRINT 'Score event has been recorded.'
    PRINT 'Player total score has been updated.'
END TRY  -- NEW
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'No score events were recorded. ' +ERROR_MESSAGE();
END CATCH;
;
GO


-- Test with invalid PlayerID
INSERT INTO Game.ScoreEvents
    (PlayerID, Score)
VALUES
    (5, 99);

DELETE FROM Game.ScoreEvents WHERE PlayerID = 5;
GO

-- Fix for invalid PlayerID
CREATE OR ALTER TRIGGER Game.AddScore
ON Game.ScoreEvents
AFTER INSERT
AS
SET NOCOUNT ON;
BEGIN TRY
    IF (SELECT PlayerID
FROM Inserted) NOT IN (SELECT PlayerID
FROM Game.Players)
    BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'Invalid Player ID';
END
    ELSE
    BEGIN
    UPDATE Game.Players
            SET Score += (SELECT Score
    FROM Inserted)
            FROM Inserted
            WHERE Inserted.PlayerID = Game.Players.PlayerID;
    PRINT 'Score event has been recorded.'
    PRINT 'Player total score has been updated.'
END
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'No score events were recorded. ' +ERROR_MESSAGE();
END CATCH;
;
GO
