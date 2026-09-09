-------------------------------------------------------------------------------
-- CREATE DATE - June 2026
-- DESCRIPTION - Create table MESSAGE_TEXT
-------------------------------------------------------------------------------
CREATE TABLE MESSAGE_TEXT
(
   MESSAGE_KEY       VARCHAR2(250)                                                  NOT NULL
  ,MESSAGE_TYPE      VARCHAR2(250)                                                  NOT NULL
  ,MESSAGE_TEXT      VARCHAR2(4000)
  --
  ,CREATED_BY 		   VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
  ,CREATED_AT 		   TIMESTAMP      DEFAULT SYSTIMESTAMP                            NOT NULL
  ,UPDATED_BY 		   VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
  ,UPDATED_AT 		   TIMESTAMP      DEFAULT SYSTIMESTAMP                            NOT NULL
);
--
ALTER TABLE MESSAGE_TEXT ADD CONSTRAINT PK_MESSAGE_TEXT PRIMARY KEY (MESSAGE_KEY);
--
COMMENT ON TABLE MESSAGE_TEXT 				 	IS 'This table contains the list of message texts';
--
COMMENT ON COLUMN MESSAGE_TEXT.MESSAGE_KEY   IS 'This field contains the message key';
COMMENT ON COLUMN MESSAGE_TEXT.MESSAGE_TYPE  IS 'This field contains the message type';
COMMENT ON COLUMN MESSAGE_TEXT.MESSAGE_TEXT  IS 'This field contains the message text';
COMMENT ON COLUMN MESSAGE_TEXT.CREATED_BY    IS 'This field contains the user who created the record';
COMMENT ON COLUMN MESSAGE_TEXT.UPDATED_BY    IS 'This field contains the user who performed the last update to the record';
COMMENT ON COLUMN MESSAGE_TEXT.CREATED_AT    IS 'This field contains the date and time when the record was created';
COMMENT ON COLUMN MESSAGE_TEXT.UPDATED_AT    IS 'This field contains the date and time when the record was last updated';
