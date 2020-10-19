CREATE PROC [dbo].[USP_ExecuteChance] 
(	
	@LoggedinUser VARCHAR(100),
	
	@PositionX INT,
	@PositionY INT
)
AS
BEGIN

	DECLARE @GameID INT,@PlayerID INT
	
	SELECT @GameID = Player_Game.GameID,
	       @PlayerID  =Player_Game.PlayerID
	FROM	Player_Game
			INNER JOIN Player
			ON Player.PlayerID = Player_Game.PlayerID
	WHERE Player.UserName = @LoggedinUser


	DECLARE @RowGUID UNIQUEIDENTIFIER = NEWID()	
	DECLARE @DateNow DATETIME = GETDATE()

/*************************************************************************/
	DECLARE @CurrentPlayerGameID INT = NULL
	
	SELECT	@CurrentPlayerGameID = PlayerGameID 
	FROM	Player_Game 
	WHERE	Player_Game.PlayerID = @PlayerID
			AND Player_Game.GameID = @GameID

	
	--SELECT @CurrentPlayerGameID
		
/*************************************************************************/


UPDATE	Square
SET		PlayerGameID = @CurrentPlayerGameID,
		ModifiedDate = @DateNow,
		ModifiedBy = @LoggedinUser,
		RowGUID = @RowGUID
WHERE	PositionX = @PositionX
		AND 
		PositionY = @PositionY
		AND GameID = @GameID

/*************************************************************************/




/*************************************************************************/
-- EXEC USP_GetMatrix

/*************************************************************************/

END
