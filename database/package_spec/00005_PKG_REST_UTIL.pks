CREATE OR REPLACE PACKAGE BODY PKG_REST_UTIL AS
   --
   g_program_name               CONSTANT VARCHAR2(32) := 'PKG_REST_UTIL';
   g_status_code_success        CONSTANT NUMBER := 200;
   g_status_code_bad_request    CONSTANT NUMBER := 400;
   g_status_code_internal_error CONSTANT NUMBER := 500;
   --
   ----------------------------------------------------------------------------
   -- make_rest_request
   ----------------------------------------------------------------------------
   FUNCTION make_rest_request(o_error_message     OUT logs.error_message%TYPE
                             ,o_status_code       OUT NUMBER
                             ,o_result_content    OUT CLOB
                             ,i_url            IN     VARCHAR2
                             ,i_http_method    IN     VARCHAR2
                             ,i_body           IN     CLOB
                             ,i_headers        IN     APEX_APPLICATION_GLOBAL.VC_ARR2)
   RETURN BOOLEAN;
   --
END PKG_REST_UTIL;
/