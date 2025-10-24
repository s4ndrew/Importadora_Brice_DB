
--Script para crear un nuevo usuario con permisos de administrador en SQL Server

--1ro, Conecta con la autenticasion de windows
USE master;
GO

-- Crear un nuevo inicio de sesión (login)
CREATE LOGIN UserAdminName WITH PASSWORD = 'Nueva_Contraseña';
GO

-- Darle permisos de sysadmin (igual que el usuario sa)
ALTER SERVER ROLE sysadmin ADD MEMBER UserAdminName;
GO
