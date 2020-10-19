CREATE PROC [dbo].[USP_PlayerReadytoStart]
(
	@LoggedinUser VARCHAR(100)= NULL
	
)
AS
BEGIN

	DECLARE @PlayerID INT
	SELECT @PlayerID =  PlayerID FROM Player where Player.UserName = @LoggedinUser
	DECLARE @DateNow DATETIME = GETDATE()

	INSERT INTO PlayerQueue
	(
		PlayerID,
		CreatedDate,
		ModifiedDate,
		CreatedBy,
		ModifiedBy,
		RowGUID
	)
	SELECT	@PlayerID AS PlayerID,
			@DateNow AS CreatedDate,
			@DateNow AS ModifiedDate,
			@LoggedinUser AS CreatedBy,
			@LoggedinUser AS ModifiedBy,
			NEWID() AS RowGUID

END
