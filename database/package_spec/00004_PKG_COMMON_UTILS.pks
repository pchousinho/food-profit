CREATE OR REPLACE PACKAGE BODY PKG_COMMON_UTILS AS
   --
   g_program_name CONSTANT VARCHAR2(32) := 'PKG_COMMON';
   --
   ----------------------------------------------------------------------------
   -- get_message_text
   ----------------------------------------------------------------------------
   FUNCTION get_message_text(i_message_key   IN message_text.message_key%TYPE
                            ,i_txt_1         IN VARCHAR2 DEFAULT NULL
                            ,i_txt_2         IN VARCHAR2 DEFAULT NULL
                            ,i_txt_3         IN VARCHAR2 DEFAULT NULL)
   RETURN VARCHAR2;
   --
END PKG_COMMON_UTILS;
/