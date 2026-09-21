CREATE OR REPLACE PACKAGE PKG_REST_UTIL AS
   --
   g_program_name               CONSTANT VARCHAR2(32) := 'PKG_REST_UTIL';
   --
   ----------------------------------------------------------------------------
   -- make_rest_request
   ----------------------------------------------------------------------------
   FUNCTION make_rest_request(o_error_message     OUT logs.error_backtrace%TYPE
                             ,o_status_code       OUT NUMBER
                             ,o_result_content    OUT CLOB
                             ,i_debug_mode     IN     BOOLEAN DEFAULT FALSE
                             ,i_url            IN     VARCHAR2
                             ,i_http_method    IN     VARCHAR2
                             ,i_body           IN     CLOB
                             ,i_headers        IN     APEX_APPLICATION_GLOBAL.VC_ARR2)
   RETURN BOOLEAN;
   --
END PKG_REST_UTIL;
/