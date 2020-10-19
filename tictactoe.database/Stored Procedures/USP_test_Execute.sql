CREATE proc [dbo].[USP_test_Execute]
AS
BEGIN

	

		
	DECLARE @LoopCount INT = 9
	DECLARE @LoggedinUserOne VARCHAR(100) = 'ABCD'
	DECLARE @LoggedinUserTwo VARCHAR(100) = 'ABCD'
	DECLARE @PositionX INT,@PositionY INT

	SELECT TOP (1) @LoggedinUserOne = Player.UserName from Player order by PlayerID
	SELECT TOP (1) @LoggedinUserTwo = Player.UserName from Player order by PlayerID DESC

	WHILE @LoopCount >0
	BEGIN
		
		SELECT	TOP (1) 
				@PositionX = [PositionX],
				@PositionY = [PositionY]
		FROM	[Square]
		WHERE	[Square].PlayerGameID IS NULL 
		ORDER BY NEWID()
		
		IF @LoopCount%2 = 0
		BEGIN
				EXEC USP_ExecuteChance
				@LoggedinUser = @LoggedinUserOne,
				@PositionX = @PositionX,
				@PositionY = @PositionY
		END
		ELSE 
		BEGIN
				EXEC USP_ExecuteChance
				@LoggedinUser = @LoggedinUserTwo,
				@PositionX = @PositionX,
				@PositionY = @PositionY
		END
		SET @LoopCount = @LoopCount  - 1
	END

	EXEC USP_GetMatrix @LoggedinUser = @LoggedinUserOne
	EXEC USP_GetWinningStatus @LoggedinUser = @LoggedinUserOne
	
	

END
