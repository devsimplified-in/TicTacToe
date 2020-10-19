CREATE  PROC [dbo].[USP_GetGameStartStatus]
@LoggedinUser VARCHAR(100)
AS 
BEGIN

	IF EXISTS(
				SELECT 1
				FROM	Player_Game
						INNER JOIN Player
						ON Player.PlayerID = Player_Game.PlayerID
				WHERE Player.UserName = @LoggedinUser
	)
	BEGIN
		SELECT 'GAME_STARTED'
	END
	ELSE
	BEGIN
		SELECT 'WAITING_FOR_PARTICIPANT'
	END

	

END
