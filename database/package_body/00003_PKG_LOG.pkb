CREATE OR REPLACE PACKAGE BODY PKG_LOG AS
   ----------------------------------------------------------------------------
   -- get_log_level
   ----------------------------------------------------------------------------
   FUNCTION get_log_level(o_error_message OUT logs.error_message%TYPE
                         ,o_log_level     OUT NUMBER)
   RETURN BOOLEAN IS
      CURSOR c_get_log_level IS
         SELECT value_1
           FROM system_parameters
          WHERE parameter = pkg_common_gv.g_log_level_parameter;
      --
   BEGIN
      OPEN c_get_log_level;
      FETCH c_get_log_level INTO o_log_level;
      CLOSE c_get_log_level;
      --
      RETURN TRUE;
      --
   EXCEPTION
      WHEN OTHERS THEN
         --
         o_error_message := pkg_log.get_message_text(i_key => apo_rms_e_common_err.err$get_log_level);
         --
         RETURN FALSE;
         --
   END get_log_level;

   ----------------------------------------------------------------------------
   -- get_app_user
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

   ----------------------------------------------------------------------------
   -- insert_log_autonomous
   ----------------------------------------------------------------------------
   FUNCTION insert_log_autonomous(i_log IN logs%ROWTYPE)
   RETURN BOOLEAN IS
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      --
      INSERT INTO logs VALUES i_log;
      --
      COMMIT;
      --
      RETURN TRUE;
      --
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         --
         DBMS_OUTPUT.PUT_LINE('Error in insert_log_autonomous: ' || SQLERRM);
         --
         RETURN FALSE;
         --
   END insert_log_autonomous;

   ----------------------------------------------------------------------------
   -- handle_logs
   ----------------------------------------------------------------------------
   PROCEDURE handle_logs(i_log_level       IN logs.log_level%TYPE
                        ,i_program_name    IN logs.program_name%TYPE
                        ,i_code            IN logs.code%TYPE
                        ,i_aux_c_1         IN logs.aux_c_1%TYPE          DEFAULT NULL
                        ,i_aux_c_2         IN logs.aux_c_2%TYPE          DEFAULT NULL
                        ,i_aux_c_3         IN logs.aux_c_3%TYPE          DEFAULT NULL
                        ,i_aux_n_1         IN logs.aux_n_1%TYPE          DEFAULT NULL
                        ,i_aux_n_2         IN logs.aux_n_2%TYPE          DEFAULT NULL
                        ,i_aux_n_3         IN logs.aux_n_3%TYPE          DEFAULT NULL
                        ,i_aux_clob_1      IN logs.aux_clob_1%TYPE       DEFAULT NULL
                        ,i_aux_clob_2      IN logs.aux_clob_2%TYPE       DEFAULT NULL
                        ,i_aux_blob_1      IN logs.aux_blob_1%TYPE       DEFAULT NULL
                        ,i_aux_blob_2      IN logs.aux_blob_2%TYPE       DEFAULT NULL
                        ,i_error_backtrace IN logs.error_backtrace%TYPE  DEFAULT NULL
                        ,i_error_stack     IN logs.error_stack%TYPE      DEFAULT NULL
                        ,i_log_user        IN logs.log_user%TYPE         DEFAULT PKG_LOG.get_app_user)
   IS
      l_log              logs%rowtype;
      l_custom_exception EXCEPTION;
   BEGIN
      l_log.log_level       := i_log_level;
      l_log.program_name    := i_program_name;
      l_log.code            := i_code;
      l_log.error_message   := pkg_log.get_message_text(
                                  i_key   => i_code
                                 ,i_txt_1 => NVL(i_aux_c_1, i_aux_n_1)
                                 ,i_txt_2 => NVL(i_aux_c_2, i_aux_n_2)
                                 ,i_txt_3 => NVL(i_aux_c_3, i_aux_n_3)
                               );
      --
      l_log.error_backtrace := i_error_backtrace;
      l_log.error_stack     := i_error_stack;
      l_log.log_user        := i_log_user;
      --
      l_log.aux_c_1         := i_aux_c_1;
      l_log.aux_c_2         := i_aux_c_2;
      l_log.aux_c_3         := i_aux_c_3;
      l_log.aux_n_1         := i_aux_n_1;
      l_log.aux_n_2         := i_aux_n_2;
      l_log.aux_n_3         := i_aux_n_3;
      l_log.aux_clob_1      := i_aux_clob_1;
      l_log.aux_clob_2      := i_aux_clob_2;
      l_log.aux_blob_1      := i_aux_blob_1;
      l_log.aux_blob_2      := i_aux_blob_2;
      --
      IF NOT insert_log_autonomous(i_log => l_log)
      THEN
         RAISE l_custom_exception;
      END IF;
      --
   EXCEPTION
      WHEN l_custom_exception
      THEN
         NULL; -- Do nothing, as we cannot log the error
      WHEN OTHERS
      THEN
         DBMS_OUTPUT.PUT_LINE('Error in handle_logs: ' || SQLERRM);
   END handle_logs;

END PKG_LOG;
/