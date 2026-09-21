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
      l_key_upper := upper(rtrim(substrb(i_message_key, 1, 255)));
      l_key_raw   := rtrim(substrb(i_message_key, 1, 255));
      l_txt_1     := rtrim(substrb(i_txt_1, 1, 500));
      l_txt_2     := rtrim(substrb(i_txt_2, 1, 500));
      l_txt_3     := rtrim(substrb(i_txt_3, 1, 500));
      --
      OPEN c_get_message(l_key_raw);
      FETCH c_get_message INTO l_disp_msg;
      --
      IF c_get_message%NOTFOUND
      THEN
         CLOSE c_get_message;
         RETURN substrb(i_message_key, 1, 2000);
      END IF;
      --
      CLOSE c_get_message;
      --
      IF l_txt_1 IS NOT NULL
         AND instr(l_disp_msg, l_sub_str) > 0
      THEN
         l_disp_msg := REPLACE(l_disp_msg, l_sub_str, l_txt_1);
      END IF;
      --
      l_sub_str := '%s2';
      --
      IF l_txt_2 IS NOT NULL
         AND instr(l_disp_msg, l_sub_str) > 0
      THEN
         l_disp_msg := REPLACE(l_disp_msg, l_sub_str, l_txt_2);
      END IF;
      --
      l_sub_str := '%s3';
      --
      IF l_txt_3 IS NOT NULL
         AND instr(l_disp_msg, l_sub_str) > 0
      THEN
         l_disp_msg := REPLACE(l_disp_msg, l_sub_str, l_txt_3);
      END IF;
      --
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
      l_language_id      system_parameters.value%TYPE;
      l_c_lang           languages.id%TYPE;
      l_error_message    VARCHAR2(4000);
      l_custom_exception EXCEPTION;

      CURSOR c_get_primary_language IS
         SELECT value
           FROM system_parameters
          WHERE code = pkg_common_gv.g_primary_language;

      CURSOR c_get_tab_language IS
         SELECT id
           FROM languages
          WHERE id = to_number(l_language_id);

   BEGIN
      OPEN c_get_primary_language;
      FETCH c_get_primary_language INTO l_language_id;
      CLOSE c_get_primary_language;

      OPEN c_get_tab_language;
      FETCH c_get_tab_language INTO l_c_lang;

      IF c_get_tab_language%NOTFOUND
      THEN
         CLOSE c_get_tab_language;
         l_error_message := pkg_common_utils.get_message_text(i_message_key => pkg_common_err.err$invalid_primary_language
                                                             ,i_txt_1       => l_language_id);

         RAISE l_custom_exception;
      END IF;

      CLOSE c_get_tab_language;

      RETURN l_language_id;

   EXCEPTION
      WHEN l_custom_exception
      THEN

         pkg_common_log.handle_logs(i_log_level    => pkg_common_gv.g_log_level_error
                                   ,i_program_name => l_program_name
                                   ,i_code         => l_error_message);

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

         pkg_common_log.handle_logs(i_log_level       => pkg_common_gv.g_log_level_error
                                   ,i_program_name    => l_program_name
                                   ,i_code            => pkg_common_err.err$package_error
                                   ,i_error_backtrace => dbms_utility.format_error_backtrace
                                   ,i_error_stack     => dbms_utility.format_error_stack
                                   ,i_aux_c_1         => SQLERRM);

         RETURN NULL;

   END get_primary_language;
   --
   ----------------------------------------------------------------------------
   -- DESCRIPTION - Function that returns the application user from context
   ----------------------------------------------------------------------------
   FUNCTION get_app_user
   RETURN VARCHAR2 IS
      l_current_user VARCHAR2(256);
      --
      CURSOR c_get_value IS
         SELECT UPPER(
                  NVL(
                     NVL(
                        apex_util.get_session_state('G_USER_ID')
                       ,sys_context('USERENV', 'SESSION_USER')
                     )
                 ,USER))
           FROM dual d;
      --
   BEGIN
      --
      OPEN c_get_value;
      FETCH c_get_value INTO l_current_user;
      CLOSE c_get_value;
      --
      RETURN l_current_user;
      --
   END get_app_user;
   --
   -------------------------------------------------------------------------------
   -- DESCRIPTION - Function that returns the user language from context
   -------------------------------------------------------------------------------
   FUNCTION get_user_language
   RETURN NUMBER IS

      l_language_id      languages.id%TYPE;
      l_code             languages.code%TYPE;
      l_error_message    VARCHAR2(4000);
      l_custom_exception EXCEPTION;

      CURSOR c_get_tab_language IS
         SELECT id
           FROM languages
          WHERE code = l_code;

   BEGIN
/*
      --Check if context for language exists
      IF PKG_COMMON_CONTEXT.IS_CONTEXT_SET(o_error_message  => l_error_message
                                          ,i_attribute_name => pkg_common_gv.g_context_language)
      THEN
         IF NOT
            PKG_COMMON_CONTEXT.GET_CONTEXT(o_error_message  => l_error_message
                                          ,i_attribute_name => pkg_common_gv.g_context_language
                                          ,o_context_value  => l_code)
         THEN
            l_code := NULL;
         END IF;
      END IF;
*/

      IF l_code IS NULL
      THEN
         RAISE l_custom_exception;
      END IF;

      OPEN c_get_tab_language;
      FETCH c_get_tab_language INTO l_language_id;

      IF c_get_tab_language%NOTFOUND
      THEN
         CLOSE c_get_tab_language;
         RAISE l_custom_exception;
      END IF;

      CLOSE c_get_tab_language;

      RETURN l_language_id;

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