

CREATE PROC [dbo].[USP_RegisterPlayer]
(
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	@UserName VARCHAR(50),
	@Password VARBINARY(MAX)

)
AS
BEGIN
	DECLARE @DATENOW DATETIME = GETDATE()
	DECLARE @PlayerRowGUID UNIQUEIDENTIFIER = NEWID()
	DECLARE @PlayerID INT

	
	INSERT INTO Player
	(
		FirstName,
		LastName,
		UserName,
		Password,
		CreatedDate,
		ModifiedDate,
		CreatedBy,
		ModifiedBy,
		RowGUID
)
SELECT	@FirstName AS FirstName,
		@LastName AS LastName,
		@UserName AS UserName,
		@Password AS Password,
		@DATENOW AS CreatedDate,
		@DATENOW AS ModifiedDate,
		@UserName AS CreatedBy,
		@UserName AS ModifiedBy,
		@PlayerRowGUID AS RowGUID

END
