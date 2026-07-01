-------------------------------------------------------------------------------
-- CREATE DATE - December 2025
-- DESCRIPTION - Create table USUARIOS
-------------------------------------------------------------------------------
CREATE TABLE USUARIOS
(
   ID             NUMBER                         NOT NULL
  ,CLIENTE_ID     NUMBER                         NOT NULL
  ,EMAIL          VARCHAR2(250)                  NOT NULL
  ,NOME           VARCHAR2(250)                  NOT NULL
  ,FALHAS_LOGIN   NUMBER           DEFAULT 0     NOT NULL
  ,STATUS         VARCHAR2(1)      DEFAULT 'A'   NOT NULL
  ,GOOGLE_SUB     VARCHAR2(100)
  ,ULTIMO_LOGIN   DATE
  --
  ,CREATED_BY     VARCHAR2(250)
  ,CREATED_AT     DATE
  ,UPDATED_BY     VARCHAR2(250)
  ,UPDATED_AT     DATE
);
--
ALTER TABLE USUARIOS ADD CONSTRAINT PK_USUARIOS PRIMARY KEY (ID);
--
ALTER TABLE USUARIOS ADD CONSTRAINT FK_USUARIOS_CLIENTE FOREIGN KEY (CLIENTE_ID) REFERENCES CLIENTES (ID);
--
ALTER TABLE USUARIOS ADD CONSTRAINT UK01_USUARIOS_EMAIL UNIQUE (EMAIL);
ALTER TABLE USUARIOS ADD CONSTRAINT UK02_USUARIOS_GOOGLE_SUB UNIQUE (GOOGLE_SUB);
--
ALTER TABLE USUARIOS ADD CONSTRAINT CHK01_USUARIOS_STATUS CHECK (STATUS IN ('A','I'));
ALTER TABLE USUARIOS ADD CONSTRAINT CHK02_USUARIOS_FALHAS_LOGIN CHECK (FALHAS_LOGIN >= 0);
--
COMMENT ON TABLE USUARIOS                 IS 'Esta tabela contem a lista de usuarios';
--
COMMENT ON COLUMN USUARIOS.ID             IS 'Este campo contem a chave primaria da tabela';
COMMENT ON COLUMN USUARIOS.CLIENTE_ID     IS 'Este campo contem a chave estrangeira para a tabela de CLIENTES';
COMMENT ON COLUMN USUARIOS.EMAIL          IS 'Este campo contem o endereco de e-mail utilizado para autenticacao';
COMMENT ON COLUMN USUARIOS.NOME           IS 'Este campo contem o nome completo do usuario';
COMMENT ON COLUMN USUARIOS.FALHAS_LOGIN   IS 'Este campo contem o numero de tentativas consecutivas de login com falha';
COMMENT ON COLUMN USUARIOS.STATUS         IS 'Este campo contem o status atual (A - Ativo, I - Inativo)';
COMMENT ON COLUMN USUARIOS.GOOGLE_SUB     IS 'Este campo contem o identificador de sujeito do OpenID Connect do Google (ID imutavel do usuario)';
COMMENT ON COLUMN USUARIOS.ULTIMO_LOGIN   IS 'Este campo contem o timestamp do ultimo login bem-sucedido';
COMMENT ON COLUMN USUARIOS.CREATED_BY     IS 'Este campo contem o usuario que criou o registro';
COMMENT ON COLUMN USUARIOS.CREATED_AT     IS 'Este campo contem a data e hora de criacao do registro';
COMMENT ON COLUMN USUARIOS.UPDATED_BY     IS 'Este campo contem o usuario que realizou a ultima atualizacao do registro';
COMMENT ON COLUMN USUARIOS.UPDATED_AT     IS 'Este campo contem a data e hora da ultima atualizacao do registro';