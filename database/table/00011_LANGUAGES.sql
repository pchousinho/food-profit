-------------------------------------------------------------------------------
-- CREATE DATE - September 2026
-- DESCRIPTION - Create table LANGUAGES
-------------------------------------------------------------------------------
CREATE TABLE LANGUAGES
(
   ID             NUMBER                      NOT NULL
  ,CODE           VARCHAR2(10)                NOT NULL
  ,DESCRIPTION    VARCHAR2(100)               NOT NULL
  --
  ,CREATED_BY     VARCHAR2(250) DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
  ,CREATED_AT     TIMESTAMP     DEFAULT SYSTIMESTAMP                            NOT NULL
  ,UPDATED_BY     VARCHAR2(250) DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
  ,UPDATED_AT     TIMESTAMP     DEFAULT SYSTIMESTAMP                            NOT NULL
);
--
ALTER TABLE LANGUAGES ADD CONSTRAINT PK_LANGUAGES PRIMARY KEY (ID);
--
ALTER TABLE LANGUAGES ADD CONSTRAINT UK_LANGUAGES_CODE UNIQUE (CODE);
--
COMMENT ON TABLE LANGUAGES IS 'This table contains the list of available languages';
--
COMMENT ON COLUMN LANGUAGES.ID            IS 'This field contains the primary key of the table';
COMMENT ON COLUMN LANGUAGES.CODE          IS 'This field contains the language code, such as en, pt-BR or sv';
COMMENT ON COLUMN LANGUAGES.DESCRIPTION   IS 'This field contains the language name, such as English, Português or Swedish';
COMMENT ON COLUMN LANGUAGES.CREATED_BY    IS 'This field contains the user who created the record';
COMMENT ON COLUMN LANGUAGES.CREATED_AT    IS 'This field contains the date and time when the record was created';
COMMENT ON COLUMN LANGUAGES.UPDATED_BY    IS 'This field contains the user who performed the last update to the record';
COMMENT ON COLUMN LANGUAGES.UPDATED_AT    IS 'This field contains the date and time when the record was last updated';