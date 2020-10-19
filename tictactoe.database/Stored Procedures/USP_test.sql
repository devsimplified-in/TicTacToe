CREATE proc [dbo].[USP_test]
AS
BEGIN
		
	EXEC USP_CleanDatabase
	EXEC USP_Test_RegisterPlayer
	EXEC USP_Test_PlayerReadytoStart
	EXEC USP_Test_StartGame
	EXEC USP_test_Execute


END
