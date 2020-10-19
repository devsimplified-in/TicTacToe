CREATE TABLE [dbo].[Log] (
    [LogID]        INT              IDENTITY (1, 1) NOT NULL,
    [GameID]       INT              NOT NULL,
    [LogMessage]   VARCHAR (1000)   NULL,
    [CreatedDate]  DATETIME         NOT NULL,
    [ModifiedDate] DATETIME         NOT NULL,
    [CreatedBy]    VARCHAR (50)     NOT NULL,
    [ModifiedBy]   VARCHAR (50)     NOT NULL,
    [RowGUID]      UNIQUEIDENTIFIER NOT NULL,
    [RowVersion]   ROWVERSION       NOT NULL,
    CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED ([LogID] ASC),
    CONSTRAINT [FK_Log_Game] FOREIGN KEY ([GameID]) REFERENCES [dbo].[Game] ([GameID])
);

