-------------------------------------------------------------------------------
-- CREATE DATE - Junho 2026
-- DESCRIPTION - Create table CLIENTE
-------------------------------------------------------------------------------
CREATE TABLE CLIENTES
(
   ID 	         NUMBER 			            NOT NULL
  ,DESCRICAO 	   VARCHAR2(250) 	            NOT NULL
  ,QTD_USUARIOS   NUMBER 			DEFAULT 0   NOT NULL
  ,QTD_BONIFICADO NUMBER 			DEFAULT 0   NOT NULL
  ,STATUS 	      VARCHAR2(1) 	DEFAULT 'A' NOT NULL
  --
  ,CREATED_BY 		VARCHAR2(250)
  ,CREATED_AT 		DATE
  ,UPDATED_BY 		VARCHAR2(250)
  ,UPDATED_AT 		DATE
);
--
ALTER TABLE CLIENTES ADD CONSTRAINT PK_CLIENTES PRIMARY KEY (ID);
--
ALTER TABLE CLIENTES ADD CONSTRAINT CHK01_CLIENTES CHECK (STATUS IN ('A','I'));
--
COMMENT ON TABLE CLIENTES 				 	IS 'Esta tabela contem a lista de clientes';
--
COMMENT ON COLUMN CLIENTES.ID          IS 'Este campo contem a chave primaria da tabela';
COMMENT ON COLUMN CLIENTES.DESCRICAO   IS 'Este campo contem a descricao do cliente';
COMMENT ON COLUMN CLIENTES.STATUS      IS 'Este campo contem o status atual (A - Ativo, I - Inativo)';
COMMENT ON COLUMN CLIENTES.CREATED_BY  IS 'Este campo contem o usuario que criou o registro';
COMMENT ON COLUMN CLIENTES.CREATED_AT  IS 'Este campo contem a data e hora de criacao do registro';
COMMENT ON COLUMN CLIENTES.UPDATED_BY  IS 'Este campo contem o usuario que realizou a ultima atualizacao do registro';
COMMENT ON COLUMN CLIENTES.UPDATED_AT  IS 'Este campo contem a data e hora da ultima atualizacao do registro';
