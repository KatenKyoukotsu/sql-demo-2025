\c BD

CREATE EXTENSION IF NOT EXISTS pgcrypto;

SELECT
	username,
	dbname,
	pgp_sym_decrypt(user_password, 'DEMO2025') AS decrypted_password
FROM Users;