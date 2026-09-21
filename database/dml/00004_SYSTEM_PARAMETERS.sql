-------------------------------------------------------------------------------
-- CREATE DATE - Julho 2026
-- DESCRIPTION - DML de criacao de registros base na tabela SYSTEM_PARAMETERS
-------------------------------------------------------------------------------
MERGE INTO SYSTEM_PARAMETERS target
USING (
    SELECT 'LOG_LEVEL'           AS CODE
          ,'Log Level'           AS DESCRIPTION
          ,'0'                   AS VALUE
      FROM DUAL
) source
ON (target.CODE = source.CODE)
WHEN MATCHED THEN
    UPDATE SET
        target.DESCRIPTION = source.DESCRIPTION
       ,target.VALUE = source.VALUE
WHEN NOT MATCHED THEN
    INSERT (
        CODE
       ,DESCRIPTION
       ,VALUE
    )
    VALUES (
        source.CODE
       ,source.DESCRIPTION
       ,source.VALUE
    );
