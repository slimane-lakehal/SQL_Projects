-- Write your own SQL object definition here, and it'll be included in your package.
-- Final project setup for game score tracking database

-- Drop the database if it exists
USE Master;
GO
ALTER DATABASE GameScoresDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE GameScoresDB;
GO

-- Create the database
CREATE DATABASE GameScoresDB;
GO
USE GameScoresDB;
GO

-- Create the schema
CREATE SCHEMA Game;
GO

-- Create the Players table
CREATE TABLE Game.Players
(
    PlayerID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    PlayerName VARCHAR(50),
    Score INT CONSTRAINT DF_PlayerScore_Start DEFAULT 0,
    BonusMultiplier INT CONSTRAINT DF_PlayerBonus_Start DEFAULT 1
);

-- Create the ScoreEvents table
CREATE TABLE Game.ScoreEvents
(
    ScoreID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Date DATETIME2 NOT NULL CONSTRAINT DF_ScoreEvent_GetDate DEFAULT GETDATE(),
    PlayerID INT NOT NULL,
    Score INT NOT NULL
);

-- Insert sample data into Players table
INSERT INTO Game.Players
    (PlayerName)
VALUES
    ('Player_Alfa'),
    ('Player_Bravo')
;

SELECT *
FROM Game.Players;
SELECT *
FROM Game.ScoreEvents;
GO