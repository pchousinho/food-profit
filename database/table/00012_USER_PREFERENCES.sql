-------------------------------------------------------------------------------
-- CREATE DATE - September 2026
-- DESCRIPTION - Create table USER_PREFERENCES
-------------------------------------------------------------------------------
CREATE TABLE USER_PREFERENCES
(
   USER_ID        NUMBER                                                        NOT NULL
  ,LANGUAGE_ID    NUMBER                                                        NOT NULL
  --
  ,CREATED_BY     VARCHAR2(250) DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
  ,CREATED_AT     TIMESTAMP     DEFAULT SYSTIMESTAMP                            NOT NULL
  ,UPDATED_BY     VARCHAR2(250) DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
  ,UPDATED_AT     TIMESTAMP     DEFAULT SYSTIMESTAMP                            NOT NULL
);
--
ALTER TABLE USER_PREFERENCES ADD CONSTRAINT PK_USER_PREFERENCES PRIMARY KEY (USER_ID);
ALTER TABLE USER_PREFERENCES ADD CONSTRAINT FK01_USER_PREFERENCES_USER FOREIGN KEY (USER_ID) REFERENCES USERS (ID) ENABLE;
ALTER TABLE USER_PREFERENCES ADD CONSTRAINT FK02_USER_PREFERENCES_LANGUAGE FOREIGN KEY (LANGUAGE_ID) REFERENCES LANGUAGES (ID) ENABLE;
--
COMMENT ON TABLE USER_PREFERENCES IS 'This table contains the user preferences, such as the selected language';
--
COMMENT ON COLUMN USER_PREFERENCES.USER_ID       IS 'This field contains the user ID';
COMMENT ON COLUMN USER_PREFERENCES.LANGUAGE_ID   IS 'This field contains the user selected language ID';
COMMENT ON COLUMN USER_PREFERENCES.CREATED_BY    IS 'This field contains the user who created the record';
COMMENT ON COLUMN USER_PREFERENCES.CREATED_AT    IS 'This field contains the date and time when the record was created';
COMMENT ON COLUMN USER_PREFERENCES.UPDATED_BY    IS 'This field contains the user who performed the last update to the record';
COMMENT ON COLUMN USER_PREFERENCES.UPDATED_AT    IS 'This field contains the date and time when the record was last updated';