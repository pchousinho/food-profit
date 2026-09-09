-------------------------------------------------------------------------------
-- CREATE DATE - June 2026
-- DESCRIPTION - Create table PRODUCT_SKU
-------------------------------------------------------------------------------
CREATE TABLE PRODUCT_SKU (
    ID                NUMBER                     NOT NULL
   ,PRODUCT_ID        NUMBER                     NOT NULL
   ,MANUFACTURER      VARCHAR2(150)              NOT NULL
   ,EAN               VARCHAR2(50)
   ,PACKAGE_QTY       NUMBER(18,6)               NOT NULL
   ,PACKAGE_UNIT_ID   NUMBER                     NOT NULL
   ,CONTENT_QTY       NUMBER(18,6)               NOT NULL
   ,CONTENT_UNIT_ID   NUMBER                     NOT NULL
   ,NORMALIZED_QTY    NUMBER(18,6)               NOT NULL
   ,IMAGE             VARCHAR2(255)
   ,STATUS            VARCHAR2(1)    DEFAULT 'A' NOT NULL
   --
   ,CREATED_BY        VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
   ,CREATED_AT        TIMESTAMP      DEFAULT SYSTIMESTAMP                            NOT NULL
   ,UPDATED_BY        VARCHAR2(250)  DEFAULT SYS_CONTEXT('USERENV','CURRENT_SCHEMA') NOT NULL
   ,UPDATED_AT        TIMESTAMP      DEFAULT SYSTIMESTAMP                            NOT NULL
);
--
ALTER TABLE PRODUCT_SKU ADD CONSTRAINT PK_PRODUCT_SKU PRIMARY KEY (ID);
ALTER TABLE PRODUCT_SKU ADD CONSTRAINT FK01_PRODUCT_SKU FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCTS (ID) ENABLE;
ALTER TABLE PRODUCT_SKU ADD CONSTRAINT FK02_PRODUCT_SKU_PACKAGE_UNIT FOREIGN KEY (PACKAGE_UNIT_ID) REFERENCES UNITS (ID) ENABLE;
ALTER TABLE PRODUCT_SKU ADD CONSTRAINT FK03_PRODUCT_SKU_CONTENT_UNIT FOREIGN KEY (CONTENT_UNIT_ID) REFERENCES UNITS (ID) ENABLE;
--
ALTER TABLE PRODUCT_SKU ADD CONSTRAINT UK01_PRODUCT_SKU UNIQUE (EAN);
--
ALTER TABLE PRODUCT_SKU ADD CONSTRAINT CHK01_PRODUCT_SKU_STATUS CHECK (STATUS IN ('A','I'));
ALTER TABLE PRODUCT_SKU ADD CONSTRAINT CHK02_PRODUCT_SKU_EAN CHECK (EAN IS NULL OR REGEXP_LIKE(EAN, '^[0-9]{8,14}$'));
--
COMMENT ON TABLE PRODUCT_SKU                    IS 'This table contains the list of SKUs used in the system';
--
COMMENT ON COLUMN PRODUCT_SKU.ID                IS 'This field contains the primary key of the table';
COMMENT ON COLUMN PRODUCT_SKU.PRODUCT_ID        IS 'This field contains the foreign key to the PRODUCTS table';
COMMENT ON COLUMN PRODUCT_SKU.MANUFACTURER      IS 'This field contains the name of the manufacturer';
COMMENT ON COLUMN PRODUCT_SKU.EAN               IS 'This field contains the EAN code of the product';
COMMENT ON COLUMN PRODUCT_SKU.PACKAGE_QTY       IS 'This field contains the quantity of items in the package';
COMMENT ON COLUMN PRODUCT_SKU.PACKAGE_UNIT_ID   IS 'This field contains the unit of measure for the package';
COMMENT ON COLUMN PRODUCT_SKU.CONTENT_QTY       IS 'This field contains the quantity of items in the content';
COMMENT ON COLUMN PRODUCT_SKU.CONTENT_UNIT_ID   IS 'This field contains the unit of measure for the content';
COMMENT ON COLUMN PRODUCT_SKU.NORMALIZED_QTY    IS 'This field contains the normalized quantity of the product';
COMMENT ON COLUMN PRODUCT_SKU.IMAGE             IS 'This field contains the path to the product image';
COMMENT ON COLUMN PRODUCT_SKU.STATUS            IS 'This field contains the current status (A - Active, I - Inactive)';
COMMENT ON COLUMN PRODUCT_SKU.CREATED_BY        IS 'This field contains the user who created the record';
COMMENT ON COLUMN PRODUCT_SKU.CREATED_AT        IS 'This field contains the date and time when the record was created';
COMMENT ON COLUMN PRODUCT_SKU.UPDATED_BY        IS 'This field contains the user who performed the last update to the record';
COMMENT ON COLUMN PRODUCT_SKU.UPDATED_AT        IS 'This field contains the date and time when the record was last updated';