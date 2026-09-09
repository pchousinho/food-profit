CREATE OR REPLACE PACKAGE BODY PKG_COMMON_UTILS AS

   ----------------------------------------------------------------------------
   -- DESCRIPTION - Function that returns the message text for a given message
   --               key and optional parameters.
   ----------------------------------------------------------------------------
   FUNCTION get_message_text(i_message_key   IN message_text.message_key%TYPE
                            ,i_txt_1         IN VARCHAR2 DEFAULT NULL
                            ,i_txt_2         IN VARCHAR2 DEFAULT NULL
                            ,i_txt_3         IN VARCHAR2 DEFAULT NULL)
   RETURN VARCHAR2 IS
      --
      l_program_name CONSTANT VARCHAR2(50) := g_program_name || '.get_message_text';
      --
      l_key_upper     VARCHAR2(255);
      l_key_raw       VARCHAR2(255);
      l_sub_str       VARCHAR2(4000) := '%s1';
      l_txt_1         VARCHAR2(4000);
      l_txt_2         VARCHAR2(4000);
      l_txt_3         VARCHAR2(4000);
      l_disp_msg      VARCHAR2(4000);
      --
      CURSOR c_get_message(l_message_key message_text.message_key%TYPE) IS
         SELECT v.message_text
           FROM message_text_tl_v v
          WHERE v.message_key = l_message_key;
      --
   BEGIN
      --
      l_key_upper := upper(rtrim(substrb(i_key, 1, 255)));
      l_key_raw   := rtrim(substrb(i_key, 1, 255));
      l_txt_1     := rtrim(substrb(i_txt_1, 1, 500));
      l_txt_2     := rtrim(substrb(i_txt_2, 1, 500));
      l_txt_3     := rtrim(substrb(i_txt_3, 1, 500));

      OPEN c_get_message(l_key_raw);
      FETCH c_get_message INTO l_disp_msg;

      IF c_get_message%NOTFOUND
      THEN
         CLOSE c_get_message;
         RETURN substrb(i_key, 1, 2000);
      END IF;

      CLOSE c_get_message;

      IF l_txt_1 IS NOT NULL AND instr(l_disp_msg, l_sub_str) > 0
      THEN
         l_disp_msg := REPLACE(l_disp_msg, l_sub_str, l_txt_1);
      END IF;
      l_sub_str := '%s2';

      IF l_txt_2 IS NOT NULL AND instr(l_disp_msg, l_sub_str) > 0
      THEN
         l_disp_msg := REPLACE(l_disp_msg, l_sub_str, l_txt_2);
      END IF;
      l_sub_str := '%s3';

      IF l_txt_3 IS NOT NULL AND instr(l_disp_msg, l_sub_str) > 0
      THEN
         l_disp_msg := REPLACE(l_disp_msg, l_sub_str, l_txt_3);
      END IF;

      RETURN l_disp_msg;
      --
   EXCEPTION
      WHEN OTHERS THEN
         RETURN 'Unhandled error in ' || l_program_name || ': ' || SQLERRM;
   END get_message_text;
   --
   ----------------------------------------------------------------------------
   -- DESCRIPTION - Function that returns the primary language from system
   --               system parameters
   ----------------------------------------------------------------------------
   FUNCTION get_primary_language
   RETURN NUMBER IS
      l_program_name     VARCHAR2(100) := g_program_name || '.get_primary_language';
      --
      l_language         system_parameters.value%TYPE;
      l_c_lang           languages.id%TYPE;
      l_error_message    VARCHAR2(4000);
      l_custom_exception EXCEPTION;

      CURSOR c_get_primary_language IS
         SELECT value
           FROM system_parameters
          WHERE parameter = pkg_common_gv.g_primary_language;

      CURSOR c_get_tab_language IS
         SELECT id
           FROM languages
          WHERE id = to_number(l_language);

   BEGIN
      OPEN c_get_primary_language;
      FETCH c_get_primary_language INTO l_language;
      CLOSE c_get_primary_language;

      OPEN c_get_tab_language;
      FETCH c_get_tab_language INTO l_c_lang;

      IF c_get_tab_language%NOTFOUND
      THEN
         CLOSE c_get_tab_language;
         l_error_message := APO_RMS_E_COMMON_LOG.GET_MESSAGE_TEXT(i_key   => 'ERR$LANG_NOT_SUPPORTED'
                                                                 ,i_txt_1 => l_language);

         RAISE l_custom_exception;
      END IF;

      CLOSE c_get_tab_language;

      RETURN l_language;

   EXCEPTION
      WHEN l_custom_exception
      THEN

         APO_RMS_E_COMMON_LOG.HANDLE_LOGS(i_log_level    => APO_RMS_E_COMMON_GV.G_log_level_error
                                         ,i_program_name => l_program_name
                                         ,i_error_key    => l_error_message);

         RETURN NULL;

     WHEN OTHERS
     THEN
         IF c_get_primary_language%ISOPEN
         THEN
            CLOSE c_get_primary_language;
         END IF;

         IF c_get_tab_language%ISOPEN
         THEN
            CLOSE c_get_tab_language;
         END IF;

         APO_RMS_E_COMMON_LOG.HANDLE_LOGS(i_log_level      => APO_RMS_E_COMMON_GV.G_log_level_error
                                         ,i_program_name    => l_program_name
                                         ,i_error_key       => 'ERR$PACKAGE_ERROR'
                                         ,i_error_backtrace => dbms_utility.format_error_backtrace
                                         ,i_error_stack     => dbms_utility.format_error_stack
                                         ,i_aux_1           => SQLERRM);

         RETURN NULL;

   END get_primary_language;

   -------------------------------------------------------------------------------
   -- DESCRIPTION - Function that returns the user language from context
   -------------------------------------------------------------------------------
   FUNCTION get_user_language
   RETURN NUMBER IS

      l_language         APO_RMS_E_LANG.LANG_ID%TYPE;
      l_iso_code         APO_RMS_E_LANG.ISO_CODE%TYPE;
      l_error_message    VARCHAR2(4000);
      l_custom_exception EXCEPTION;

      CURSOR c_get_tab_language IS
         SELECT lang_id
           FROM APO_RMS_E_LANG
          WHERE iso_code = l_iso_code;

   BEGIN
      --Check if context for language exists
      IF APO_RMS_E_COMMON_CONTEXT.IS_CONTEXT_SET(o_error_message  => l_error_message
                                                ,i_attribute_name => APO_RMS_E_COMMON_GV.G_context_language)
      THEN
         IF NOT
            APO_RMS_E_COMMON_CONTEXT.GET_CONTEXT(o_error_message  => l_error_message
                                                ,i_attribute_name => APO_RMS_E_COMMON_GV.G_context_language
                                                ,o_context_value  => l_iso_code)
         THEN
            l_iso_code := NULL;
         END IF;
      END IF;

      IF l_iso_code IS NULL
      THEN
         RAISE l_custom_exception;
      END IF;

      OPEN c_get_tab_language;
      FETCH c_get_tab_language INTO l_language;

      IF c_get_tab_language%NOTFOUND
      THEN
         CLOSE c_get_tab_language;
         RAISE l_custom_exception;
      END IF;

      CLOSE c_get_tab_language;

      RETURN l_language;

   EXCEPTION
      WHEN l_custom_exception
      THEN
         IF c_get_tab_language%ISOPEN
         THEN
           CLOSE c_get_tab_language;
         END IF;

         RETURN NULL;

      WHEN OTHERS
      THEN
         IF c_get_tab_language%ISOPEN
         THEN
           CLOSE c_get_tab_language;
         END IF;

         RETURN NULL;

   END get_user_language;
   --
END PKG_COMMON_UTILS;
/