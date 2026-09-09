-------------------------------------------------------------------------------
-- CREATE DATE - Julho 2026
-- DESCRIPTION - DML de criacao de registros base na tabela UNIT_GROUPS
-------------------------------------------------------------------------------
INSERT INTO UNIT_GROUPS (id, name, description) VALUES (SEQ_UNIT_GROUPS.nextval, 'MASSA',       'Unidades de massa');
INSERT INTO UNIT_GROUPS (id, name, description) VALUES (SEQ_UNIT_GROUPS.nextval, 'VOLUME',      'Unidades de volume');
INSERT INTO UNIT_GROUPS (id, name, description) VALUES (SEQ_UNIT_GROUPS.nextval, 'CONTAGEM',    'Itens contaveis');
INSERT INTO UNIT_GROUPS (id, name, description) VALUES (SEQ_UNIT_GROUPS.nextval, 'COMPRIMENTO', 'Unidades de comprimento');
INSERT INTO UNIT_GROUPS (id, name, description) VALUES (SEQ_UNIT_GROUPS.nextval, 'AREA',        'Unidades de area');
/