CREATE OR REPLACE PACKAGE PKG_COMMON_UTILS AS
   --
   g_program_name CONSTANT VARCHAR2(32) := 'PKG_COMMON_UTILS';
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
   ----------------------------------------------------------------------------
   -- DESCRIPTION - Function that returns the primary language from system
   --               system parameters
   ----------------------------------------------------------------------------
   FUNCTION get_primary_language
   RETURN NUMBER;
   --
   ----------------------------------------------------------------------------
   -- DESCRIPTION - Function that returns the user language from context
   ----------------------------------------------------------------------------
   FUNCTION get_app_user
   RETURN VARCHAR2;
   --
   -------------------------------------------------------------------------------
   -- DESCRIPTION - Function that returns the user language from context
   -------------------------------------------------------------------------------
   FUNCTION get_user_language
   RETURN NUMBER;
   --
END PKG_COMMON_UTILS;
/