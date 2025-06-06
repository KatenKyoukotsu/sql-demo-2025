\c BD

CREATE EXTENSION IF NOT EXISTS pgcrypto;

DO $$
DECLARE
	e_key TEXT := 'DEMO2025';
BEGIN
	UPDATE Users
	SET user_password = pgp_sym_encrypt(convert_from(user_password, 'UTF8'), e_key);
END $$;

SELECT * FROM users;