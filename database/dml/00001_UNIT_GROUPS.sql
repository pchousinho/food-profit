-------------------------------------------------------------------------------
-- CREATE DATE - Julho 2026
-- DESCRIPTION - DML de criacao de registros base na tabela UNIT_GROUPS
-------------------------------------------------------------------------------
MERGE INTO UNIT_GROUPS target
USING (
    SELECT 'MASSA'                   AS NAME
          ,'Unidades de massa'       AS DESCRIPTION
      FROM DUAL
     UNION ALL
    SELECT 'VOLUME'                  AS NAME
          ,'Unidades de volume'      AS DESCRIPTION
      FROM DUAL
    UNION ALL
    SELECT 'CONTAGEM'                AS NAME
          ,'Itens contaveis'         AS DESCRIPTION
      FROM DUAL
     UNION ALL
    SELECT 'COMPRIMENTO'             AS NAME
          ,'Unidades de comprimento' AS DESCRIPTION
      FROM DUAL
    UNION ALL
    SELECT 'AREA'                    AS NAME
          ,'Unidades de area'        AS DESCRIPTION
      FROM DUAL
) source
ON (target.NAME = source.NAME)
WHEN MATCHED THEN
    UPDATE SET
        target.DESCRIPTION = source.DESCRIPTION
WHEN NOT MATCHED THEN
    INSERT (
        ID
       ,NAME
       ,DESCRIPTION
    )
    VALUES (
        SEQ_UNIT_GROUPS.NEXTVAL
       ,source.NAME
       ,source.DESCRIPTION
    );