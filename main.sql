--- СОЗДАНИЕ БАЗ ДАННЫХ И ПОЛЬЗОВАТЕЛЕЙ
USE[master];
GO

CREATE DATABASE BD;
GO

USE BD;
GO

-- Создание таблицы с пользователями
CREATE TABLE Users(
    UserName VARCHAR(50) PRIMARY KEY;
    DatabaseName VARCHAR(50),
    EncryptedPassword VARBINARY(MAX)
);
GO

-- Объявление переменных
DECLARE @user INT = 1;
DECLARE @user_total INT = 10;
DECLARE @username VARCHAR(10);
DECLARE @dbname VARCHAR(10);
DECLARE @dbpass VARCHAR(5);

WHILE @user <= @user_total
BEGIN
    --Генерация имени пользователя и имены базы данных
    SET @username = 'user' + CAST(@user AS VARCHAR);
    SET @dbname = 'BD' + CAST(@user AS VARCHAR);

    -- Генерация случайного пароля
    SET @dbpass = LEFT(REPLACE(CONVERT(VARCHAR(36), NEWID()), '-', ''), 5);
    PRINT @dbpass;

    USE[master];
    EXEC('CREATE LOGIN [' +@username+'] WITH PASSWORD = ''' + @dbpass + ''';');
    PRINT @username

    EXEC('CREATE DATABASE [' +@dbname +'];');
    PRINT @dbname
    
    -- Изменяет параметры логины
    EXEC('ALTER LOGIN [' + @username +'] WITH DEFAULT_DATABASE=[' + @dbname +'];')
    -- Запрешает доступ ко всем базам, кроме явных прав выданных
    EXEC('DENY VIEW ANY DATABASE TO [' +@username +']');
    -- Назначает пользователя, явным владельцем БД 
    EXEC('USE [' +dbname +']; EXEC dbo.sp_changedbowner @loginame = ''' +@username + ''', @map=false;');

    -- Вставляем данные 
    USE BD;
    INSERT INTO Users(Username, DatabaseName, EncryptedPassword) VALUES (@username, @dbname, CAST(@dbpass AS VARBINARY(MAX)));

    SET @user = @user +1;

END;

-- Выводим таблицу, для наглядности
USE BD;
SELECT Username, DatabaseName, CAST(EncryptedPassword AS VARBINARY(MAX)) AS DbPAss FROM Users;
