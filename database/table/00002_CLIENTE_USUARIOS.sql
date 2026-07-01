-------------------------------------------------------------------------------
-- CREATE DATE - December 2025
-- DESCRIPTION - Create table CLIENTE_USUARIOS
-------------------------------------------------------------------------------
CREATE TABLE CLIENTE_USUARIOSS
(
   CLIENTE_ID     NUMBER                        NOT NULL
  ,USUARIO_ID     NUMBER                        NOT NULL
  ,NIVEL_ACESSO   VARCHAR2(4)    DEFAULT 'VIEW' NOT NULL
  ,DATA_EXPIRACAO DATE
  ,STATUS         VARCHAR2(1)    DEFAULT 'A'    NOT NULL
  --
  ,CREATED_BY     VARCHAR2(250)
  ,CREATED_AT     DATE
  ,UPDATED_BY     VARCHAR2(250)
  ,UPDATED_AT     DATE
);
--
ALTER TABLE CLIENTE_USUARIOSS ADD CONSTRAINT PK_CLIENTE_USUARIOSS PRIMARY KEY (CLIENTE_ID, USUARIO_ID);
--
ALTER TABLE CLIENTE_USUARIOSS ADD CONSTRAINT FK01_CLIENTE_USUARIOSS FOREIGN KEY (CLIENTE_ID) REFERENCES CLIENTES (ID) ON DELETE CASCADE;
ALTER TABLE CLIENTE_USUARIOSS ADD CONSTRAINT FK02_CLIENTE_USUARIOSS FOREIGN KEY (USUARIO_ID) REFERENCES USUARIOS (ID) ON DELETE CASCADE;
--
ALTER TABLE CLIENTE_USUARIOSS ADD CONSTRAINT CHK01_CLIENTE_USUARIOS_NIVEL_ACESSO CHECK (NIVEL_ACESSO IN ('ADM','USR','VIEW'));
--
COMMENT ON TABLE CLIENTE_USUARIOSS                 IS 'Esta tabela contém o relacionamento entre CLIENTES e USUARIOS';
--
COMMENT ON COLUMN CLIENTE_USUARIOSS.CLIENTE_ID     IS 'Este campo contém a chave primária da tabela de CLIENTES';
COMMENT ON COLUMN CLIENTE_USUARIOSS.USUARIO_ID     IS 'Este campo contém a chave primária da tabela de USUARIOS';
COMMENT ON COLUMN CLIENTE_USUARIOSS.NIVEL_ACESSO   IS 'Este campo contém o nivel de acesso do usuario para este cliente (ADM, USR, VIEW)';
COMMENT ON COLUMN CLIENTE_USUARIOSS.DATA_EXPIRACAO IS 'Este campo contem a data em que o acesso do usuario expira';
COMMENT ON COLUMN CLIENTE_USUARIOSS.STATUS         IS 'Este campo contém o status atual (A - Ativo, I - Inativo)';
COMMENT ON COLUMN CLIENTE_USUARIOSS.CREATED_BY     IS 'Este campo contem o usuario que criou o registro';
COMMENT ON COLUMN CLIENTE_USUARIOSS.CREATED_AT     IS 'Este campo contem a data e hora de criacao do registro';
COMMENT ON COLUMN CLIENTE_USUARIOSS.UPDATED_BY     IS 'Este campo contem o usuario que realizou a ultima atualizacao do registro';
COMMENT ON COLUMN CLIENTE_USUARIOSS.UPDATED_AT     IS 'Este campo contem a data e hora da ultima atualizacao do registro';
