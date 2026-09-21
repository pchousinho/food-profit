-------------------------------------------------------------------------------
-- CREATE DATE - August 2026
-- DESCRIPTION - Create table SYSTEM_PARAMETERS
-------------------------------------------------------------------------------
CREATE TABLE SYSTEM_PARAMETERS
(
   CODE           VARCHAR2(50)   NOT NULL
  ,DESCRIPTION    VARCHAR2(100)  NOT NULL
  ,VALUE          VARCHAR2(255)  NOT NULL
  --
  ,CREATED_BY     VARCHAR2(250) DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
  ,CREATED_AT     TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL
  ,UPDATED_BY     VARCHAR2(250) DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
  ,UPDATED_AT     TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL
);
--
ALTER TABLE SYSTEM_PARAMETERS ADD CONSTRAINT PK_SYSTEM_PARAMETERS PRIMARY KEY (CODE);
--
COMMENT ON TABLE SYSTEM_PARAMETERS               IS 'This table contains the list of system parameters';
--
COMMENT ON COLUMN SYSTEM_PARAMETERS.CODE        IS 'This field contains the unique code used to identify the parameter';
COMMENT ON COLUMN SYSTEM_PARAMETERS.DESCRIPTION IS 'This field contains the description of the parameter';
COMMENT ON COLUMN SYSTEM_PARAMETERS.VALUE       IS 'This field contains the value of the parameter';
COMMENT ON COLUMN SYSTEM_PARAMETERS.CREATED_BY  IS 'This field contains the user who created the record';
COMMENT ON COLUMN SYSTEM_PARAMETERS.CREATED_AT  IS 'This field contains the date and time when the record was created';
COMMENT ON COLUMN SYSTEM_PARAMETERS.UPDATED_BY  IS 'This field contains the user who performed the last update to the record';
COMMENT ON COLUMN SYSTEM_PARAMETERS.UPDATED_AT  IS 'This field contains the date and time when the record was last updated';