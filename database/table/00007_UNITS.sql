-------------------------------------------------------------------------------
-- CREATE DATE - June 2026
-- DESCRIPTION - Create table UNITS
-------------------------------------------------------------------------------
CREATE TABLE UNITS (
    ID                  NUMBER                     NOT NULL
   ,UNIT_GROUP_ID       NUMBER                     NOT NULL
   ,NAME                VARCHAR2(50)               NOT NULL
   ,SYMBOL              VARCHAR2(10)               NOT NULL
   ,DISPLAY_ORDER       NUMBER(3)      DEFAULT 0   NOT NULL
   ,BASE_FACTOR         NUMBER(18,6)               NOT NULL
   ,STATUS              VARCHAR2(1)    DEFAULT 'A' NOT NULL
   --
   ,CREATED_BY          VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
   ,CREATED_AT          TIMESTAMP      DEFAULT SYSTIMESTAMP                            NOT NULL
   ,UPDATED_BY          VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
   ,UPDATED_AT          TIMESTAMP      DEFAULT SYSTIMESTAMP                            NOT NULL
);
--
ALTER TABLE UNITS ADD CONSTRAINT PK_UNITS PRIMARY KEY (ID);
ALTER TABLE UNITS ADD CONSTRAINT UK01_UNITS UNIQUE (NAME);
--
ALTER TABLE UNITS ADD CONSTRAINT CHK01_UNITS_STATUS CHECK (STATUS IN ('A','I'));
--
COMMENT ON TABLE UNITS                 IS 'This table contains the list of units used to classify records in the system';
--
COMMENT ON COLUMN UNITS.ID             IS 'This field contains the primary key of the table';
COMMENT ON COLUMN UNITS.UNIT_GROUP_ID  IS 'This field contains the identifier of the unit group';
COMMENT ON COLUMN UNITS.NAME           IS 'This field contains the name of the unit';
COMMENT ON COLUMN UNITS.SYMBOL         IS 'This field contains the symbol of the unit';
COMMENT ON COLUMN UNITS.DISPLAY_ORDER  IS 'This field contains the display order of the units';
COMMENT ON COLUMN UNITS.BASE_FACTOR    IS 'This field contains the conversion factor to the base unit';
COMMENT ON COLUMN UNITS.STATUS         IS 'This field contains the current status (A - Active, I - Inactive)';
COMMENT ON COLUMN UNITS.CREATED_BY     IS 'This field contains the user who created the record';
COMMENT ON COLUMN UNITS.CREATED_AT     IS 'This field contains the date and time when the record was created';
COMMENT ON COLUMN UNITS.UPDATED_BY     IS 'This field contains the user who performed the last update to the record';
COMMENT ON COLUMN UNITS.UPDATED_AT     IS 'This field contains the date and time when the record was last updated';