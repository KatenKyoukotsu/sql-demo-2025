-- Шифрование ключей
USE BD;
GO

-- Декодируем
OPEN SYMMETRIC KEY MySymmetricKey DECRYPTION BY CERTIFICATE MyCertificate;

SELECT UserName, DatabaseName, CONVERT(VARCHAR, DECRYPTBYKEY(EncryptedPassword)) AS  DecryptedPassword
FROM Users; 

CLOSE SYMMETRIC KEY MySymmetricKey;
