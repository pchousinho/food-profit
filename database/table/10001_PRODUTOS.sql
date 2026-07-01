-------------------------------------------------------------------------------
-- CREATE DATE - Junho 2026
-- DESCRIPTION - Create table PRODUTOS
-------------------------------------------------------------------------------
CREATE TABLE PRODUTOS (
    ID                  NUMBER          NOT NULL
   ,CATEGORIA_ID        NUMBER          NOT NULL
   ,NOME                VARCHAR2(100)   NOT NULL
   ,DESCRICAO           VARCHAR2(4000)
   ,NOME_PESQUISA       VARCHAR2(150)
   ,IMAGEM              VARCHAR2(255)
   --
   ,STATUS              VARCHAR2(1)     DEFAULT 'A' NOT NULL
   ,CREATED_BY          VARCHAR2(250)
   ,CREATED_AT          DATE
   ,UPDATED_BY          VARCHAR2(250)
   ,UPDATED_AT          DATE
);
--
ALTER TABLE PRODUTOS ADD CONSTRAINT PK_PRODUTOS PRIMARY KEY (ID);
ALTER TABLE PRODUTOS ADD CONSTRAINT FK01_PRODUTOS FOREIGN KEY (CATEGORIA_ID) REFERENCES CATEGORIAS (ID) ENABLE;
--
ALTER TABLE PRODUTOS ADD CONSTRAINT CHK01_PRODUTOS_STATUS CHECK (STATUS IN ('A','I'));
--
COMMENT ON TABLE PRODUTOS                IS 'Esta tabela contém a lista de produtos utilizados no sistema';
--
COMMENT ON COLUMN PRODUTOS.ID            IS 'Este campo contém a chave primária da tabela';
COMMENT ON COLUMN PRODUTOS.CATEGORIA_ID  IS 'Este campo contém a chave estrangeira para a tabela de CATEGORIAS';
COMMENT ON COLUMN PRODUTOS.NOME          IS 'Este campo contém o nome do produto';
COMMENT ON COLUMN PRODUTOS.DESCRICAO     IS 'Este campo contém a descrição do produto';
COMMENT ON COLUMN PRODUTOS.NOME_PESQUISA IS 'Este campo contém o nome do produto para fins de pesquisa';
COMMENT ON COLUMN PRODUTOS.IMAGEM        IS 'Este campo contém o caminho da imagem do produto';
COMMENT ON COLUMN PRODUTOS.STATUS        IS 'Este campo contém o status atual (A - Ativo, I - Inativo)';
COMMENT ON COLUMN PRODUTOS.CREATED_BY    IS 'Este campo contém o usuário que criou o registro';
COMMENT ON COLUMN PRODUTOS.CREATED_AT    IS 'Este campo contém a data e hora de criação do registro';
COMMENT ON COLUMN PRODUTOS.UPDATED_BY    IS 'Este campo contém o usuário que realizou a última atualização do registro';
COMMENT ON COLUMN PRODUTOS.UPDATED_AT    IS 'Este campo contém a data e hora da última atualização do registro';