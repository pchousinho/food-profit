-------------------------------------------------------------------------------
-- CREATE DATE - August 2026
-- DESCRIPTION - Create table SYSTEM_MESSAGES
-------------------------------------------------------------------------------
CREATE TABLE SYSTEM_MESSAGES
(
   MESSAGE_TYPE   VARCHAR2(2)   NOT NULL
  ,MESSAGE_KEY    VARCHAR2(25)  NOT NULL
  ,MESSAGE_TEXT   VARCHAR2(255) NOT NULL
  --
  ,CREATED_BY     VARCHAR2(250) DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
  ,CREATED_AT     TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL
  ,UPDATED_BY     VARCHAR2(250) DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
  ,UPDATED_AT     TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL
);
--
ALTER TABLE SYSTEM_MESSAGES ADD CONSTRAINT PK_SYSTEM_MESSAGES PRIMARY KEY (MESSAGE_KEY, MESSAGE_TYPE);
--
COMMENT ON TABLE SYSTEM_MESSAGES               IS 'This table contains the list of system messages';
--
COMMENT ON COLUMN SYSTEM_MESSAGES.MESSAGE_TYPE IS 'This field contains the type of the message';
COMMENT ON COLUMN SYSTEM_MESSAGES.MESSAGE_KEY  IS 'This field contains the unique key used to identify the message';
COMMENT ON COLUMN SYSTEM_MESSAGES.MESSAGE_TEXT IS 'This field contains the text of the message';
COMMENT ON COLUMN SYSTEM_MESSAGES.CREATED_BY   IS 'This field contains the user who created the record';
COMMENT ON COLUMN SYSTEM_MESSAGES.CREATED_AT   IS 'This field contains the date and time when the record was created';
COMMENT ON COLUMN SYSTEM_MESSAGES.UPDATED_BY   IS 'This field contains the user who performed the last update to the record';
COMMENT ON COLUMN SYSTEM_MESSAGES.UPDATED_AT   IS 'This field contains the date and time when the record was last updated';