-------------------------------------------------------------------------------
-- CREATE DATE - Julho 2026
-- DESCRIPTION - DML de criacao de registros base na tabela MESSAGE_TEXT
-------------------------------------------------------------------------------
MERGE INTO MESSAGE_TEXT target
USING (
    SELECT 'TRC$PACKAGE_STARTED'     AS MESSAGE_KEY
          ,'TRACE'                   AS MESSAGE_TYPE
          ,'Package Started'         AS MESSAGE_TEXT
      FROM DUAL
     UNION ALL
    SELECT 'TRC$PACKAGE_COMPLETED'   AS MESSAGE_KEY
          ,'TRACE'                   AS MESSAGE_TYPE
          ,'Package Completed'       AS MESSAGE_TEXT
      FROM DUAL
     UNION ALL
    SELECT 'ERR$PACKAGE_ERROR'       AS MESSAGE_KEY
          ,'ERROR'                   AS MESSAGE_TYPE
          ,'Package Error'           AS MESSAGE_TEXT
      FROM DUAL
     UNION ALL
    SELECT 'ERR$GET_LOG_LEVEL'       AS MESSAGE_KEY
          ,'ERROR'                   AS MESSAGE_TYPE
          ,'Get Log Level Error'     AS MESSAGE_TEXT
      FROM DUAL
     UNION ALL
    SELECT 'ERR$LOG_LEVEL_NOT_FOUND' AS MESSAGE_KEY
          ,'ERROR'                   AS MESSAGE_TYPE
          ,'Log Level Not Found'     AS MESSAGE_TEXT
      FROM DUAL
) source
ON (target.MESSAGE_KEY = source.MESSAGE_KEY)
WHEN MATCHED THEN
    UPDATE SET
        target.MESSAGE_TYPE = source.MESSAGE_TYPE
       ,target.MESSAGE_TEXT = source.MESSAGE_TEXT
WHEN NOT MATCHED THEN
    INSERT (
        MESSAGE_KEY
       ,MESSAGE_TYPE
       ,MESSAGE_TEXT
    )
    VALUES (
        source.MESSAGE_KEY
       ,source.MESSAGE_TYPE
       ,source.MESSAGE_TEXT
    );
