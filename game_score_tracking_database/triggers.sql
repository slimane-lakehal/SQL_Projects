-- Create a trigger to add new score events to existing player score
-- Every time a new score event is recorded, the Players table should be updated as well
USE GameScoresDB;
GO

CREATE OR ALTER TRIGGER Game.AddScore
ON Game.ScoreEvents
AFTER INSERT
AS
SET NOCOUNT ON;
UPDATE Game.Players
    SET Score += (SELECT Score
FROM Inserted)
    FROM Inserted
    WHERE Inserted.PlayerID = Game.Players.PlayerID;
PRINT 'Score event has been recorded.'
PRINT 'Player total score has been updated.'
;
GO

-- Test the trigger
INSERT INTO Game.ScoreEvents
    (PlayerID, Score)
VALUES
    (1, 150);
INSERT INTO Game.ScoreEvents
    (PlayerID, Score)
VALUES
    (1, 50);
INSERT INTO Game.ScoreEvents
    (PlayerID, Score)
VALUES
    (2, 100);

SELECT *
FROM Game.ScoreEvents;
SELECT *
FROM Game.Players;
GO