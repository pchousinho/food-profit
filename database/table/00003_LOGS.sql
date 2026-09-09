-------------------------------------------------------------------------------
-- CREATE DATE - June 2026
-- DESCRIPTION - Create table LOGS
-------------------------------------------------------------------------------
CREATE TABLE LOGS
(
   ID 	            NUMBER 			                                                NOT NULL
  ,LOG_LEVEL 	      NUMBER(1)                                                      NOT NULL
  ,PROGRAM_NAME      VARCHAR2(250)                                                  NOT NULL
  ,CODE              VARCHAR2(250)                                                  NOT NULL
  --
  ,ERROR_MESSAGE     VARCHAR2(4000)                                                 NOT NULL
  ,ERROR_BACKTRACE   VARCHAR2(4000)
  ,ERROR_STACK       VARCHAR2(4000)
  ,LOG_USER          VARCHAR2(250)
  ,AUX_C_1           VARCHAR2(4000)
  ,AUX_C_2           VARCHAR2(4000)
  ,AUX_C_3           VARCHAR2(4000)
  ,AUX_N_1           NUMBER
  ,AUX_N_2           NUMBER
  ,AUX_N_3           NUMBER
  ,AUX_CLOB_1        CLOB
  ,AUX_CLOB_2        CLOB
  ,AUX_BLOB_1        BLOB
  ,AUX_BLOB_2        BLOB
  --
  ,SESS_SID          VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','SID')            NOT NULL
  ,SESS_ID           VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','SESSIONID')      NOT NULL
  ,SESS_USER         VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','SESSION_USER')   NOT NULL
  ,DB_INSTANCE       VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','INSTANCE')       NOT NULL
  ,DB_INSTANCE_NAME  VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','INSTANCE_NAME')  NOT NULL
  ,USER_HOST         VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','HOST')           NOT NULL
  ,USER_IP_ADDRESS   VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','IP_ADDRESS')     NOT NULL
  ,OS_USER           VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','OS_USER')        NOT NULL
  --
  ,CREATED_BY 		   VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
  ,CREATED_AT 		   TIMESTAMP      DEFAULT SYSTIMESTAMP                            NOT NULL
  ,UPDATED_BY 		   VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
  ,UPDATED_AT 		   TIMESTAMP      DEFAULT SYSTIMESTAMP                            NOT NULL
);
--
ALTER TABLE LOGS ADD CONSTRAINT PK_LOGS PRIMARY KEY (ID);
--
ALTER TABLE LOGS ADD CONSTRAINT CHK01_LOGS_LOG_LEVEL CHECK (LOG_LEVEL IN (0, 1, 2, 3));
--
COMMENT ON TABLE LOGS 				 	    IS 'This table contains the list of logs';
--
COMMENT ON COLUMN LOGS.ID               IS 'This field contains the primary key of the table';
COMMENT ON COLUMN LOGS.LOG_LEVEL        IS 'This field contains the log level: 0-ERROR, 1-INFO, 2-DEBUG, 3-TRACE';
COMMENT ON COLUMN LOGS.PROGRAM_NAME     IS 'This field contains the program name';
COMMENT ON COLUMN LOGS.CODE             IS 'This field contains the log code';
COMMENT ON COLUMN LOGS.AUX_C_1          IS 'This field contains the first auxiliary character field';
COMMENT ON COLUMN LOGS.AUX_C_2          IS 'This field contains the second auxiliary character field';
COMMENT ON COLUMN LOGS.AUX_C_3          IS 'This field contains the third auxiliary character field';
COMMENT ON COLUMN LOGS.AUX_N_1          IS 'This field contains the first auxiliary numeric field';
COMMENT ON COLUMN LOGS.AUX_N_2          IS 'This field contains the second auxiliary numeric field';
COMMENT ON COLUMN LOGS.AUX_N_3          IS 'This field contains the third auxiliary numeric field';
COMMENT ON COLUMN LOGS.AUX_CLOB_1       IS 'This field contains the first auxiliary CLOB field';
COMMENT ON COLUMN LOGS.AUX_CLOB_2       IS 'This field contains the second auxiliary CLOB field';
COMMENT ON COLUMN LOGS.AUX_BLOB_1       IS 'This field contains the first auxiliary BLOB field';
COMMENT ON COLUMN LOGS.AUX_BLOB_2       IS 'This field contains the second auxiliary BLOB field';
COMMENT ON COLUMN LOGS.SESS_SID         IS 'This field contains the session SID';
COMMENT ON COLUMN LOGS.SESS_ID          IS 'This field contains the session ID';
COMMENT ON COLUMN LOGS.SESS_USER        IS 'This field contains the session user';
COMMENT ON COLUMN LOGS.DB_INSTANCE      IS 'This field contains the database instance';
COMMENT ON COLUMN LOGS.DB_INSTANCE_NAME IS 'This field contains the database instance name';
COMMENT ON COLUMN LOGS.USER_HOST        IS 'This field contains the user host';
COMMENT ON COLUMN LOGS.USER_IP_ADDRESS  IS 'This field contains the user IP address';
COMMENT ON COLUMN LOGS.OS_USER          IS 'This field contains the operating system user';
COMMENT ON COLUMN LOGS.CREATED_BY       IS 'This field contains the user who created the record';
COMMENT ON COLUMN LOGS.CREATED_AT       IS 'This field contains the date and time when the record was created';
COMMENT ON COLUMN LOGS.UPDATED_BY       IS 'This field contains the user who performed the last update to the record';
COMMENT ON COLUMN LOGS.UPDATED_AT       IS 'This field contains the date and time when the record was last updated';