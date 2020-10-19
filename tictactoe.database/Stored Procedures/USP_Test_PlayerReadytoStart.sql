CREATE PROCEDURE [dbo].[USP_Test_PlayerReadytoStart]
AS
BEGIN

	DECLARE @UserName VARCHAR(100)
	
	DECLARE @tblUSP_RegisterPlayer AS TABLE(
		UserName VARCHAR(50)
	)
	INSERT INTO @tblUSP_RegisterPlayer
	SELECT Player.UserName
	FROM	Player
	
	
	
	WHILE EXISTS(
				SELECT	1 
				FROM	@tblUSP_RegisterPlayer
	)
	BEGIN
			
			SELECT TOP (1)
					@UserName= UserName
			FROM	@tblUSP_RegisterPlayer

			EXEC USP_PlayerReadytoStart
				 @LoggedinUser = @UserName
	
			DELETE 
			FROM	@tblUSP_RegisterPlayer
			WHERE	UserName= @UserName
	END


END
