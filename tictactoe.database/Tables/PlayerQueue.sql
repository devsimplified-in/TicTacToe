CREATE TABLE [dbo].[PlayerQueue] (
    [PlayerQueueID] INT              IDENTITY (1, 1) NOT NULL,
    [PlayerID]      INT              NOT NULL,
    [RowVersion]    ROWVERSION       NOT NULL,
    [CreatedDate]   DATETIME         NOT NULL,
    [ModifiedDate]  DATETIME         NOT NULL,
    [CreatedBy]     VARCHAR (50)     NOT NULL,
    [ModifiedBy]    VARCHAR (50)     NOT NULL,
    [RowGUID]       UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_PlayerQueue] PRIMARY KEY CLUSTERED ([PlayerQueueID] ASC),
    CONSTRAINT [FK_PlayerQueue_Player] FOREIGN KEY ([PlayerID]) REFERENCES [dbo].[Player] ([PlayerID])
);

