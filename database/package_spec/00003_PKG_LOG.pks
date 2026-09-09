CREATE OR REPLACE PACKAGE PKG_LOG AS
   --
   g_program_name CONSTANT VARCHAR2(32) := 'PKG_LOG';
   --
   ----------------------------------------------------------------------------
   -- get_log_level
   ----------------------------------------------------------------------------
   FUNCTION get_log_level(o_error_message OUT logs.error_message%TYPE
                         ,o_log_level     OUT NUMBER)
   RETURN BOOLEAN;
   --
   ----------------------------------------------------------------------------
   -- get_app_user
   ----------------------------------------------------------------------------
   FUNCTION get_app_user
   RETURN VARCHAR2;
   --
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
                        ,i_log_user        IN logs.log_user%TYPE         DEFAULT PKG_LOG.get_app_user);

END PKG_LOG;
/