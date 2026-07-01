-------------------------------------------------------------------------------
-- CREATE DATE - December 2025
-- DESCRIPTION - Create table CLIENTE_USUARIOS
-------------------------------------------------------------------------------
CREATE TABLE CLIENTE_USUARIOS
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
ALTER TABLE CLIENTE_USUARIOS ADD CONSTRAINT PK_CLIENTE_USUARIOS PRIMARY KEY (CLIENTE_ID, USUARIO_ID);
--
ALTER TABLE CLIENTE_USUARIOS ADD CONSTRAINT FK01_CLIENTE_USUARIOS FOREIGN KEY (CLIENTE_ID) REFERENCES CLIENTES (ID) ON DELETE CASCADE;
ALTER TABLE CLIENTE_USUARIOS ADD CONSTRAINT FK02_CLIENTE_USUARIOS FOREIGN KEY (USUARIO_ID) REFERENCES USUARIOS (ID) ON DELETE CASCADE;
--
ALTER TABLE CLIENTE_USUARIOS ADD CONSTRAINT CHK01_CLIENTE_USUARIOS_NIVEL_ACESSO CHECK (NIVEL_ACESSO IN ('ADM','USR','VIEW'));
--
COMMENT ON TABLE CLIENTE_USUARIOS                 IS 'Esta tabela contém o relacionamento entre CLIENTES e USUARIOS';
--
COMMENT ON COLUMN CLIENTE_USUARIOS.CLIENTE_ID     IS 'Este campo contém a chave primária da tabela de CLIENTES';
COMMENT ON COLUMN CLIENTE_USUARIOS.USUARIO_ID     IS 'Este campo contém a chave primária da tabela de USUARIOS';
COMMENT ON COLUMN CLIENTE_USUARIOS.NIVEL_ACESSO   IS 'Este campo contém o nivel de acesso do usuario para este cliente (ADM, USR, VIEW)';
COMMENT ON COLUMN CLIENTE_USUARIOS.DATA_EXPIRACAO IS 'Este campo contem a data em que o acesso do usuario expira';
COMMENT ON COLUMN CLIENTE_USUARIOS.STATUS         IS 'Este campo contém o status atual (A - Ativo, I - Inativo)';
COMMENT ON COLUMN CLIENTE_USUARIOS.CREATED_BY     IS 'Este campo contem o usuario que criou o registro';
COMMENT ON COLUMN CLIENTE_USUARIOS.CREATED_AT     IS 'Este campo contem a data e hora de criacao do registro';
COMMENT ON COLUMN CLIENTE_USUARIOS.UPDATED_BY     IS 'Este campo contem o usuario que realizou a ultima atualizacao do registro';
COMMENT ON COLUMN CLIENTE_USUARIOS.UPDATED_AT     IS 'Este campo contem a data e hora da ultima atualizacao do registro';
