-------------------------------------------------------------------------------
-- CREATE DATE - Junho 2026
-- DESCRIPTION - Create table PRODUTOS
-------------------------------------------------------------------------------
CREATE TABLE PRODUTOS_SKU (
    ID                     NUMBER          NOT NULL
   ,PRODUTO_ID             NUMBER          NOT NULL
   ,FABRICANTE             VARCHAR2(150)   NOT NULL
   ,EAN                    VARCHAR2(50)
   ,QUANTIDADE_EMBALAGEM   NUMBER(18,6)    NOT NULL
   ,UNIDADE_EMBALAGEM_ID   NUMBER          NOT NULL
   ,QUANTIDADE_CONTEUDO    NUMBER(18,6)    NOT NULL
   ,UNIDADE_CONTEUDO_ID    NUMBER          NOT NULL
   ,QUANTIDADE_NORMALIZADA NUMBER(18,6)    NOT NULL
   ,IMAGEM                 VARCHAR2(255)
   --
   ,STATUS                 VARCHAR2(1)     DEFAULT 'A' NOT NULL
   ,CREATED_BY             VARCHAR2(250)
   ,CREATED_AT             DATE
   ,UPDATED_BY             VARCHAR2(250)
   ,UPDATED_AT             DATE
);
--
ALTER TABLE PRODUTOS_SKU ADD CONSTRAINT PK_PRODUTOS_SKU PRIMARY KEY (ID);
ALTER TABLE PRODUTOS_SKU ADD CONSTRAINT FK01_PRODUTOS_SKU FOREIGN KEY (PRODUTO_ID) REFERENCES PRODUTOS (ID) ENABLE;
ALTER TABLE PRODUTOS_SKU ADD CONSTRAINT FK01_PRODUTOS_SKU_UN_EMBALAGEM FOREIGN KEY (UNIDADE_EMBALAGEM_ID) REFERENCES UNIDADES_MEDIDA (ID) ENABLE;
ALTER TABLE PRODUTOS_SKU ADD CONSTRAINT FK01_PRODUTOS_SKU_UN_CONTEUDO FOREIGN KEY (UNIDADE_CONTEUDO_ID) REFERENCES UNIDADES_MEDIDA (ID) ENABLE;
--
ALTER TABLE PRODUTOS_SKU ADD CONSTRAINT UK01_PRODUTOS_SKU UNIQUE (EAN);
--
ALTER TABLE PRODUTOS_SKU ADD CONSTRAINT CHK01_PRODUTOS_SKU_STATUS CHECK (STATUS IN ('A','I'));
ALTER TABLE PRODUTOS_SKU ADD CONSTRAINT CHK02_PRODUTOS_SKU_EAN CHECK (EAN IS NULL OR REGEXP_LIKE(EAN, '^[0-9]{8,14}$'));
--
COMMENT ON TABLE PRODUTOS_SKU                         IS 'Esta tabela contém a lista de skus utilizados no sistema';
--
COMMENT ON COLUMN PRODUTOS_SKU.ID                     IS 'Este campo contém a chave primária da tabela';
COMMENT ON COLUMN PRODUTOS_SKU.PRODUTO_ID             IS 'Este campo contém a chave estrangeira para a tabela de PRODUTOS';
COMMENT ON COLUMN PRODUTOS_SKU.FABRICANTE             IS 'Este campo contém o nome do fabricante';
COMMENT ON COLUMN PRODUTOS_SKU.EAN                    IS 'Este campo contém o código EAN do produto';
COMMENT ON COLUMN PRODUTOS_SKU.QUANTIDADE_EMBALAGEM   IS 'Este campo contém a quantidade de itens na embalagem';
COMMENT ON COLUMN PRODUTOS_SKU.UNIDADE_EMBALAGEM_ID   IS 'Este campo contém a unidade de medida para a embalagem';
COMMENT ON COLUMN PRODUTOS_SKU.QUANTIDADE_CONTEUDO    IS 'Este campo contém a quantidade de itens no conteúdo';
COMMENT ON COLUMN PRODUTOS_SKU.UNIDADE_CONTEUDO_ID    IS 'Este campo contém a unidade de medida para o conteúdo';
COMMENT ON COLUMN PRODUTOS_SKU.QUANTIDADE_NORMALIZADA IS 'Este campo contém a quantidade normalizada do produto';
COMMENT ON COLUMN PRODUTOS_SKU.IMAGEM                 IS 'Este campo contém o caminho da imagem do produto';
COMMENT ON COLUMN PRODUTOS_SKU.STATUS                 IS 'Este campo contém o status atual (A - Ativo, I - Inativo)';
COMMENT ON COLUMN PRODUTOS_SKU.CREATED_BY             IS 'Este campo contém o usuário que criou o registro';
COMMENT ON COLUMN PRODUTOS_SKU.CREATED_AT             IS 'Este campo contém a data e hora de criação do registro';
COMMENT ON COLUMN PRODUTOS_SKU.UPDATED_BY             IS 'Este campo contém o usuário que realizou a última atualização do registro';
COMMENT ON COLUMN PRODUTOS_SKU.UPDATED_AT             IS 'Este campo contém a data e hora da última atualização do registro';