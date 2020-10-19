CREATE TABLE [dbo].[Game] (
    [GameID]       INT              IDENTITY (1, 1) NOT NULL,
    [Name]         VARCHAR (100)    NOT NULL,
    [Status]       VARCHAR (50)     NOT NULL,
    [CreatedDate]  DATETIME         NOT NULL,
    [ModifiedDate] DATETIME         NOT NULL,
    [CreatedBy]    VARCHAR (50)     NOT NULL,
    [ModifiedBy]   VARCHAR (50)     NOT NULL,
    [RowGUID]      UNIQUEIDENTIFIER NOT NULL,
    [RowVersion]   ROWVERSION       NOT NULL,
    CONSTRAINT [PK_ttt_Game] PRIMARY KEY CLUSTERED ([GameID] ASC)
);

