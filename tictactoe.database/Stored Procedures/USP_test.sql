CREATE proc [dbo].[USP_test]
AS
BEGIN
		EXEC USP_CleanDatabase

		DECLARE @LoopCount INT = 2
		DECLARE @FirstName VARCHAR(50) = NULL 
		DECLARE @LastName VARCHAR(50) = NULL
		DECLARE @UserName VARCHAR(50) = NULL
		DECLARE @Password VARBINARY(MAX) = NULL

		

	WHILE @LoopCount > 0
	BEGIN

		SET @FirstName = SUBSTRING(CAST(NEWID() AS VARCHAR(50)),0,8)
		SET @LastName = SUBSTRING(CAST(NEWID() AS VARCHAR(50)),0,8)
		SET @UserName = SUBSTRING(CAST(NEWID() AS VARCHAR(50)),0,8)
		SET @Password = CAST(SUBSTRING(CAST(NEWID() AS VARCHAR(50)),0,8) AS VARBINARY(MAX))

		
		EXEC USP_RegisterPlayer
		@FirstName = @FirstName ,
		@LastName = @LastName,
		@UserName = @UserName,
		@Password = @Password

		SET @LoopCount  = @LoopCount -1

	END
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
	
	EXEC USP_GetGameStartStatus @LoggedinUser = @UserName

	EXEC USP_StartGame

	EXEC USP_GetGameStartStatus @LoggedinUser = @UserName

	
	
	EXEC USP_test_Execute
	 
	 


END
