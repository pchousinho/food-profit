-------------------------------------------------------------------------------
-- CREATE DATE - Julho 2026
-- DESCRIPTION - DML de criacao de registros base na tabela UNITS
-------------------------------------------------------------------------------
MERGE INTO UNITS target
USING (
    SELECT 1                  AS UNIT_GROUP_ID
          ,'Miligrama'        AS NAME
          ,'mg'               AS SYMBOL
          ,10                 AS DISPLAY_ORDER
          ,0.001              AS BASE_FACTOR
      FROM DUAL
     UNION ALL
    SELECT 1                  AS UNIT_GROUP_ID
          ,'Grama'            AS NAME
          ,'g'                AS SYMBOL
          ,20                 AS DISPLAY_ORDER
          ,1                  AS BASE_FACTOR
      FROM DUAL
     UNION ALL
    SELECT 1                  AS UNIT_GROUP_ID
          ,'Quilograma'       AS NAME
          ,'kg'               AS SYMBOL
          ,30                 AS DISPLAY_ORDER
          ,1000               AS BASE_FACTOR
      FROM DUAL
     UNION ALL
    SELECT 1                  AS UNIT_GROUP_ID
          ,'Tonelada'         AS NAME
          ,'t'                AS SYMBOL
          ,40                 AS DISPLAY_ORDER
          ,1000000            AS BASE_FACTOR
      FROM DUAL
     UNION ALL
    SELECT 2                  AS UNIT_GROUP_ID
          ,'Mililitro'        AS NAME
          ,'ml'               AS SYMBOL
          ,10                 AS DISPLAY_ORDER
          ,1                  AS BASE_FACTOR
      FROM DUAL
     UNION ALL
    SELECT 2                  AS UNIT_GROUP_ID
          ,'Litro'            AS NAME
          ,'l'                AS SYMBOL
          ,20                 AS DISPLAY_ORDER
          ,1000               AS BASE_FACTOR
      FROM DUAL
     UNION ALL
    SELECT 3                  AS UNIT_GROUP_ID
          ,'Unidade'          AS NAME
          ,'un'               AS SYMBOL
          ,10                 AS DISPLAY_ORDER
          ,1                  AS BASE_FACTOR
      FROM DUAL
     UNION ALL
    SELECT 3                  AS UNIT_GROUP_ID
          ,'Rolo'             AS NAME
          ,'rolo'             AS SYMBOL
          ,20                 AS DISPLAY_ORDER
          ,1                  AS BASE_FACTOR
      FROM DUAL
     UNION ALL
    SELECT 3                  AS UNIT_GROUP_ID
          ,'Pacote'           AS NAME
          ,'pct'              AS SYMBOL
          ,30                 AS DISPLAY_ORDER
          ,1                  AS BASE_FACTOR
      FROM DUAL
     UNION ALL
    SELECT 3                  AS UNIT_GROUP_ID
          ,'Caixa'            AS NAME
          ,'cx'               AS SYMBOL
          ,40                 AS DISPLAY_ORDER
          ,1                  AS BASE_FACTOR
      FROM DUAL
     UNION ALL
    SELECT 3                  AS UNIT_GROUP_ID
          ,'Garrafa'          AS NAME
          ,'garrafa'          AS SYMBOL
          ,50                 AS DISPLAY_ORDER
          ,1                  AS BASE_FACTOR
      FROM DUAL
     UNION ALL
    SELECT 3                  AS UNIT_GROUP_ID
          ,'Lata'             AS NAME
          ,'lata'             AS SYMBOL
          ,60                 AS DISPLAY_ORDER
          ,1                  AS BASE_FACTOR
      FROM DUAL
     UNION ALL
    SELECT 3                  AS UNIT_GROUP_ID
          ,'Capsula'          AS NAME
          ,'caps'             AS SYMBOL
          ,70                 AS DISPLAY_ORDER
          ,1                  AS BASE_FACTOR
      FROM DUAL
     UNION ALL
    SELECT 3                  AS UNIT_GROUP_ID
          ,'Envelope'         AS NAME
          ,'env'              AS SYMBOL
          ,80                 AS DISPLAY_ORDER
          ,1                  AS BASE_FACTOR
      FROM DUAL
     UNION ALL
    SELECT 3                  AS UNIT_GROUP_ID
          ,'Sache'            AS NAME
          ,'sache'            AS SYMBOL
          ,90                 AS DISPLAY_ORDER
          ,1                  AS BASE_FACTOR
      FROM DUAL
) source
ON (
    target.UNIT_GROUP_ID = source.UNIT_GROUP_ID
    AND target.SYMBOL = source.SYMBOL
)
WHEN MATCHED THEN
    UPDATE SET
        target.NAME = source.NAME
       ,target.DISPLAY_ORDER = source.DISPLAY_ORDER
       ,target.BASE_FACTOR = source.BASE_FACTOR
WHEN NOT MATCHED THEN
    INSERT (
        ID
       ,UNIT_GROUP_ID
       ,NAME
       ,SYMBOL
       ,DISPLAY_ORDER
       ,BASE_FACTOR
    )
    VALUES (
        SEQ_UNITS.NEXTVAL
       ,source.UNIT_GROUP_ID
       ,source.NAME
       ,source.SYMBOL
       ,source.DISPLAY_ORDER
       ,source.BASE_FACTOR
    );
