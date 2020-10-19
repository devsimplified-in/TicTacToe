CREATE PROC [dbo].[USP_GetMatrix] 
(
	@LoggedinUser VARCHAR(50)
)
AS 
BEGIN

	DECLARE @GameID INT 
	SELECT @GameID = Player_Game.GameID
	FROM	Player_Game
			INNER JOIN Player
			ON Player.PlayerID = Player_Game.PlayerID
	WHERE Player.UserName = @LoggedinUser


SELECT
@GameID AS GameID,

(
		SELECT	Player_Game.Symbol 
		FROM	Square 
				LEFT JOIN Player_Game
				ON Square.PlayerGameID = Player_Game.PlayerGameID
		WHERE	PositionX =1 and PositionY =1
				AND Square.GameID =   @GameID
 ) AS '[1]',
(
		SELECT	Player_Game.Symbol 
		FROM	Square 
				LEFT JOIN Player_Game
				ON Square.PlayerGameID = Player_Game.PlayerGameID
		WHERE	PositionX =1 and PositionY =2
		AND Square.GameID =   @GameID
 ) AS '[2]',
 (
		SELECT	Player_Game.Symbol 
		FROM	Square 
				LEFT JOIN Player_Game
				ON Square.PlayerGameID = Player_Game.PlayerGameID
		WHERE	PositionX =1 and PositionY =3
		AND Square.GameID =   @GameID

 ) AS '[3]'
 UNION ALL 
 SELECT
 @GameID AS GameID,
(
		SELECT	Player_Game.Symbol 
		FROM	Square 
				LEFT JOIN Player_Game
				ON Square.PlayerGameID = Player_Game.PlayerGameID
		WHERE	PositionX =2 and PositionY =1
		AND Square.GameID =   @GameID

 ) AS '[1]',
(
		SELECT	Player_Game.Symbol 
		FROM	Square 
				LEFT JOIN Player_Game
				ON Square.PlayerGameID = Player_Game.PlayerGameID
		WHERE	PositionX =2 and PositionY =2
		AND Square.GameID =   @GameID

 ) AS '[2]',
 (
		SELECT	Player_Game.Symbol 
		FROM	Square 
				LEFT JOIN Player_Game
				ON Square.PlayerGameID = Player_Game.PlayerGameID
		WHERE	PositionX =2 and PositionY =3
		AND Square.GameID =   @GameID

 ) AS '[3]'
 UNION ALL 
 SELECT @GameID AS GameID,
(
		SELECT	Player_Game.Symbol 
		FROM	Square 
				LEFT JOIN Player_Game
				ON Square.PlayerGameID = Player_Game.PlayerGameID
		WHERE	PositionX =3 and PositionY =1
		AND Square.GameID =   @GameID

 ) AS '[1]',
(
		SELECT	Player_Game.Symbol 
		FROM	Square 
				LEFT JOIN Player_Game
				ON Square.PlayerGameID = Player_Game.PlayerGameID
		WHERE	PositionX =3 and PositionY =2
		AND Square.GameID =   @GameID

 ) AS '[2]',
 (
		SELECT	Player_Game.Symbol 
		FROM	Square 
				LEFT JOIN Player_Game
				ON Square.PlayerGameID = Player_Game.PlayerGameID
		WHERE	PositionX =3 and PositionY =3
		AND Square.GameID =   @GameID

 ) AS '[3]'


END
