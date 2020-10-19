CREATE PROC [dbo].[USP_GetWinningStatus]
@LoggedinUser VARCHAR(50)
AS 
BEGIN

	DECLARE @GameID INT 
	SELECT @GameID = Player_Game.GameID
	FROM	Player_Game
			INNER JOIN Player
			ON Player.PlayerID = Player_Game.PlayerID
	WHERE Player.UserName = @LoggedinUser

	DECLARE @PositionX INT
	DECLARE @PositionY INT

	DECLARE @tempGameMatrix AS TABLE(
	RowNum INT,
	[1] CHAR(1),
	[2] CHAR(1),
	[3] CHAR(1)
	)
	INSERT INTO @tempGameMatrix
	EXEC USP_GetMatrix 
	@LoggedinUser = @LoggedinUser
	
	IF 
	EXISTS(
				SELECT		1
				FROM		@tempGameMatrix tempGameMatrix
				WHERE		tempGameMatrix.[1] IS NOT NULL
							AND 
							tempGameMatrix.[1]  = tempGameMatrix.[2]
							AND 
							tempGameMatrix.[2]  = tempGameMatrix.[3]
	) OR 
	EXISTS(
				SELECT		1 ValueExists
				FROM		@tempGameMatrix tempGameMatrix1
				WHERE		tempGameMatrix1.[1] IS NOT NULL
				Group by	tempGameMatrix1.[1]
				HAVING		COUNT(tempGameMatrix1.RowNum) = 3
				UNION ALL
				SELECT		1 ValueExists
				FROM		@tempGameMatrix tempGameMatrix2
				WHERE		tempGameMatrix2.[2] IS NOT NULL
				Group by	tempGameMatrix2.[2]
				HAVING		COUNT(tempGameMatrix2.RowNum) = 3
				UNION ALL
				SELECT		1 ValueExists
				FROM		@tempGameMatrix tempGameMatrix3
				WHERE		tempGameMatrix3.[2] IS NOT NULL
				Group by	tempGameMatrix3.[3]
				HAVING		COUNT(tempGameMatrix3.RowNum) = 3
	)
	OR
	EXISTS(
				SELECT 1 
				FROM (
						SELECT		RowNum, tempGameMatrix1.[1] AS CrossVal
						FROM		@tempGameMatrix tempGameMatrix1
						WHERE		tempGameMatrix1.RowNum = 1
									AND 
									tempGameMatrix1.[1] IS NOT NULL 
						UNION ALL 
						SELECT		RowNum, tempGameMatrix2.[2] AS CrossVal
						FROM		@tempGameMatrix tempGameMatrix2
						WHERE		tempGameMatrix2.RowNum = 2
									AND 
									tempGameMatrix2.[2] IS NOT NULL 

						UNION ALL 
						SELECT		RowNum, tempGameMatrix3.[3] AS CrossVal
						FROM		@tempGameMatrix tempGameMatrix3
						WHERE		tempGameMatrix3.RowNum = 3
									AND 
									tempGameMatrix3.[3] IS NOT NULL 
				)OBJ
				GROUP BY CrossVal
				HAVING COUNT(CrossVal) = 3
	) 
	OR
	EXISTS(
				SELECT 1 
				FROM (
						SELECT		RowNum, tempGameMatrix1.[3] AS CrossVal
						FROM		@tempGameMatrix tempGameMatrix1
						WHERE		tempGameMatrix1.RowNum = 1
									AND 
									tempGameMatrix1.[3] IS NOT NULL 
						UNION ALL 
						SELECT		RowNum, tempGameMatrix2.[2] AS CrossVal
						FROM		@tempGameMatrix tempGameMatrix2
						WHERE		tempGameMatrix2.RowNum = 2
									AND 
									tempGameMatrix2.[2] IS NOT NULL 

						UNION ALL 
						SELECT		RowNum, tempGameMatrix3.[1] AS CrossVal
						FROM		@tempGameMatrix tempGameMatrix3
						WHERE		tempGameMatrix3.RowNum = 3
									AND 
									tempGameMatrix3.[1] IS NOT NULL 
				)OBJ
				GROUP BY CrossVal
				HAVING COUNT(CrossVal) = 3
	)
	BEGIN
	
		SELECT * FROM @tempGameMatrix
	
	END


END
