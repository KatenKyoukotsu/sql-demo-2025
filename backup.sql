BACKUP DATABASE BD
 TO DISK = 'C:\Backup\DB_Backup.bak'
 WITH FORMAT, MEDIANAME = 'SQLServerBackups', NAME = 'FullBackup'

 PRINT 'Резервное копирование завершено'