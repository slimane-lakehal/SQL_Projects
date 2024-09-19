-- Write a custom function to calculate global score total.
-- This consists of the sum total of all player's current score * bonus multiplier

USE GameScoresDB;
GO

-- Review current data
SELECT *
FROM Game.Players;
GO

CREATE OR ALTER FUNCTION Game.CalculateGlobalScore()
RETURNS INT
AS
BEGIN
    DECLARE @GlobalScore INT;
    SELECT @GlobalScore = SUM(Score * BonusMultiplier)
    FROM Game.Players;
    RETURN @GlobalScore;
END;
GO

-- Test the function
SELECT Game.CalculateGlobalScore() AS CurrentGlobalScore;
GO
