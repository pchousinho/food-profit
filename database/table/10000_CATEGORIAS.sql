-------------------------------------------------------------------------------
-- CREATE DATE - Junho 2026
-- DESCRIPTION - Create table CATEGORIAS
-------------------------------------------------------------------------------
CREATE TABLE CATEGORIAS
(
   ID 	         NUMBER 			            NOT NULL
  ,CLIENTE_ID     NUMBER 			            NOT NULL
  ,DESCRICAO 	   VARCHAR2(250) 	            NOT NULL
  ,RESUMO         VARCHAR2(250) 	            NOT NULL
  ,COR_FUNDO      VARCHAR2(9) 	            NOT NULL
  ,ICONE          VARCHAR2(250) 	            NOT NULL
  ,STATUS 	      VARCHAR2(1) 	DEFAULT 'A' NOT NULL
  --
  ,CREATED_BY 	   VARCHAR2(250)
  ,CREATED_AT 	   DATE
  ,UPDATED_BY 	   VARCHAR2(250)
  ,UPDATED_AT 	   DATE
);
--
ALTER TABLE CATEGORIAS ADD CONSTRAINT PK_CATEGORIAS PRIMARY KEY (ID);
ALTER TABLE CATEGORIAS ADD CONSTRAINT FK01_CATEGORIAS FOREIGN KEY (CLIENTE_ID) REFERENCES CLIENTES (ID) ENABLE;
--
ALTER TABLE CATEGORIAS ADD CONSTRAINT CHK01_CATEGORIAS_STATUS CHECK (STATUS IN ('A','I'));
--
COMMENT ON TABLE CATEGORIAS               IS 'Esta tabela contém a lista de categorias utilizadas para classificar registros no sistema';
--
COMMENT ON COLUMN CATEGORIAS.ID           IS 'Este campo contém a chave primária da tabela';
COMMENT ON COLUMN CATEGORIAS.CLIENTE_ID   IS 'Este campo contém a chave estrangeira para a tabela de CLIENTES';
COMMENT ON COLUMN CATEGORIAS.DESCRICAO    IS 'Este campo contém a descrição da categoria';
COMMENT ON COLUMN CATEGORIAS.RESUMO       IS 'Este campo contém o resumo da categoria';
COMMENT ON COLUMN CATEGORIAS.COR_FUNDO    IS 'Este campo contém a cor de fundo da categoria';
COMMENT ON COLUMN CATEGORIAS.ICONE        IS 'Este campo contém o ícone da categoria';
COMMENT ON COLUMN CATEGORIAS.STATUS       IS 'Este campo contém o status atual (A - Ativo, I - Inativo)';
COMMENT ON COLUMN CATEGORIAS.CREATED_BY   IS 'Este campo contém o usuário que criou o registro';
COMMENT ON COLUMN CATEGORIAS.CREATED_AT   IS 'Este campo contém a data e hora de criação do registro';
COMMENT ON COLUMN CATEGORIAS.UPDATED_BY   IS 'Este campo contém o usuário que realizou a última atualização do registro';
COMMENT ON COLUMN CATEGORIAS.UPDATED_AT   IS 'Este campo contém a data e hora da última atualização do registro';