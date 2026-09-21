CREATE OR REPLACE PACKAGE BODY PKG_COMMON_CONTEXT AS
   ----------------------------------------------------------------------------
   -- DESCRIPTION - Checks whether an application context attribute is set for
   --               the current session.
   ----------------------------------------------------------------------------
   FUNCTION is_context_set(o_error_message     OUT logs.error_backtrace%TYPE
                          ,i_attribute_name IN     VARCHAR2)
   RETURN BOOLEAN IS
      l_attribute_value VARCHAR2(254);
   BEGIN
      l_attribute_value := SYS_CONTEXT(PKG_COMMON_GV.g_context_namespace, UPPER(i_attribute_name));
      --
      IF l_attribute_value IS NOT NULL
      THEN
         RETURN TRUE;
      END IF;
      --
      RETURN FALSE;
      --
   EXCEPTION
      WHEN OTHERS
      THEN
         o_error_message := SQLERRM;
         RETURN FALSE;
   END is_context_set;

   ----------------------------------------------------------------------------
   -- DESCRIPTION - Retrieves the value of a specific context attribute from
   --               the session using SYS_CONTEXT. Logs the operation and
   --               handles errors.
   ----------------------------------------------------------------------------
   FUNCTION get_context(o_error_message     OUT logs.error_backtrace%TYPE
                       ,o_context_value     OUT VARCHAR2
                       ,i_attribute_name IN     VARCHAR2)
   RETURN BOOLEAN IS
      l_custom_exception EXCEPTION;
   BEGIN
      o_context_value := SYS_CONTEXT(PKG_COMMON_GV.g_context_namespace, UPPER(i_attribute_name));
      --
      IF o_context_value IS NULL
      THEN
         RAISE l_custom_exception;
      END IF;
      --
      RETURN TRUE;
      --
   EXCEPTION
      WHEN l_custom_exception
      THEN
         o_error_message := pkg_common_utils.get_message_text(i_message_key => pkg_common_err.err$context_not_set, i_txt_1 => i_attribute_name);
         RETURN FALSE;
      WHEN OTHERS
      THEN
         o_error_message := SQLERRM;
         RETURN FALSE;
   END get_context;

   ----------------------------------------------------------------------------
   -- DESCRIPTION - Initializes the session context by setting standard
   --               attributes such as APP_USER, APP_LANGUAGE, APP_SESSION,
   --               etc., using values from the APEX session.
   ----------------------------------------------------------------------------
   PROCEDURE init_context(o_error_message    OUT logs.error_backtrace%TYPE)
   IS
      l_program_name          VARCHAR2(100) := g_program_name || '.init_context';
      l_language_code         LANGUAGES.code%TYPE;

      CURSOR c_get_user_language_code IS
         SELECT l.code
           FROM user_preferences up
               ,languages       l
          WHERE UPPER(up.user_id) = UPPER(NVL(V('APP_USER')
                                             ,SYS_CONTEXT('USERENV'
                                                         ,'CURRENT_USER')))
            AND up.language_id = l.id;

   BEGIN

      PKG_COMMON_LOG.HANDLE_LOGS(i_log_level    => pkg_common_gv.g_log_level_trace
                                ,i_program_name => l_program_name
                                ,i_code         => 'TRC$PACKAGE_STARTED');

      DBMS_SESSION.SET_CONTEXT(namespace => PKG_COMMON_GV.g_context_namespace
                              ,attribute => PKG_COMMON_GV.g_context_app_user
                              ,value     => UPPER(NVL(V('APP_USER')
                                                     ,SYS_CONTEXT('USERENV'
                                                                 ,'CURRENT_USER'))));

      DBMS_SESSION.SET_CONTEXT(namespace => PKG_COMMON_GV.g_context_namespace
                              ,attribute => PKG_COMMON_GV.g_context_session
                              ,value     => NVL(V('APP_SESSION')
                                               ,SYS_CONTEXT('USERENV'
                                                           ,'SESSIONID')));

      -- Get the language defined for the user logged
      OPEN  c_get_user_language_code;
      FETCH c_get_user_language_code INTO l_language_code;
      CLOSE c_get_user_language_code;

      IF l_language_code IS NOT NULL THEN
         --Set the user preference language
         DBMS_SESSION.SET_CONTEXT(namespace => PKG_COMMON_GV.g_context_namespace
                                 ,attribute => PKG_COMMON_GV.g_context_language
                                 ,value     => UPPER(l_language_code));

         APEX_UTIL.SET_PREFERENCE(p_preference => 'FSP_LANGUAGE_PREFERENCE'
                                 ,p_value      => LOWER(l_language_code));
      ELSE
         --Set the system primary language
         DBMS_SESSION.SET_CONTEXT(namespace => PKG_COMMON_GV.g_context_namespace
                                 ,attribute => PKG_COMMON_GV.g_context_language
                                 ,value     => UPPER(NVL(V('BROWSER_LANGUAGE')
                                                          ,PKG_COMMON_GV.g_primary_language)));

         APEX_UTIL.SET_PREFERENCE(p_preference => 'FSP_LANGUAGE_PREFERENCE'
                                 ,p_value      => LOWER(NVL(V('BROWSER_LANGUAGE')
                                                             ,PKG_COMMON_GV.g_primary_language)));
      END IF;

      PKG_COMMON_LOG.HANDLE_LOGS(i_log_level    => PKG_COMMON_GV.g_log_level_trace
                                ,i_program_name => l_program_name
                                ,i_code         => 'TRC$PACKAGE_COMPLETED');

   EXCEPTION
      WHEN OTHERS
      THEN
         IF c_get_user_language_code%ISOPEN
         THEN
            CLOSE c_get_user_language_code;
         END IF;

         o_error_message := PKG_COMMON_UTILS.get_message_text(i_message_key   => 'ERR$PACKAGE_ERROR_MSG'
                                                             ,i_txt_1         => l_program_name
                                                             ,i_txt_2         => SQLERRM);

         PKG_COMMON_LOG.HANDLE_LOGS(i_log_level       => PKG_COMMON_GV.g_log_level_error
                                   ,i_program_name    => l_program_name
                                   ,i_code            => 'ERR$PACKAGE_ERROR'
                                   ,i_error_backtrace => dbms_utility.format_error_backtrace
                                   ,i_error_stack     => dbms_utility.format_error_stack
                                   ,i_aux_c_1         => SQLERRM);

   END init_context;

END PKG_COMMON_CONTEXT;
/