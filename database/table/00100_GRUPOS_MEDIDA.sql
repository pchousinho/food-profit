-------------------------------------------------------------------------------
-- CREATE DATE - Junho 2026
-- DESCRIPTION - Create table GRUPOS_MEDIDA
-------------------------------------------------------------------------------
CREATE TABLE GRUPOS_MEDIDA (
    ID              NUMBER          NOT NULL
   ,NOME            VARCHAR2(50)    NOT NULL
   ,DESCRICAO       VARCHAR2(250)
   --
   ,STATUS          VARCHAR2(1)     DEFAULT 'A' NOT NULL
   ,CREATED_BY      VARCHAR2(250)
   ,CREATED_AT      DATE
   ,UPDATED_BY      VARCHAR2(250)
   ,UPDATED_AT      DATE
);
--
ALTER TABLE GRUPOS_MEDIDA ADD CONSTRAINT PK_GRUPOS_MEDIDA PRIMARY KEY (ID);
ALTER TABLE GRUPOS_MEDIDA ADD CONSTRAINT UK01_GRUPOS_MEDIDA UNIQUE (NOME);
--
ALTER TABLE GRUPOS_MEDIDA ADD CONSTRAINT CHK01_GRUPOS_MEDIDA CHECK (STATUS IN ('A','I'));
--
COMMENT ON TABLE GRUPOS_MEDIDA                IS 'Esta tabela contém a lista de grupos de medida utilizados para classificar registros no sistema';
--
COMMENT ON COLUMN GRUPOS_MEDIDA.ID            IS 'Este campo contém a chave primária da tabela';
COMMENT ON COLUMN GRUPOS_MEDIDA.NOME          IS 'Este campo contém o nome do grupo de medida';
COMMENT ON COLUMN GRUPOS_MEDIDA.DESCRICAO     IS 'Este campo contém a descrição do grupo de medida';
COMMENT ON COLUMN GRUPOS_MEDIDA.STATUS        IS 'Este campo contém o status atual (A - Ativo, I - Inativo)';
COMMENT ON COLUMN GRUPOS_MEDIDA.CREATED_BY    IS 'Este campo contém o usuário que criou o registro';
COMMENT ON COLUMN GRUPOS_MEDIDA.CREATED_AT    IS 'Este campo contém a data e hora de criação do registro';
COMMENT ON COLUMN GRUPOS_MEDIDA.UPDATED_BY    IS 'Este campo contém o usuário que realizou a última atualização do registro';
COMMENT ON COLUMN GRUPOS_MEDIDA.UPDATED_AT    IS 'Este campo contém a data e hora da última atualização do registro';