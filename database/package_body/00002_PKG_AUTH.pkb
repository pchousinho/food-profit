CREATE OR REPLACE PACKAGE BODY PKG_AUTH AS
   ----------------------------------------------------------------------------
   -- VALIDATE_LOGIN
   ----------------------------------------------------------------------------
   PROCEDURE VALIDATE_LOGIN
   IS
      l_user         users%rowtype;
      l_google_sub   VARCHAR2(100);
      l_email        VARCHAR2(250);
      l_name         VARCHAR2(250);
   BEGIN
      -------------------------------------------------------------------------
      -- Dados do Google (APEX Session State)
      -------------------------------------------------------------------------
      l_google_sub := apex_util.get_session_state('G_SUB');
      l_email      := lower(apex_util.get_session_state('G_EMAIL'));
      l_name       := apex_util.get_session_state('G_NAME');
      --
      -------------------------------------------------------------------------
      -- Validação básica
      -------------------------------------------------------------------------
      IF l_google_sub IS NULL
      THEN
         raise_application_error(-20001, 'Google SUB not informed.');
      END IF;
      --
      IF l_email IS NULL
      THEN
         raise_application_error(-20002, 'Google email not informed.');
      END IF;
      --
      -------------------------------------------------------------------------
      -- 1) Tenta login por GOOGLE_SUB
      -------------------------------------------------------------------------
      BEGIN
         SELECT *
           INTO l_user
           FROM users
          WHERE google_sub = l_google_sub;
      EXCEPTION
         WHEN no_data_found
         THEN
            -------------------------------------------------------------------
            -- 2) Tenta localizar por EMAIL
            -------------------------------------------------------------------
            BEGIN
               SELECT *
                 INTO l_user
                 FROM users
                WHERE lower(email) = l_email;
               --
               ----------------------------------------------------------------
               -- Vincula GOOGLE_SUB
               ----------------------------------------------------------------
               UPDATE users
                  SET google_sub = l_google_sub,
                      updated_at = sysdate,
                      updated_by = l_email
                WHERE id = l_user.id;
               --
               l_user.google_sub := l_google_sub;
               --
            EXCEPTION
               WHEN no_data_found
               THEN
                  ----------------------------------------------------------------
                  -- 3) Cria usuário automaticamente (INATIVO)
                  ----------------------------------------------------------------
                  INSERT INTO users (
                     id,
                     email,
                     name,
                     login_failures,
                     status,
                     google_sub,
                     created_at,
                     created_by
                  ) VALUES (
                     seq_usuario.nextval,
                     l_email,
                     nvl(l_name, l_email),
                     0,
                     'I',
                     l_google_sub,
                     sysdate,
                     l_email
                  );
                  --
                  COMMIT;
                  --
                  SELECT *
                    INTO l_user
                    FROM users
                   WHERE email = l_email;
                  --
                  raise_application_error(
                     -20003,
                     'User created but pending activation.'
                  );
            END;
      END;
      --
      -------------------------------------------------------------------------
      -- Usuário ativo
      -------------------------------------------------------------------------
      IF l_user.status <> 'A'
      THEN
         raise_application_error(-20004, 'User is inactive.');
      END IF;
      --
      -------------------------------------------------------------------------
      -- Expiração de acesso
      -------------------------------------------------------------------------
      IF l_user.data_expiracao IS NOT NULL
         AND l_user.data_expiracao < sysdate
      THEN
         raise_application_error(-20005, 'User access expired.');
      END IF;
      --
      -------------------------------------------------------------------------
      -- Atualiza login
      -------------------------------------------------------------------------
      UPDATE users
         SET last_login = sysdate,
             login_failures = 0
       WHERE id = l_user.id;
      --
      -------------------------------------------------------------------------
      -- Contexto da sessão APEX
      -------------------------------------------------------------------------
      apex_util.set_session_state('G_USER_ID', l_user.id);
      apex_util.set_session_state('G_ACCESS_LEVEL', l_user.nivel_acesso);
      apex_util.set_session_state('G_SUB', l_google_sub);
      --
   END VALIDATE_LOGIN;
   --
END PKG_AUTH;
/