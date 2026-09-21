CREATE OR REPLACE PACKAGE PKG_COMMON_GV AS
   ------------------------------------------------------------------------------
   -- Context Variables
   ------------------------------------------------------------------------------
   g_context_namespace     CONSTANT VARCHAR2(32) := 'CUSTOM_CTX';
   g_context_app_user      CONSTANT VARCHAR2(32) := 'APP_USER';
   g_context_session       CONSTANT VARCHAR2(32) := 'APP_SESSION';
   g_context_language      CONSTANT VARCHAR2(32) := 'APP_LANGUAGE';
   --
   ------------------------------------------------------------------------------
   -- Systems log levels
   ------------------------------------------------------------------------------
   g_log_level_parameter   CONSTANT VARCHAR2(10) := 'LOG_LEVEL';
   g_log_level_error       CONSTANT NUMBER(1) := 0;
   g_log_level_info        CONSTANT NUMBER(1) := 1;
   g_log_level_debug       CONSTANT NUMBER(1) := 2;
   g_log_level_trace       CONSTANT NUMBER(1) := 3;
   --
   ------------------------------------------------------------------------------
   -- Language
   ------------------------------------------------------------------------------
   g_primary_language      CONSTANT VARCHAR2(10) := 'en';
   --
   ------------------------------------------------------------------------------
   -- HTTP Status Codes
   ------------------------------------------------------------------------------
   g_status_code_success        CONSTANT NUMBER := 200;
   g_status_code_created        CONSTANT NUMBER := 201;
   g_status_code_no_content     CONSTANT NUMBER := 204;
   g_status_code_bad_request    CONSTANT NUMBER := 400;
   g_status_code_unauthorized   CONSTANT NUMBER := 401;
   g_status_code_not_found      CONSTANT NUMBER := 404;
   g_status_code_internal_error CONSTANT NUMBER := 500;
   --
END PKG_COMMON_GV;
/