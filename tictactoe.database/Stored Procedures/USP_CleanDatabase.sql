CREATE PROC [dbo].[USP_CleanDatabase]
AS
BEGIN
	DELETE Square
	DELETE PlayerQueue
	DELETE Player_Game
	DELETE Player
	DELETE Game
END
