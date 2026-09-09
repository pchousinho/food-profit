-------------------------------------------------------------------------------
-- CREATE DATE - June 2026
-- DESCRIPTION - Create table CATEGORIES
-------------------------------------------------------------------------------
CREATE TABLE CATEGORIES
(
   ID 	         NUMBER 			            NOT NULL
  ,CLIENT_ID      NUMBER 			            NOT NULL
  ,DESCRIPTION 	VARCHAR2(250) 	            NOT NULL
  ,SUMMARY        VARCHAR2(250) 	            NOT NULL
  ,BG_COLOR       VARCHAR2(9) 	            NOT NULL
  ,ICON           VARCHAR2(250) 	            NOT NULL
  ,STATUS 	      VARCHAR2(1) 	DEFAULT 'A' NOT NULL
  --
  ,CREATED_BY 	   VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
  ,CREATED_AT 	   TIMESTAMP      DEFAULT SYSTIMESTAMP                            NOT NULL
  ,UPDATED_BY 	   VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
  ,UPDATED_AT 	   TIMESTAMP      DEFAULT SYSTIMESTAMP                            NOT NULL
);
--
ALTER TABLE CATEGORIES ADD CONSTRAINT PK_CATEGORIES PRIMARY KEY (ID);
ALTER TABLE CATEGORIES ADD CONSTRAINT FK01_CATEGORIES FOREIGN KEY (CLIENT_ID) REFERENCES CLIENTS (ID) ENABLE;
--
ALTER TABLE CATEGORIES ADD CONSTRAINT CHK01_CATEGORIES_STATUS CHECK (STATUS IN ('A','I'));
--
COMMENT ON TABLE CATEGORIES                   IS 'This table contains the list of categories used to classify records in the system';
--
COMMENT ON COLUMN CATEGORIES.ID               IS 'This field contains the primary key of the table';
COMMENT ON COLUMN CATEGORIES.CLIENT_ID        IS 'This field contains the foreign key to the CLIENTS table';
COMMENT ON COLUMN CATEGORIES.DESCRIPTION      IS 'This field contains the description of the category';
COMMENT ON COLUMN CATEGORIES.SUMMARY          IS 'This field contains the summary of the category';
COMMENT ON COLUMN CATEGORIES.BACKGROUND_COLOR IS 'This field contains the background color of the category';
COMMENT ON COLUMN CATEGORIES.ICON             IS 'This field contains the icon of the category';
COMMENT ON COLUMN CATEGORIES.STATUS           IS 'This field contains the current status (A - Active, I - Inactive)';
COMMENT ON COLUMN CATEGORIES.CREATED_BY       IS 'This field contains the user who created the record';
COMMENT ON COLUMN CATEGORIES.CREATED_AT       IS 'This field contains the date and time when the record was created';
COMMENT ON COLUMN CATEGORIES.UPDATED_BY       IS 'This field contains the user who performed the last update to the record';
COMMENT ON COLUMN CATEGORIES.UPDATED_AT       IS 'This field contains the date and time when the record was last updated';