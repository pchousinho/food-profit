-------------------------------------------------------------------------------
-- CREATE DATE - June 2026
-- DESCRIPTION - Create table PRODUCTS
-------------------------------------------------------------------------------
CREATE TABLE PRODUCTS (
    ID                  NUMBER          NOT NULL
   ,CATEGORY_ID         NUMBER          NOT NULL
   ,NAME                VARCHAR2(100)              NOT NULL
   ,DESCRIPTION         VARCHAR2(4000)
   ,SEARCH_NAME         VARCHAR2(150)
   ,IMAGE               VARCHAR2(255)
   ,STATUS              VARCHAR2(1)     DEFAULT 'A'NOT NULL
   --
   ,CREATED_BY          VARCHAR2(250)   DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
   ,CREATED_AT          TIMESTAMP       DEFAULT SYSTIMESTAMP                            NOT NULL
   ,UPDATED_BY          VARCHAR2(250)   DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
   ,UPDATED_AT          TIMESTAMP       DEFAULT SYSTIMESTAMP                            NOT NULL
);
--
ALTER TABLE PRODUCTS ADD CONSTRAINT PK_PRODUCTS PRIMARY KEY (ID);
ALTER TABLE PRODUCTS ADD CONSTRAINT FK01_PRODUCTS FOREIGN KEY (CATEGORY_ID) REFERENCES CATEGORIES (ID) ENABLE;
--
ALTER TABLE PRODUCTS ADD CONSTRAINT CHK01_PRODUCTS_STATUS CHECK (STATUS IN ('A','I'));
--
COMMENT ON TABLE PRODUCTS                IS 'This table contains the list of products used in the system';
--
COMMENT ON COLUMN PRODUCTS.ID            IS 'This field contains the primary key of the table';
COMMENT ON COLUMN PRODUCTS.CATEGORY_ID   IS 'This field contains the foreign key to the CATEGORIES table';
COMMENT ON COLUMN PRODUCTS.NAME          IS 'This field contains the name of the product';
COMMENT ON COLUMN PRODUCTS.DESCRIPTION   IS 'This field contains the description of the product';
COMMENT ON COLUMN PRODUCTS.SEARCH_NAME   IS 'This field contains the product name used for search purposes';
COMMENT ON COLUMN PRODUCTS.IMAGE         IS 'This field contains the path to the product image';
COMMENT ON COLUMN PRODUCTS.STATUS        IS 'This field contains the current status (A - Active, I - Inactive)';
COMMENT ON COLUMN PRODUCTS.CREATED_BY    IS 'This field contains the user who created the record';
COMMENT ON COLUMN PRODUCTS.CREATED_AT    IS 'This field contains the date and time when the record was created';
COMMENT ON COLUMN PRODUCTS.UPDATED_BY    IS 'This field contains the user who performed the last update to the record';
COMMENT ON COLUMN PRODUCTS.UPDATED_AT    IS 'This field contains the date and time when the record was last updated';