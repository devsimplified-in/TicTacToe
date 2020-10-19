CREATE PROC [dbo].[USP_StartGame]
	
AS
BEGIN
		
		DECLARE @LoggedinUser VARCHAR(100) = 'BACCKGROUND_JOB'
	
	
		DECLARE @PlayerOneID INT, @PlayerTwoID INT
		DECLARE @DateNow DATETIME = GETDATE()
		DECLARE @GameGUID UNIQUEIDENTIFIER = NEWID()	
		DECLARE @GameID INT = NULL
		DECLARE @GameName VARCHAR(50)
		SELECT @GameName = 'G80-' + UPPER(SUBSTRING(CAST(NEWID() AS VARCHAR(50)),0,8))

/*************************************************************************/
	
	DECLARE @tblQueuePlayer AS TABLE
	(
		PlayerID INT,
		PlayerQueueID INT
	)

	IF(
		SELECT COUNT(*) 
		FROM	PlayerQueue
	) >=2 
	BEGIN
		
		INSERT INTO @tblQueuePlayer
		SELECT TOP (2)
				PlayerID,
				PlayerQueueID
		FROM	PlayerQueue

	END

	IF	EXISTS(
		SELECT	1 
		FROM	@tblQueuePlayer
	)
	BEGIN

	INSERT INTO Game
	(
		Name,
		Status,
		CreatedDate,
		ModifiedDate,
		CreatedBy,
		ModifiedBy,
		RowGUID
	) 
	SELECT	@GameName AS GameName, 
			'ACTIVE' AS Status,
			@DateNow AS CreatedDate,	
			@DateNow AS ModifiedDate,	
			@LoggedinUser AS CreatedBy,	
			@LoggedinUser AS ModifiedBy,	
			@GameGUID AS RowGUID
	
	SET @GameID = SCOPE_IDENTITY()

/*************************************************************************/

	
	INSERT INTO Player_Game
	(
		GameID,
		PlayerID,
		CreatedDate,
		ModifiedDate,
		CreatedBy,
		ModifiedBy,
		RowGUID,
		Symbol
	)
	
	SELECT 
			@GameID AS GameID,
			PlayerID,
			@DateNow AS CreatedDate,
			@DateNow AS ModifiedDate,
			@LoggedinUser AS CreatedBy,
			@LoggedinUser AS ModifiedBy,
			NEWID() as RowGUID,
			CASE WHEN PlayerQueueID%2 = 0 then 'O' ELSE 'X' END AS Symbol
	FROM	@tblQueuePlayer tblQueuePlayer
	
	DELETE 
	FROM	PlayerQueue 
	where	PlayerQueue.PlayerQueueID IN
			(
				SELECT PlayerQueueID 
				FROM	@tblQueuePlayer
			)
	
/*************************************************************************/

	INSERT INTO Square(
		GameID,
		PositionX,
		PositionY,
		PlayerGameID,
		CreatedDate,
		ModifiedDate,
		CreatedBy,
		ModifiedBy,
		RowGUID
	)
	SELECT @GameID AS GameID, 1 AS PositionX, 1 AS PositionY, NULL AS PlayerGameID,@DateNow AS CreatedDate,@DateNow AS ModifiedDate,@LoggedinUser AS CreatedBy,@LoggedinUser AS ModifiedBy,NEWID() AS RowGUID UNION ALL 
	SELECT @GameID AS GameID, 1 AS PositionX, 2 AS PositionY, NULL AS PlayerGameID,@DateNow AS CreatedDate,@DateNow AS ModifiedDate,@LoggedinUser AS CreatedBy,@LoggedinUser AS ModifiedBy,NEWID() AS RowGUID UNION ALL 
	SELECT @GameID AS GameID, 1 AS PositionX, 3 AS PositionY, NULL AS PlayerGameID,@DateNow AS CreatedDate,@DateNow AS ModifiedDate,@LoggedinUser AS CreatedBy,@LoggedinUser AS ModifiedBy,NEWID() AS RowGUID UNION ALL 
			
	SELECT @GameID AS GameID, 2 AS PositionX, 1 AS PositionY, NULL AS PlayerGameID,@DateNow AS CreatedDate,@DateNow AS ModifiedDate,@LoggedinUser AS CreatedBy,@LoggedinUser AS ModifiedBy,NEWID() AS RowGUID UNION ALL 
	SELECT @GameID AS GameID, 2 AS PositionX, 2 AS PositionY, NULL AS PlayerGameID,@DateNow AS CreatedDate,@DateNow AS ModifiedDate,@LoggedinUser AS CreatedBy,@LoggedinUser AS ModifiedBy,NEWID() AS RowGUID UNION ALL 
	SELECT @GameID AS GameID, 2 AS PositionX, 3 AS PositionY, NULL AS PlayerGameID,@DateNow AS CreatedDate,@DateNow AS ModifiedDate,@LoggedinUser AS CreatedBy,@LoggedinUser AS ModifiedBy,NEWID() AS RowGUID UNION ALL 
			
	SELECT @GameID AS GameID, 3 AS PositionX, 1 AS PositionY, NULL AS PlayerGameID,@DateNow AS CreatedDate,@DateNow AS ModifiedDate,@LoggedinUser AS CreatedBy,@LoggedinUser AS ModifiedBy,NEWID() AS RowGUID UNION ALL 
	SELECT @GameID AS GameID, 3 AS PositionX, 2 AS PositionY, NULL AS PlayerGameID,@DateNow AS CreatedDate,@DateNow AS ModifiedDate,@LoggedinUser AS CreatedBy,@LoggedinUser AS ModifiedBy,NEWID() AS RowGUID UNION ALL 
	SELECT @GameID AS GameID, 3 AS PositionX, 3 AS PositionY, NULL AS PlayerGameID,@DateNow AS CreatedDate,@DateNow AS ModifiedDate,@LoggedinUser AS CreatedBy,@LoggedinUser AS ModifiedBy,NEWID() AS RowGUID  

END
/*************************************************************************/


END
