-- Шифрование ключей
USE BD;
GO

-- Создаём главный ключ, сертификат и симметричный ключ в базе данных BD
CREATE MAStER KEY ENCRYPTION BY PASSWORD = 'DEMO2025';
CREATE CERTIFICATE MyCertificate WITH SUBJECT = 'User Password Encryption';
CREATE SYMMETRIC KEY MySymmetricKey WITH ALGORITHM = AES_256 ENCRYPTION BY CERTIFICATE MyCertificate;
GO

-- Кодируем
OPEN SYMMETRIC KEY MySymmetricKey DECRYPTION BY CERTIFICATE MyCertificate;

UPDATE Users;
SET EncryptedPassword = ENCRYPTBYKEY(KEY_GIUD('MySymmetricKey'), CAST(EncryptedPassword AS VARCHAR(MAX)));

CLOSE SYMMETRIC KEY MySymmetricKey;

SELECT * FROM Users;
