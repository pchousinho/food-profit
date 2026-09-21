CREATE OR REPLACE PACKAGE BODY PKG_REST_UTIL AS

   ----------------------------------------------------------------------------
   -- DESCRIPTION - Function that performs a REST API request using the given
   --               URL, HTTP method, request body, and headers.
   ----------------------------------------------------------------------------
   FUNCTION make_rest_request(o_error_message     OUT logs.error_backtrace%TYPE
                             ,o_status_code       OUT NUMBER
                             ,o_result_content    OUT CLOB
                             ,i_debug_mode     IN     BOOLEAN DEFAULT FALSE
                             ,i_url            IN     VARCHAR2
                             ,i_http_method    IN     VARCHAR2
                             ,i_body           IN     CLOB
                             ,i_headers        IN     APEX_APPLICATION_GLOBAL.VC_ARR2)
   RETURN BOOLEAN IS
      l_response         CLOB;
      l_custom_exception EXCEPTION;
   BEGIN
      --
      IF i_debug_mode
      THEN
         dbms_output.put_line('URL: ' || i_url);
         dbms_output.put_line('HTTP Method: ' || i_http_method);
         dbms_output.put_line('Request Body: ' || dbms_lob.substr(i_body, 32000, 1));
      END IF;
      --
      -- Validate input parameters
      IF i_url IS NULL
      THEN
         o_error_message := pkg_common_utils.get_message_text(i_message_key => pkg_common_err.err$invalid_parameter, i_txt_1 => 'i_url');
         RAISE l_custom_exception;
      END IF;
      --
      IF i_http_method IS NULL
      THEN
         o_error_message := pkg_common_utils.get_message_text(i_message_key => pkg_common_err.err$invalid_parameter, i_txt_1 => 'i_http_method');
         RAISE l_custom_exception;
      END IF;
      --
      -- Set request headers
      IF i_headers IS NOT NULL
      THEN
         FOR i IN 1 .. i_headers.count
         LOOP
            apex_web_service.g_request_headers(i).name := substr(i_headers(i), 1, instr(i_headers(i), ':') - 1);
            apex_web_service.g_request_headers(i).value := substr(i_headers(i), instr(i_headers(i), ':') + 1);
         END LOOP;
      END IF;
      --
      -- Make REST request
      l_response := APEX_WEB_SERVICE.MAKE_REST_REQUEST(
         p_url         => i_url
        ,p_http_method => i_http_method
        ,p_body        => i_body
      );
      --
      IF i_debug_mode
      THEN
         dbms_output.put_line('status_code:' || apex_web_service.g_status_code);
         dbms_output.put_line('Response:' || dbms_lob.substr(l_response, 32000, 1));
      END IF;
      --
      -- Result
      o_status_code := apex_web_service.g_status_code;
      o_result_content := l_response;
      --
      RETURN TRUE;
      --
   EXCEPTION
      WHEN l_custom_exception
      THEN
         o_error_message := pkg_common_utils.get_message_text(i_message_key => pkg_common_err.err$make_rest_request);
         o_status_code := NVL(apex_web_service.g_status_code, PKG_COMMON_GV.g_status_code_bad_request);
         RETURN FALSE;
      WHEN OTHERS
      THEN
         o_error_message := pkg_common_utils.get_message_text(i_message_key => pkg_common_err.err$make_rest_request);
         o_status_code := NVL(apex_web_service.g_status_code, PKG_COMMON_GV.g_status_code_internal_error);
         RETURN FALSE;
   END make_rest_request;

END PKG_REST_UTIL;
/