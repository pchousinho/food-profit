CREATE OR REPLACE PACKAGE PKG_COMMON_GV AS
   -- systems log levels
   g_log_level_parameter   CONSTANT VARCHAR2(100) := 'LOG_LEVEL';
   g_log_level_error       CONSTANT NUMBER(1) := 0;
   g_log_level_info        CONSTANT NUMBER(1) := 1;
   g_log_level_debug       CONSTANT NUMBER(1) := 2;
   g_log_level_trace       CONSTANT NUMBER(1) := 3;
   --
   g_primary_language      CONSTANT VARCHAR2(10) := 'en';
   --
END PKG_COMMON_GV;
/