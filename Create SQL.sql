CREATE DATABASE "BD";

\c BD

CREATE TABLE IF NOT EXISTS Users(
	username VARCHAR(50) PRIMARY KEY,
	dbname VARCHAR(50) NOT NULL,
	user_password BYTEA NOT NULL
);

CREATE EXTENSION IF NOT EXISTS pgcrypto;

DO $$
DECLARE
	i INT := 1;
	user_name TEXT;
	db_name TEXT;
	random_password TEXT;
BEGIN
	WHILE i <= 10 LOOP
	user_name = 'user' || i;
	db_name = 'BD' || i;
	
	random_password := substr(encode(gen_random_bytes(5), 'hex'), 1, 5);

	EXECUTE format('CREATE USER %I WITH PASSWORD %L', user_name, random_password);

	INSERT INTO Users(username, dbname, user_password)
	VALUES (user_name, db_name, convert_to(random_password, 'UTF8'));
	
	i := i + 1;
	END LOOP;
	
END $$;

CREATE DATABASE "BD1" OWNER user1;
CREATE DATABASE "BD2" OWNER user2;
CREATE DATABASE "BD3" OWNER user3;
CREATE DATABASE "BD4" OWNER user4;
CREATE DATABASE "BD5" OWNER user5;
CREATE DATABASE "BD6" OWNER user6;
CREATE DATABASE "BD7" OWNER user7;
CREATE DATABASE "BD8" OWNER user8;
CREATE DATABASE "BD9" OWNER user9;
CREATE DATABASE "BD10" OWNER user10;

SELECT username, dbname, convert_from(user_password, 'UTF8') AS decrypted_password FROM Users;