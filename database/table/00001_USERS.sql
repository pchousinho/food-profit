-------------------------------------------------------------------------------
-- CREATE DATE - December 2025
-- DESCRIPTION - Create table USERS
-------------------------------------------------------------------------------
CREATE TABLE USERS
(
   ID                NUMBER                          NOT NULL
  ,EMAIL             VARCHAR2(250)                   NOT NULL
  ,NAME              VARCHAR2(250)                   NOT NULL
  ,ACCESS_LEVEL      VARCHAR2(4)      DEFAULT 'VIEW' NOT NULL
  ,LOGIN_FAILURES    NUMBER           DEFAULT 0      NOT NULL
  ,STATUS            VARCHAR2(1)      DEFAULT 'A'    NOT NULL
  ,GOOGLE_SUB        VARCHAR2(100)
  ,LAST_LOGIN        DATE
  ,EXPIRATION_DATE   DATE
  --
  ,CREATED_BY        VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
  ,CREATED_AT        TIMESTAMP      DEFAULT SYSTIMESTAMP                            NOT NULL
  ,UPDATED_BY        VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
  ,UPDATED_AT        TIMESTAMP      DEFAULT SYSTIMESTAMP                            NOT NULL
);
--
ALTER TABLE USERS ADD CONSTRAINT PK_USERS PRIMARY KEY (ID);
--
ALTER TABLE USERS ADD CONSTRAINT UK01_USERS_EMAIL UNIQUE (EMAIL);
ALTER TABLE USERS ADD CONSTRAINT UK02_USERS_GOOGLE_SUB UNIQUE (GOOGLE_SUB);
--
ALTER TABLE USERS ADD CONSTRAINT CHK01_USERS_STATUS CHECK (STATUS IN ('A','I'));
ALTER TABLE USERS ADD CONSTRAINT CHK02_USERS_LOGIN_FAILURES CHECK (LOGIN_FAILURES >= 0);
ALTER TABLE USERS ADD CONSTRAINT CHK03_USERS_ACCESS_LEVEL CHECK (ACCESS_LEVEL IN ('ADM','EDIT','VIEW'));
--
--
COMMENT ON TABLE USERS                  IS 'This table contains the list of USERS';
--
COMMENT ON COLUMN USERS.ID              IS 'This field contains the primary key of the table';
COMMENT ON COLUMN USERS.EMAIL           IS 'This field contains the e-mail address used for authentication';
COMMENT ON COLUMN USERS.NAME            IS 'This field contains the full name of the user';
COMMENT ON COLUMN USERS.ACCESS_LEVEL    IS 'This field contains the user access level for this client (ADM, EDIT, VIEW)';
COMMENT ON COLUMN USERS.LOGIN_FAILURES  IS 'This field contains the number of consecutive failed login attempts';
COMMENT ON COLUMN USERS.STATUS          IS 'This field contains the current status (A - Active, I - Inactive)';
COMMENT ON COLUMN USERS.GOOGLE_SUB      IS 'This field contains the Google OpenID Connect subject identifier (immutable user ID)';
COMMENT ON COLUMN USERS.LAST_LOGIN      IS 'This field contains the timestamp of the last successful login';
COMMENT ON COLUMN USERS.EXPIRATION_DATE IS 'This field contains the date when the user access expires';
COMMENT ON COLUMN USERS.CREATED_BY      IS 'This field contains the user who created the record';
COMMENT ON COLUMN USERS.CREATED_AT      IS 'This field contains the date and time when the record was created';
COMMENT ON COLUMN USERS.UPDATED_BY      IS 'This field contains the user who performed the last update to the record';
COMMENT ON COLUMN USERS.UPDATED_AT      IS 'This field contains the date and time when the record was last updated';