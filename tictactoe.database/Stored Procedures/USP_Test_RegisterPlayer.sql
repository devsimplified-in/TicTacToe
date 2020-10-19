CREATE PROCEDURE [dbo].[USP_Test_RegisterPlayer]
AS
BEGIN
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

END
