CREATE OR REPLACE PACKAGE PKG_COMMON_CONTEXT AS
   --
   g_program_name CONSTANT VARCHAR2(32) := 'PKG_COMMON_CONTEXT';
   --
   ----------------------------------------------------------------------------
   -- DESCRIPTION - Checks whether an application context attribute is set for
   --               the current session.
   ----------------------------------------------------------------------------
   FUNCTION is_context_set(o_error_message     OUT logs.error_backtrace%TYPE
                          ,i_attribute_name IN     VARCHAR2)
   RETURN BOOLEAN;
   --
   ----------------------------------------------------------------------------
   -- DESCRIPTION - Retrieves the value of a specific context attribute from the session
   --               using SYS_CONTEXT. Logs the operation and handles errors.
   ----------------------------------------------------------------------------
   FUNCTION get_context(o_error_message     OUT logs.error_backtrace%TYPE
                       ,o_context_value     OUT VARCHAR2
                       ,i_attribute_name IN     VARCHAR2)
   RETURN BOOLEAN;
   --
END PKG_COMMON_CONTEXT;
/