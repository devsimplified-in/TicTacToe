CREATE TABLE [dbo].[Square] (
    [SquareID]     INT              IDENTITY (1, 1) NOT NULL,
    [PositionX]    INT              NOT NULL,
    [PositionY]    INT              NOT NULL,
    [GameID]       INT              NOT NULL,
    [PlayerGameID] INT              NULL,
    [RowVersion]   ROWVERSION       NOT NULL,
    [CreatedDate]  DATETIME         NOT NULL,
    [ModifiedDate] DATETIME         NOT NULL,
    [CreatedBy]    VARCHAR (50)     NOT NULL,
    [ModifiedBy]   VARCHAR (50)     NOT NULL,
    [RowGUID]      UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_Square] PRIMARY KEY CLUSTERED ([SquareID] ASC),
    CONSTRAINT [FK_Square_Player_Game] FOREIGN KEY ([PlayerGameID]) REFERENCES [dbo].[Player_Game] ([PlayerGameID])
);

