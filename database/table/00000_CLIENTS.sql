-------------------------------------------------------------------------------
-- CREATE DATE - June 2026
-- DESCRIPTION - Create table CLIENTS
-------------------------------------------------------------------------------
CREATE TABLE CLIENTS
(
   ID 	         NUMBER 			            NOT NULL
  ,DESCRIPTION 	VARCHAR2(250) 	            NOT NULL
  ,USER_COUNT     NUMBER 			DEFAULT 0   NOT NULL
  ,BONUS_COUNT    NUMBER 			DEFAULT 0   NOT NULL
  ,STATUS 	      VARCHAR2(1) 	DEFAULT 'A' NOT NULL
  --
  ,CREATED_BY 		VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
  ,CREATED_AT 		TIMESTAMP      DEFAULT SYSTIMESTAMP                            NOT NULL
  ,UPDATED_BY 		VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
  ,UPDATED_AT 		TIMESTAMP      DEFAULT SYSTIMESTAMP                            NOT NULL
);
--
ALTER TABLE CLIENTS ADD CONSTRAINT PK_CLIENTS PRIMARY KEY (ID);
--
ALTER TABLE CLIENTS ADD CONSTRAINT CHK01_CLIENTS_STATUS CHECK (STATUS IN ('A','I'));
--
COMMENT ON TABLE CLIENTS 				 	IS 'This table contains the list of clients';
--
COMMENT ON COLUMN CLIENTS.ID           IS 'This field contains the primary key of the table';
COMMENT ON COLUMN CLIENTS.DESCRIPTION  IS 'This field contains the client description';
COMMENT ON COLUMN CLIENTS.STATUS       IS 'This field contains the current status (A - Active, I - Inactive)';
COMMENT ON COLUMN CLIENTS.CREATED_BY   IS 'This field contains the user who created the record';
COMMENT ON COLUMN CLIENTS.CREATED_AT   IS 'This field contains the date and time when the record was created';
COMMENT ON COLUMN CLIENTS.UPDATED_BY   IS 'This field contains the user who performed the last update to the record';
COMMENT ON COLUMN CLIENTS.UPDATED_AT   IS 'This field contains the date and time when the record was last updated';