-------------------------------------------------------------------------------
-- CREATE DATE - Junho 2026
-- DESCRIPTION - Create table UNIDADES_MEDIDA
-------------------------------------------------------------------------------
CREATE TABLE UNIDADES_MEDIDA (
    ID                  NUMBER          NOT NULL
   ,GRUPO_MEDIDA_ID     NUMBER          NOT NULL
   ,NOME                VARCHAR2(50)    NOT NULL
   ,SIGLA               VARCHAR2(10)    NOT NULL
   ,ORDEM_EXIBICAO      NUMBER(3)       DEFAULT 0 NOT NULL
   ,FATOR_BASE          NUMBER(18,6)    NOT NULL
   --
   ,STATUS              VARCHAR2(1)     DEFAULT 'A' NOT NULL
   ,CREATED_BY          VARCHAR2(250)
   ,CREATED_AT          DATE
   ,UPDATED_BY          VARCHAR2(250)
   ,UPDATED_AT          DATE
);
--
ALTER TABLE UNIDADES_MEDIDA ADD CONSTRAINT PK_UNIDADES_MEDIDA PRIMARY KEY (ID);
ALTER TABLE UNIDADES_MEDIDA ADD CONSTRAINT UK01_UNIDADES_MEDIDA UNIQUE (NOME);
--
ALTER TABLE UNIDADES_MEDIDA ADD CONSTRAINT CHK01_UNIDADES_MEDIDA CHECK (STATUS IN ('A','I'));
--
COMMENT ON TABLE UNIDADES_MEDIDA                 IS 'Esta tabela contém a lista de unidades de medida utilizados para classificar registros no sistema';
--
COMMENT ON COLUMN UNIDADES_MEDIDA.ID             IS 'Este campo contém a chave primária da tabela';
COMMENT ON COLUMN UNIDADES_MEDIDA.NOME           IS 'Este campo contém o nome da unidade de medida';
COMMENT ON COLUMN UNIDADES_MEDIDA.SIGLA          IS 'Este campo contém a sigla da unidade de medida';
COMMENT ON COLUMN UNIDADES_MEDIDA.ORDEM_EXIBICAO IS 'Este campo contém a ordem de exibição das unidades de medida';
COMMENT ON COLUMN UNIDADES_MEDIDA.FATOR_BASE     IS 'Este campo contém o fator de conversão para a unidade de medida';
COMMENT ON COLUMN UNIDADES_MEDIDA.STATUS         IS 'Este campo contém o status atual (A - Ativo, I - Inativo)';
COMMENT ON COLUMN UNIDADES_MEDIDA.CREATED_BY     IS 'Este campo contém o usuário que criou o registro';
COMMENT ON COLUMN UNIDADES_MEDIDA.CREATED_AT     IS 'Este campo contém a data e hora de criação do registro';
COMMENT ON COLUMN UNIDADES_MEDIDA.UPDATED_BY     IS 'Este campo contém o usuário que realizou a última atualização do registro';
COMMENT ON COLUMN UNIDADES_MEDIDA.UPDATED_AT     IS 'Este campo contém a data e hora da última atualização do registro';