CREATE TABLE [dbo].[Player] (
    [PlayerID]     INT              IDENTITY (1, 1) NOT NULL,
    [FirstName]    VARCHAR (100)    NOT NULL,
    [LastName]     VARCHAR (100)    NULL,
    [UserName]     VARCHAR (50)     NULL,
    [Password]     VARCHAR (50)     NULL,
    [RowVersion]   ROWVERSION       NOT NULL,
    [CreatedDate]  DATETIME         NOT NULL,
    [ModifiedDate] DATETIME         NOT NULL,
    [CreatedBy]    VARCHAR (50)     NOT NULL,
    [ModifiedBy]   VARCHAR (50)     NOT NULL,
    [RowGUID]      UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_Player] PRIMARY KEY CLUSTERED ([PlayerID] ASC)
);

