CREATE OR REPLACE PACKAGE PKG_AUTH AS
   --
   g_program_name CONSTANT VARCHAR2(32) := 'PKG_AUTH';
   --
   ----------------------------------------------------------------------------
   -- validate_login
   ----------------------------------------------------------------------------
   PROCEDURE validate_login;

END PKG_AUTH;
/