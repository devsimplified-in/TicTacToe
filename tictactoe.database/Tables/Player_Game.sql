CREATE TABLE [dbo].[Player_Game] (
    [PlayerGameID] INT              IDENTITY (1, 1) NOT NULL,
    [GameID]       INT              NULL,
    [PlayerID]     INT              NOT NULL,
    [RowVersion]   ROWVERSION       NOT NULL,
    [CreatedDate]  DATETIME         NOT NULL,
    [ModifiedDate] DATETIME         NOT NULL,
    [CreatedBy]    VARCHAR (50)     NOT NULL,
    [ModifiedBy]   VARCHAR (50)     NOT NULL,
    [RowGUID]      UNIQUEIDENTIFIER NOT NULL,
    [Symbol]       CHAR (1)         NOT NULL,
    CONSTRAINT [PK_Player_Game] PRIMARY KEY CLUSTERED ([PlayerGameID] ASC),
    CONSTRAINT [FK_Player_Game_Game] FOREIGN KEY ([GameID]) REFERENCES [dbo].[Game] ([GameID]),
    CONSTRAINT [FK_Player_Game_Player] FOREIGN KEY ([PlayerID]) REFERENCES [dbo].[Player] ([PlayerID])
);

