CREATE OR REPLACE VIEW MESSAGE_TEXT_TL_V AS
SELECT b.message_type,
       b.message_key,
       CASE
         WHEN tl.lang_id IS NOT NULL
         THEN
           tl.message_text
         ELSE
           b.message_text
       END message_text
  FROM message_text    b
      ,message_text_tl tl
 WHERE 1 = 1
   AND b.message_key = tl.message_key(+)
   AND tl.lang_id(+) = NVL(PKG_COMMON_UTILS.GET_USER_LANGUAGE(), PKG_COMMON_UTILS.GET_PRIMARY_LANGUAGE());

COMMENT ON COLUMN MESSAGE_TEXT_TL_V.MESSAGE_KEY    IS 'Contains a key from message_text.message_key';
COMMENT ON COLUMN MESSAGE_TEXT_TL_V.MESSAGE_TEXT   IS 'Contains the actual text of the message.';
COMMENT ON COLUMN MESSAGE_TEXT_TL_V.ERROR_TEXT     IS 'Contains the actual text of the message.';
