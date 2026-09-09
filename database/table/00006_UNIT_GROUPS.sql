-------------------------------------------------------------------------------
-- CREATE DATE - June 2026
-- DESCRIPTION - Create table UNIT_GROUPS
-------------------------------------------------------------------------------
CREATE TABLE UNIT_GROUPS (
   ID              NUMBER                    NOT NULL
  ,NAME            VARCHAR2(50)              NOT NULL
  ,DESCRIPTION     VARCHAR2(250)
  ,STATUS          VARCHAR2(1)   DEFAULT 'A' NOT NULL
  --
  ,CREATED_BY     VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
  ,CREATED_AT     TIMESTAMP      DEFAULT SYSTIMESTAMP                            NOT NULL
  ,UPDATED_BY     VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
  ,UPDATED_AT     TIMESTAMP      DEFAULT SYSTIMESTAMP                            NOT NULL
);
--
ALTER TABLE UNIT_GROUPS ADD CONSTRAINT PK_UNIT_GROUPS PRIMARY KEY (ID);
ALTER TABLE UNIT_GROUPS ADD CONSTRAINT UK01_UNIT_GROUPS UNIQUE (NAME);
--
ALTER TABLE UNIT_GROUPS ADD CONSTRAINT CHK01_UNIT_GROUPS_STATUS CHECK (STATUS IN ('A','I'));
--
COMMENT ON TABLE UNIT_GROUPS                IS 'This table contains the list of unit groups used to classify records in the system';
--
COMMENT ON COLUMN UNIT_GROUPS.ID            IS 'This field contains the primary key of the table';
COMMENT ON COLUMN UNIT_GROUPS.NAME          IS 'This field contains the name of the unit group';
COMMENT ON COLUMN UNIT_GROUPS.DESCRIPTION   IS 'This field contains the description of the unit group';
COMMENT ON COLUMN UNIT_GROUPS.STATUS        IS 'This field contains the current status (A - Active, I - Inactive)';
COMMENT ON COLUMN UNIT_GROUPS.CREATED_BY    IS 'This field contains the user who created the record';
COMMENT ON COLUMN UNIT_GROUPS.CREATED_AT    IS 'This field contains the date and time when the record was created';
COMMENT ON COLUMN UNIT_GROUPS.UPDATED_BY    IS 'This field contains the user who performed the last update to the record';
COMMENT ON COLUMN UNIT_GROUPS.UPDATED_AT    IS 'This field contains the date and time when the record was last updated';