CREATE OR REPLACE PACKAGE PKG_COMMON_ERR AS
   ------------------------------------------------------------------------------
   -- Error codes
   ------------------------------------------------------------------------------
   ERR$INVALID_PARAMETER            CONSTANT VARCHAR2(50) := 'ERR$INVALID_PARAMETER';
   ERR$GET_LOG_LEVEL                CONSTANT VARCHAR2(50) := 'ERR$GET_LOG_LEVEL';
   ERR$INVALID_PRIMARY_LANGUAGE     CONSTANT VARCHAR2(50) := 'ERR$INVALID_PRIMARY_LANGUAGE';
   ERR$PACKAGE_ERROR                CONSTANT VARCHAR2(50) := 'ERR$PACKAGE_ERROR';
   --
   ------------------------------------------------------------------------------
   -- Google authentication errors
   ------------------------------------------------------------------------------
   ERR$GOOGLE_SUB_NOT_INFORMED      CONSTANT VARCHAR2(50) := 'ERR$GOOGLE_SUB_NOT_INFORMED';
   ERR$GOOGLE_EMAIL_NOT_INFORMED    CONSTANT VARCHAR2(50) := 'ERR$GOOGLE_EMAIL_NOT_INFORMED';
   --
   ------------------------------------------------------------------------------
   -- Log level errors
   ------------------------------------------------------------------------------
   ERR$LOG_LEVEL_NOT_FOUND          CONSTANT VARCHAR2(50) := 'ERR$LOG_LEVEL_NOT_FOUND';
   --
   ------------------------------------------------------------------------------
   -- REST request errors
   ------------------------------------------------------------------------------
   ERR$MAKE_REST_REQUEST            CONSTANT VARCHAR2(50) := 'ERR$MAKE_REST_REQUEST';
   --
   ------------------------------------------------------------------------------
   -- Context errors
   ------------------------------------------------------------------------------
   ERR$CONTEXT_NOT_SET               CONSTANT VARCHAR2(50) := 'ERR$CONTEXT_NOT_SET';
   --
END PKG_COMMON_ERR;
/