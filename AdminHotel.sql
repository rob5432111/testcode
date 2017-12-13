CREATE DATABASE SistemaHotel
GO

USE SistemaHotel
GO


-------------------------------------------------------------
----------------------------USUARIOS-------------------------
-------------------------------------------------------------

CREATE TABLE Usuario 
(
Id_Usuario INT IDENTITY(1,1) PRIMARY KEY,
Nombre VARCHAR(100) UNIQUE,
Correo NVARCHAR(100) UNIQUE,
Alias VARCHAR(50) UNIQUE,
Clave VARBINARY(MAX),
Tipo_Usuario TINYINT, --101 Administrador, 102 Supervisor, 103 Usuario 
Estado TINYINT, --101 Activo, 
Ultimo_Acceso DATETIME
)
GO




CREATE INDEX Index_Usuario
ON Usuario (Id_Usuario, Alias);
GO


CREATE ASYMMETRIC KEY ClaveUsuarios WITH ALGORITHM = RSA_2048 
ENCRYPTION BY PASSWORD = N'RobDav001!'
GO

CREATE PROCEDURE sp_c_usuario
@nombre VARCHAR (100),
@correo NVARCHAR(100),
@alias VARCHAR(50),
@clave NVARCHAR(50),
@tipo_usuario TINYINT
as
INSERT INTO Usuario
VALUES (
@nombre,
@correo, 
@alias, 
EncryptByAsymKey(AsymKey_ID('ClaveUsuarios'), @clave), @tipo_usuario,102,GETDATE())
GO

--drop procedure sp_c_usuario

create procedure sp_m_usuario
@id int,
@nombre VARCHAR (100),
@correo NVARCHAR(100),
@alias VARCHAR(50),
@clave NVARCHAR(50),
@tipo_usuario TINYINT
as
UPDATE Usuario set nombre = @nombre,
Correo = @correo, 
Alias = @alias, 
Clave = EncryptByAsymKey(AsymKey_ID('ClaveUsuarios'), @clave), 
Tipo_Usuario = @tipo_usuario
WHERE Id_Usuario = @id
GO

--execute sp_m_usuario 1,'David Pozo Andrade','roberto.pozo@gmail.com','RobDav01','456',102
--drop procedure sp_m_usuario

CREATE PROCEDURE sp_b_alias
@alias VARCHAR(50)
AS
SELECT Alias FROM USUARIO
WHERE Alias = @alias
GO


--drop procedure sp_b_alias

CREATE PROCEDURE sp_m_ultimoacceso
@Id int
AS
UPDATE Usuario SET Ultimo_Acceso = GETDATE(), Estado = 101
WHERE Id_Usuario = @Id
GO


--drop procedure sp_m_ultimoacceso

CREATE PROCEDURE sp_m_estado_id
@id INT
AS
UPDATE Usuario SET Estado = 102
WHERE Id_Usuario = @id
GO


-- Following query can be used to test an entered password:
CREATE PROCEDURE sp_b_clave
@alias varchar(50)
as
SELECT		Id_Usuario,PassWordDecrypted = convert(nvarchar(30),
            DecryptByAsymKey(AsymKey_ID('ClaveUsuarios'),
            [Clave], N'RobDav001!' ))
FROM Usuario
WHERE Alias = @alias
GO


--Drop Procedure sp_b_clave

CREATE PROCEDURE sp_b_usuario_nom_l
@nombre VARCHAR(100)
AS
SELECT Id_Usuario, Nombre, Correo, Alias, Tipo_Usuario FROM usuario 
WHERE Nombre LIKE '%' + @nombre + '%' 

GO

--drop procedure sp_b_usuario_nom_l

--execute sp_b_usuario_nom_l 'ro'


CREATE PROCEDURE sp_b_usuario_nom_e
@nombre VARCHAR(100)
AS
SELECT Id_Usuario, Nombre, Correo, Alias, Tipo_Usuario FROM usuario 
WHERE Nombre = @nombre 

GO

--drop procedure sp_b_usuario_nom_e

--execute sp_b_usuario_nom_e 'ro'

CREATE PROCEDURE sp_b_usuario_id
@Id INT
AS
SELECT Id_Usuario, Nombre, Correo, Alias, Tipo_Usuario, Estado, Ultimo_Acceso from usuario
WHERE Id_Usuario = @Id
GO
 

--drop procedure sp_b_usuario_id
--execute sp_b_usuario_id 1


-------------------------------------------------------------------
-------------------------USUARIOS CONECTADOS-----------------------
-------------------------------------------------------------------

--101 Conectado
--102 Desconectado


CREATE PROCEDURE sp_b_usu_conec_ddl
AS
SELECT Id_Usuario, Nombre FROM Usuario 
WHERE Estado = 101
GO




-------------------------------------------------------------------
-----------------------------HABITACIONES--------------------------
-------------------------------------------------------------------


CREATE TABLE Tipo_Habitacion
(
Id_Tipo_Habitacion INT IDENTITY (1,1) PRIMARY KEY,
Descripcion VARCHAR(100) UNIQUE,
Cantidad_Matrimonial TINYINT,
Cantidad_Individual TINYINT,
Cantidad_Baño TINYINT,
Extras VARCHAR(150)
)
GO



--CREATE PROCEDURE sp_c_tipo_habitacion
--@descripcion VARCHAR(100),
--@cantidad_Matrimonial TINYINT,
--@cantidad_Individual TINYINT,
--@cantidad_Baño TINYINT,
--@extras VARCHAR(150)
--AS 
--INSERT INTO Tipo_Habitacion VALUES (
--@descripcion, @cantidad_Matrimonial, @cantidad_Individual,
--@cantidad_Baño, @extras)
--GO

--execute sp_c_tipo_habitacion 'Cabaña Familiar', 1, 2, 0, 0, 0, 1, 'Aire Acondicionado, WiFi, DirecTv,	MiniBar'
--execute sp_c_tipo_habitacion 'Suite Matrimonial', 1, 0, 0, 0, 0, 1, 'Aire Acondicionado, WiFi, DirecTv, MiniBar'
--drop procedure sp_c_tipo_habitacion



CREATE PROCEDURE sp_m_tipo_habitacion
@Id int,
@descripcion VARCHAR(100),
@cantidad_Matrimonial TINYINT,
@cantidad_Individual TINYINT,
@cantidad_Baño TINYINT,
@extras VARCHAR(150)
AS
UPDATE Tipo_Habitacion SET 
Descripcion = @descripcion,
Cantidad_Matrimonial = @cantidad_Matrimonial,
Cantidad_Individual = @cantidad_Individual,
Cantidad_Baño = @cantidad_Baño,
Extras = @extras
WHERE Id_Tipo_Habitacion = @Id
GO

--drop procedure sp_m_tipo_habitacion

CREATE PROCEDURE sp_b_tipo_habitacion_id
@id INT
AS
SELECT * FROM Tipo_Habitacion 
WHERE Id_Tipo_Habitacion = @id
GO

--drop procedure sp_b_tipo_habitacion_id

CREATE TABLE Habitacion
(
Id_Habitacion INT IDENTITY(1,1) PRIMARY KEY,
Codigo_Habitacion VARCHAR(20) UNIQUE,
Id_Tipo_Habitacion INT FOREIGN KEY REFERENCES Tipo_Habitacion(Id_Tipo_Habitacion),
Estado VARCHAR(20)
)
GO

CREATE PROCEDURE sp_b_habitacion
AS
SELECT Codigo_Habitacion, Id_Habitacion FROM Habitacion
GO

--drop procedure sp_b_habitacion

CREATE PROCEDURE sp_b_habitacion_id
@id INT
AS
SELECT h.Id_Tipo_Habitacion, Cantidad_Matrimonial, Cantidad_Individual, Cantidad_Baño, Extras, Estado, Codigo_Habitacion
FROM Habitacion h INNER JOIN Tipo_Habitacion t
ON h.Id_Tipo_Habitacion = t.Id_Tipo_Habitacion
WHERE Id_Habitacion = @id
GO

--drop procedure sp_b_habitacion_id


CREATE PROCEDURE sp_c_habitacion
@codigo_Habitacion VARCHAR(20),
@Id_Tipo_Habitacion INT
AS
INSERT INTO Habitacion VALUES (@codigo_Habitacion, @Id_Tipo_Habitacion, 'Libre')
GO


CREATE PROCEDURE sp_e_habitacion
@id INT
AS
DELETE habitacion WHERE Id_Habitacion = @id
SELECT * FROM habitacion
GO

--drop procedure sp_e_habitacion



--SELECT codigo_habitacion, h.Id_Tipo_Habitacion, Cantidad_Matrimonial, Cantidad_Individual, Cantidad_Baño, Extras 
--FROM Habitacion h INNER JOIN Tipo_Habitacion t
--ON h.Id_Tipo_Habitacion = t.Id_Tipo_Habitacion

--execute sp_c_habitacion 'FAMI-01',1
--execute sp_c_habitacion 'FAMI-02',1
--execute sp_c_habitacion 'FAMI-03',1
--execute sp_c_habitacion 'FAMI-04',1
--execute sp_c_habitacion 'FAMI-05',1
--execute sp_c_habitacion 'FAMI-06',1
--execute sp_c_habitacion 'FAMI-07',1
--execute sp_c_habitacion 'FAMI-08',1
--execute sp_c_habitacion 'FAMI-09',1
--execute sp_c_habitacion 'FAMI-10',1
--execute sp_c_habitacion 'FAMI-11',1
--execute sp_c_habitacion 'FAMI-12',1
--execute sp_c_habitacion 'MATRI-01',2
--execute sp_c_habitacion 'MATRI-02',2
--execute sp_c_habitacion 'MATRI-03',2
--execute sp_c_habitacion 'MATRI-04',2


CREATE PROCEDURE sp_m_habitacion 
@id int, 
@codigo_Habitacion VARCHAR(20),
@id_Tipo_Habitacion INT
AS
UPDATE Habitacion SET Codigo_Habitacion = @codigo_Habitacion,
Id_Tipo_Habitacion = @id_Tipo_Habitacion 
WHERE Id_Habitacion = @id
GO

CREATE PROCEDURE sp_m_habitacion_estado
@id INT,
@estado VARCHAR(20)
AS
UPDATE Habitacion SET Estado = @estado
WHERE Id_Habitacion = @id
GO

CREATE PROCEDURE sp_b_id_h_cod
@codigo_Habitacion VARCHAR(20)
AS
SELECT Id_Habitacion FROM Habitacion
WHERE Codigo_Habitacion = @codigo_Habitacion
GO
--execute sp_m_habitacion_estado 4, 'Reservada'

--CREATE PROCEDURE sp_b_habitacion_cod
--@codigo_Habitacion VARCHAR(20)
--AS
--SELECT Id_Habitacion, Codigo_Habitacion, H.Id_Tipo_Habitacion,
--Descripcion FROM Habitacion H JOIN Tipo_Habitacion TH
--ON H.Id_Tipo_Habitacion = TH.Id_Tipo_Habitacion
--WHERE Codigo_Habitacion = @codigo_Habitacion
--ORDER BY Id_habitacion
--GO

--CREATE PROCEDURE sp_b_habitacion_tipo
--@codigo_Habitacion VARCHAR(20)
--AS
--SELECT * FROM Habitacion H JOIN Tipo_Habitacion TH
--ON H.Id_Tipo_Habitacion = TH.Id_Tipo_Habitacion
--WHERE Codigo_Habitacion = @codigo_Habitacion
--GO

--drop procedure sp_b_habitacion_cod
--execute sp_b_habitacion_cod 'MAT'

-------------------------------------------------------------------
--------------------------------CLIENTE----------------------------
-------------------------------------------------------------------

CREATE TABLE Cliente
(
Id_Cliente INT IDENTITY(1,1) PRIMARY KEY,
Nombre VARCHAR(100) UNIQUE,
Documento VARCHAR(50) UNIQUE,
Direccion VARCHAR(200),
Correo NVARCHAR(100),
Telefono1 VARCHAR(20),
Telefono2 VARCHAR(20),
Nacionalidad VARCHAR(20),
Genero VARCHAR(20),
F_Nacimiento SMALLINT
)
GO

 
CREATE INDEX Index_Cliente
ON Cliente (Documento, Nombre);
GO

--drop table Cliente
CREATE PROCEDURE sp_c_cliente
@nombre VARCHAR(100),
@documento VARCHAR(50),
@direccion VARCHAR(200),
@correo NVARCHAR(100),
@telefono1 VARCHAR(20),
@telefono2 VARCHAR(20),
@nacionalidad VARCHAR(20),
@genero VARCHAR(20),
@f_nac SMALLINT
AS
INSERT INTO Cliente VALUES (@nombre, @documento, @direccion, @correo, @telefono1, @telefono2,@nacionalidad,@genero,@f_nac)
GO

--drop procedure sp_c_cliente

--execute sp_c_cliente 'Roberto David Pozo Andfrade12',null,'Av. 10 de Octubre y La que Cruza', 'nnabeforeidie@hotmail.com','1234567890',''



CREATE PROCEDURE sp_m_cliente
@id INT,
@nombre VARCHAR(100),
@documento VARCHAR(50),
@direccion VARCHAR(200),
@correo NVARCHAR(100),
@telefono1 VARCHAR(20),
@telefono2 VARCHAR(20),
@nacionalidad VARCHAR(20),
@genero VARCHAR(20),
@f_nac SMALLINT
AS
UPDATE Cliente SET Nombre = @nombre,
Documento = @documento,
Direccion = @direccion,
Correo = @correo,
Telefono1 = @telefono1,
Telefono2= @telefono2,
Nacionalidad = @nacionalidad,
Genero = @genero,
F_Nacimiento = @f_nac
WHERE Id_Cliente = @id
GO

--drop procedure sp_m_cliente
ALTER PROCEDURE sp_b_cliente_doc
@documento VARCHAR(50)
AS
SELECT * , (year(GETDATE()) - F_Nacimiento) as Edad FROM Cliente
WHERE Documento = @documento
GO


CREATE PROCEDURE sp_b_cliente_nom_l
@nombre VARCHAR(100)
AS
SELECT Documento, Nombre FROM Cliente
WHERE Nombre LIKE '%' + @nombre + '%'
GO


--CREATE PROCEDURE sp_b_cliente_nom_e
--@nombre VARCHAR(100)
--AS
--SELECT * FROM Cliente
--WHERE Nombre = @nombre
--GO

--drop procedure sp_b_cliente_nom_e
---------------------------------------------------------------
-------------------REGISTROS CLIENTE----------------------------
---------------------------------------------------------------

CREATE TABLE Registro_Cliente
(
Id_Registro_Cliente INT IDENTITY(1,1) PRIMARY KEY,
Id_Cliente INT FOREIGN KEY REFERENCES Cliente(Id_Cliente),
Id_Habitacion INT FOREIGN KEY REFERENCES Habitacion(Id_Habitacion),
Fecha_Ingreso DATETIME,
Fecha_Salida DATETIME,
Id_Usuario_Ingreso INT FOREIGN KEY REFERENCES Usuario(Id_Usuario),
Id_Usuario_Salida INT FOREIGN KEY REFERENCES Usuario(Id_Usuario),
Id_Factura INT FOREIGN KEY REFERENCES Factura(Id_Factura) 
)
GO


CREATE PROCEDURE sp_c_registro
@id_Cliente INT,
@id_Habitacion INT,
@fecha_Ingreso DATETIME,
@fecha_Salida DATETIME,
@id_Usuario_Ingreso INT
AS 
INSERT INTO Registro_Cliente VALUES(
@id_Cliente, @id_Habitacion, @fecha_Ingreso, @fecha_Salida,@id_Usuario_Ingreso,NULL, NULL)
SELECT SCOPE_IDENTITY() as Id_Registro
GO



--drop procedure sp_c_registro
--execute sp_c_registro 1,2,'2017-07-24','2017-07-31',1,0,1,null

CREATE PROCEDURE sp_m_registro
@id INT,
@id_Cliente INT,
@id_Habitacion INT,
@fecha_Ingreso DATETIME,
@fecha_Salida DATETIME,
@id_Usuario_Ingreso INT
AS
UPDATE Registro_Cliente SET 
Id_Cliente = @id_Cliente,
Id_Habitacion = @id_Habitacion,
Fecha_Ingreso = @fecha_Ingreso,
Fecha_Salida = @fecha_Salida,
Id_Usuario_Ingreso = @id_Usuario_Ingreso
WHERE Id_Registro_Cliente = @id

GO

--drop procedure sp_m_registro

CREATE PROCEDURE sp_c_registro_salida
@id INT,
@fecha_Salida DATETIME,
@id_Usuario_Salida INT
AS
UPDATE Registro_Cliente SET
Fecha_Salida = @fecha_Salida,
Id_Usuario_Salida = @id_Usuario_Salida
WHERE Id_Registro_Cliente = @id
GO

--execute sp_c_registro_salida 1,'2017-07-31 11:30:00',1

CREATE PROCEDURE sp_b_reg_ing
AS
SELECT Id_Registro_Cliente, Nombre + ' - ' + Codigo_Habitacion AS Registro  From Registro_Cliente r Inner Join Cliente c on r.Id_Cliente = c.Id_Cliente
Inner Join Habitacion h on h.Id_Habitacion = r.Id_Habitacion
WHERE Fecha_Ingreso >= GETDATE() - 21 AND Id_Usuario_Salida IS NULL
GO



--drop procedure sp_b_reg_ing

ALTER PROCEDURE sp_b_reg_ing_id
@id INT
AS
SELECT * FROM Registro_Cliente r inner join Cliente c on r.Id_Cliente = c.Id_Cliente
INNER JOIN Habitacion h ON r.Id_Habitacion = h.Id_Habitacion
WHERE Id_Registro_Cliente = @id
GO

--drop procedure sp_b_reg_ing_id
ALTER PROCEDURE sp_b_reg_sal
AS
SELECT Id_Registro_Cliente, Nombre + ' - ' + Codigo_Habitacion AS Registro  From Registro_Cliente r Inner Join Cliente c on r.Id_Cliente = c.Id_Cliente
Inner Join Habitacion h on h.Id_Habitacion = r.Id_Habitacion
WHERE Fecha_Salida IS NOT NULL AND Fecha_Salida >= GETDATE() - 21
GO


-----------------------------------------------------------
-------------------------RESERVAS--------------------------
-----------------------------------------------------------

------------------POSIBLES RESERVAS-------------------

CREATE TABLE Posible_Reserva --Temporal
(
Id_Posible_Reserva INT IDENTITY(1,1) PRIMARY KEY,
Fecha_Realizacion_Reserva DATETIME,
Fecha_Desde DATETIME,
Fecha_Hasta DATETIME,
Tipo_Habitacion TINYINT,  --  0  Familiar  1   Matrimonial 
Cantidad_Adulto TINYINT,
Cantidad_Menor TINYINT,
Nombre VARCHAR(100),
Correo NVARCHAR(100),
Telefono1 VARCHAR(50),
Telefono2 VARCHAR(50),
Comentario VARCHAR(200)
)
GO

--drop table posible_reserva

CREATE PROCEDURE sp_c_posible_reserva 
@fecha_Realizacion_Reserva DATETIME,
@fecha_Desde DATETIME,
@fecha_Hasta DATETIME,
@tipo_Habitacion TINYINT,
@cantidad_Adulto TINYINT,
@cantidad_Menor TINYINT,
@nombre VARCHAR(100),
@correo NVARCHAR(100),
@telefono1 VARCHAR(50),
@telefono2 VARCHAR(50),
@comentario VARCHAR(200)
AS
INSERT INTO Posible_Reserva VALUES (
@fecha_Realizacion_Reserva,
@fecha_Desde,
@fecha_Hasta,
@tipo_Habitacion,
@cantidad_Adulto,
@cantidad_Menor,
@nombre,
@correo,
@telefono1,
@telefono2,
@comentario
)
GO



--drop procedure sp_c_posible_reserva

--execute sp_c_posible_reserva '2018-01-01 00:00:00','2018-01-25','2018-01-27',1,2,0,'P_R Matrimonial','nnabeforeidie@hotmail.com','123123','321321','1 sola reserva matrimonial'
--execute sp_c_posible_reserva '2018-01-01 00:00:00','2018-01-26','2018-01-30',2,2,3,'P_R Familiar','nnabeforeidie@hotmail.com','123123','321321','1 : 2 Familiar'
--execute sp_c_posible_reserva '2018-01-01 00:00:00','2018-01-26','2018-01-30',2,3,0,'P_R Familiar','nnabeforeidie@hotmail.com','123123','321321','2 : 2 Familiar'
--execute sp_c_posible_reserva '2018-01-01 00:00:01','2018-01-01','2018-01-05',2,2,2,'P_R Familiar','nnabeforeidie@hotmail.com','123123','321321','Diferente 1 segundo'


--create procedure sp_b_ticket_p_r
--@cant_h INT
--as
--select TOP(@cant_h) id, correo from posible_reserva order by id_posible_reserva desc
--GO

----execute sp_b_ticket_p_r 3
----drop procedure sp_b_ticket_p_r

CREATE PROCEDURE sp_b_pos_rsv_fnom
@f_pr DATETIME,
@nombre VARCHAR(100)
AS
SELECT * FROM Posible_Reserva
WHERE Fecha_Realizacion_Reserva = @f_pr
AND Nombre = @nombre
ORDER BY Id_Posible_Reserva
GO


--drop procedure sp_b_pos_rsv_fnom

CREATE PROCEDURE sp_b_pos_rsv_e
AS
SELECT Fecha_Realizacion_Reserva, Nombre FROM Posible_Reserva
WHERE CAST(Fecha_Desde AS DATE) >= CAST(GETDATE() AS DATE)
GROUP BY Fecha_Realizacion_Reserva, Nombre
ORDER BY Fecha_Realizacion_Reserva DESC
GO

--drop procedure sp_b_pos_rsv_e

CREATE PROCEDURE sp_e_pos_rsv_fynom
@f_rsv DATETIME, 
@nombre VARCHAR(100)
AS 
DELETE Posible_Reserva 
WHERE Fecha_Realizacion_Reserva = @f_rsv AND Nombre = @nombre
SELECT * FROM Posible_Reserva
GO

select * from habitacion


---------------RESERVAS----------------------

CREATE TABLE Reserva
(
Id_Reserva INT IDENTITY(1,1) PRIMARY KEY,
Fecha_Desde DATETIME,
Fecha_Hasta DATETIME,
Cantidad_Adulto TINYINT,
Cantidad_Menor TINYINT,
Id_Habitacion INT FOREIGN KEY REFERENCES Habitacion (Id_Habitacion),
Id_Cliente INT FOREIGN KEY REFERENCES Cliente(Id_Cliente),
Id_Usuario INT FOREIGN KEY REFERENCES Usuario(Id_Usuario),
Estado VARCHAR(20)
)
GO
--drop table reserva



CREATE PROCEDURE sp_c_reserva
@fecha_Desde DATETIME,
@fecha_Hasta DATETIME,
@cantidad_Adulto TINYINT,
@cantidad_Menor TINYINT,
@id_Habitacion INT,
@id_Cliente INT,
@id_Usuario INT
AS
INSERT INTO Reserva VALUES(
@fecha_Desde, @fecha_Hasta,
@cantidad_Adulto, @cantidad_Menor,
@id_Habitacion, @id_Cliente,
@id_Usuario, 'Confirmada'
)
SELECT SCOPE_IDENTITY() as Id_Rsv
GO



--drop procedure sp_c_reserva

CREATE PROCEDURE sp_e_reserva_id
@id INT
AS
DELETE Reserva WHERE Id_Reserva = @id
SELECT Id_Reserva FROM Reserva
GO


----A-01
--execute sp_c_reserva '2017-09-26', '2017-09-27',2,0,1,1,1 
--execute sp_c_reserva '2017-09-28', '2017-09-28',1,0,1,4,1
----A-02
--execute sp_c_reserva '2017-09-26', '2017-09-27',2,0,2,1,1
--execute sp_c_reserva '2017-09-28', '2017-09-29',2,0,2,1,1
--execute sp_c_reserva '2017-09-30', '2017-09-30',2,0,2,1,1
----A-03
--execute sp_c_reserva '2017-09-28', '2017-09-29',2,0,3,1,1
--execute sp_c_reserva '2017-09-30', '2017-09-30',2,0,3,1,1
----A-04 A-05
--execute sp_c_reserva '2017-09-26', '2017-09-28',2,0,4,1,1
--execute sp_c_reserva '2017-09-26', '2017-09-28',2,0,5,1,1
----A-06
--execute sp_c_reserva '2017-09-27', '2017-09-29',2,0,6,1,1
----A-07
--execute sp_c_reserva '2017-09-30', '2017-09-30',2,0,7,1,1
----A-09
--execute sp_c_reserva '2017-09-26', '2017-09-26',2,0,9,1,1
--execute sp_c_reserva '2017-09-28', '2017-09-28',2,0,9,1,1
----A-10
--execute sp_c_reserva '2017-09-28', '2017-09-28',2,0,10,1,1
----B-01
--execute sp_c_reserva '2017-09-26', '2017-09-27',2,0,13,1,1 
--execute sp_c_reserva '2017-09-28', '2017-09-28',1,0,13,4,1
----B-02
--execute sp_c_reserva '2017-09-26', '2017-09-27',2,0,14,1,1 
--execute sp_c_reserva '2017-09-28', '2017-09-28',1,0,14,4,1
--execute sp_c_reserva '2017-09-30', '2017-09-30',1,0,14,4,1
----B-04 05 06 
--execute sp_c_reserva '2017-09-26', '2017-09-28',0,2,16,1,1
--execute sp_c_reserva '2017-09-26', '2017-09-28',0,2,22,1,1
--execute sp_c_reserva '2017-09-27', '2017-09-29',0,2,23,1,1


CREATE PROCEDURE sp_b_h_disponibles_f
@f_desde DATETIME, 
@f_hasta DATETIME
AS
SELECT Id_Habitacion, Codigo_Habitacion From Habitacion
WHERE Id_Habitacion NOT IN (SELECT Id_Habitacion FROM Reserva 
WHERE Fecha_Desde <= @f_hasta AND Fecha_Hasta >  @f_desde) 
AND Estado = 'Activa'
GO



--drop procedure sp_b_h_disponibles_f


CREATE PROCEDURE sp_b_rsv_ddl_c
AS
SELECT Id_Reserva, Nombre + ' - ' + Codigo_Habitacion AS Reserva  From Reserva r Inner Join Cliente c on r.Id_Cliente = c.Id_Cliente
Inner Join Habitacion h on h.Id_Habitacion = r.Id_Habitacion
WHERE CAST(Fecha_Desde AS DATE) >= CAST(GETDATE() AS DATE) 
AND r.Estado = 'Confirmada'
GO



CREATE PROCEDURE sp_b_rsv_ddl_f
@id INT
AS
SELECT GETDATE(), Id_Reserva, CONVERT(VARCHAR(14),Fecha_Desde,107) + ' - '+ CONVERT(VARCHAR(14),Fecha_Hasta,107) AS Fecha From Reserva
WHERE CAST(Fecha_Hasta AS DATE) >= CAST(GETDATE() AS DATE) AND Id_Habitacion = @id
GO 


CREATE PROCEDURE sp_b_rsv_id
@id INT
AS
SELECT Fecha_Desde, Fecha_Hasta, Cantidad_Adulto, Cantidad_Menor, Codigo_Habitacion, Nombre, Documento,
Direccion, Correo, Telefono1, Telefono2, (year(GETDATE()) - F_Nacimiento) as Edad, Nacionalidad, Genero
FROM Reserva r INNER JOIN Habitacion h ON h.Id_Habitacion = r.Id_Habitacion 
INNER JOIN Cliente c ON r.Id_Cliente = c.Id_Cliente
WHERE Id_Reserva = @id
GO


--drop procedure sp_b_rsv_id

ALTER PROCEDURE sp_m_reserva
@id INT,
@f_Desde DATETIME,
@f_Hasta DATETIME,
@id_Cliente INT,
@id_Habitacion INT,
@id_Usuario INT,
@cantidad_Adulto TINYINT,
@cantidad_Menor TINYINT
AS
UPDATE Reserva SET
Fecha_Desde = @f_Desde,
Fecha_Hasta = @f_Hasta,
Cantidad_Adulto = @cantidad_Adulto,
Cantidad_Menor = @cantidad_Menor,
Id_Habitacion = @id_Habitacion,
Id_Cliente = @id_Cliente,
Id_Usuario = @id_Usuario
WHERE Id_Reserva = @id
GO

CREATE PROCEDURE sp_m_rsv_estado
@id INT
AS
UPDATE Reserva SET Estado = 'Procesada'
WHERE Id_Reserva = @id
GO
--drop procedure sp_e_pos_rsv_id
--insert into posible_reserva values ('2017-09-28','2017-09-30','2017-10-04',2,0,'Usuario a eliminar','asd','123123','321321',null)


--execute sp_b_h_disponibles_f '2017-09-30','2017-09-30'


--CREATE PROCEDURE sp_confirmar_reserva
--@id_Posible_Reserva INT,
--@id_Habitacion INT,
--@id_Cliente INT,
--@id_Usuario INT,
--@estado VARCHAR(20)
--AS
--BEGIN TRY
--    BEGIN TRANSACTION
--	INSERT INTO Reserva
--	SELECT Fecha_Desde, Fecha_Hasta, Cantidad_Indiviual_Adulto, 
--	FROM Posible_Reserva
--	WHERE Id_Posible_Reserva = @id_Posible_Reserva
--	COMMIT TRAN
--END TRY
--BEGIN CATCH
--    IF @@TRANCOUNT > 0
--        ROLLBACK TRAN 
--		SELECT ERROR_MESSAGE() as Mensaje, ERROR_NUMBER() as Error_Numero
--END CATCH
--GO

-----------------------------------------------------------------------
-------------------------------REPORTES--------------------------------
-----------------------------------------------------------------------

CREATE PROCEDURE sp_r_reserva_f
@f_desde DATETIME,
@f_hasta DATETIME
AS
SELECT Id_Reserva, Convert(char(11), Fecha_Desde, 106) as Fecha_Desde, Convert(char(11), Fecha_Hasta, 106) as Fecha_Hasta,
DateDiff(Day,fecha_desde, fecha_hasta) as Dias,
Cantidad_Adulto, Cantidad_Menor, Codigo_Habitacion, Documento, Nombre
FROM Reserva r Inner Join Cliente c ON r.Id_Cliente = c.Id_Cliente
Inner Join Habitacion h ON r.Id_Habitacion = h.Id_Habitacion
WHERE Fecha_Desde >= @f_desde and Fecha_Hasta <= @f_hasta
GO

--drop procedure sp_r_reserva_f

CREATE PROCEDURE sp_r_registro_f
@f_desde DATETIME,
@f_hasta DATETIME
AS
SELECT Id_Registro_Cliente, Convert(char(11), Fecha_Ingreso, 106) as Fecha_Ingreso,  Convert(char(11), Fecha_Salida, 106) as Fecha_Salida, 
datediff(day,Fecha_Ingreso,Fecha_Salida) as Dias, DateDiff(Hour,Convert(time, Fecha_Ingreso),Convert(time,Fecha_Salida)) as Horas,
Codigo_Habitacion, Documento, Nombre 
FROM registro_cliente r Inner Join Cliente c ON r.Id_Cliente = c.Id_Cliente
Inner Join Habitacion h ON r.Id_Habitacion = h.Id_Habitacion
WHERE Fecha_Ingreso >= @f_desde and Fecha_Salida <= @f_hasta
GO

--drop procedure sp_r_registro_f


-----------------------------------------------------------------------
-------------------------------HUESPEDES-------------------------------
-----------------------------------------------------------------------

--CREATE TABLE Huesped
--(
--Id_Huesped INT PRIMARY KEY IDENTITY(1,1),
--Id_Registro_Cliente INT FOREIGN KEY REFERENCES Registro_Cliente(Id_Registro_Cliente),
--Documento_H VARCHAR(50),
--Nombre_H VARCHAR(50),
--Edad_H TINYINT,
--Nacionalidad_H VARCHAR(20),
--Genero_H VARCHAR(20)
--)
--GO


CREATE TABLE Huesped1
(
Id_Huesped INT PRIMARY KEY IDENTITY(1,1),
Documento_H VARCHAR(50) UNIQUE,
Nombre_H VARCHAR(50),
Edad_H TINYINT,
Nacionalidad_H VARCHAR(20),
Genero_H VARCHAR(20)
)
GO


CREATE TABLE huesped_registro
(
Id_HR INT IDENTITY PRIMARY KEY,
Id_Registro_Cliente INT FOREIGN KEY REFERENCES Registro_Cliente(Id_Registro_Cliente),
Id_Huesped INT FOREIGN KEY REFERENCES Huesped1(Id_Huesped)
)
GO

CREATE PROCEDURE sp_c_huesped
@id_registro INT,
@doc VARCHAR(50),
@nombre VARCHAR(50),
@edad TINYINT,
@nacionalidad VARCHAR(20),
@genero VARCHAR(20)
AS
BEGIN TRY      
       BEGIN TRAN tran_c_factura
			DECLARE @id_huesped INT
			IF NOT EXISTS(SELECT Id_Huesped FROM Huesped1 WHERE Documento_H = @doc)
			BEGIN
				INSERT INTO Huesped1 VALUES (@doc, @nombre, @edad, @nacionalidad, @genero)				
				SET @id_huesped = SCOPE_IDENTITY()
				INSERT INTO huesped_registro VALUES (@id_registro, @id_huesped)
			END
			ELSE
			BEGIN
				SET @id_huesped = (SELECT Id_Huesped FROM Huesped1 WHERE Documento_H = @doc) 
				INSERT INTO huesped_registro VALUES (@id_registro, @id_huesped)
				UPDATE Huesped1 SET 
				Documento_H = @doc,
				Nombre_H = @nombre,
				Edad_H = @edad,
				Nacionalidad_H = @nacionalidad,
				Genero_H = @genero 
				WHERE Id_Huesped = @id_huesped
			END
       COMMIT TRAN tran_c_factura
END TRY
BEGIN CATCH        
	   ROLLBACK TRAN tran_c_factura  
	   SELECT ERROR_NUMBER() AS errNumber
       , ERROR_SEVERITY() AS errSeverity  
       , ERROR_STATE() AS errState
       , ERROR_PROCEDURE() AS errProcedure
       , ERROR_LINE() AS errLine
       , ERROR_MESSAGE() AS errMessage
END CATCH

GO



--CREATE PROCEDURE sp_c_huesped
--@id_registro INT,
--@doc VARCHAR(50),
--@nombre VARCHAR(50),
--@edad TINYINT,
--@nacionalidad VARCHAR(20),
--@genero VARCHAR(20)
--AS
--INSERT INTO Huesped VALUES (@id_registro, @doc, @nombre, @edad, @nacionalidad, @genero)
--GO

--CREATE PROCEDURE sp_b_huesped_id
--@id_reg INT
--AS
--SELECT * FROM Huesped WHERE Id_Registro_Cliente = @id_reg 
--GO

CREATE PROCEDURE sp_b_huesped_id
@id_reg INT
AS
SELECT hr.Id_HR, h.Id_Huesped, hr.Id_Registro_Cliente, Documento_H, Nombre_H, Edad_H, Nacionalidad_H, Genero_H FROM Huesped1 h INNER JOIN huesped_registro hr ON h.Id_Huesped = hr.Id_Huesped 
INNER JOIN Registro_Cliente r ON r.Id_Registro_Cliente = hr.Id_Registro_Cliente 
WHERE hr.Id_Registro_Cliente = @id_reg
ORDER BY hr.Id_Registro_Cliente
GO

CREATE PROCEDURE sp_b_huesped_doc
@doc VARCHAR(50)
AS
SELECT * FROM Huesped1 WHERE Documento_H = @doc
GO



CREATE PROCEDURE sp_m_huesped
@id INT,
@id_HR INT,
@doc VARCHAR(50),
@nombre VARCHAR(50),
@edad TINYINT,
@nacionalidad VARCHAR(20),
@genero VARCHAR(20)
AS
BEGIN TRY      
		BEGIN TRAN tran_c_factura 
			UPDATE Huesped1 SET 
			Nombre_H = @nombre,
			Edad_H = @edad,
			Nacionalidad_H = @nacionalidad,
			Genero_H = @genero 
			WHERE Documento_H = @doc
			SET @id = (SELECT id_huesped FROM Huesped1 WHERE Documento_H = @doc) 
			UPDATE huesped_registro SET Id_Huesped = @id WHERE Id_HR = @id_HR
		COMMIT TRAN tran_c_factura
END TRY
BEGIN CATCH        
	   ROLLBACK TRAN tran_c_factura  
	   SELECT ERROR_NUMBER() AS errNumber
       , ERROR_SEVERITY() AS errSeverity  
       , ERROR_STATE() AS errState
       , ERROR_PROCEDURE() AS errProcedure
       , ERROR_LINE() AS errLine
       , ERROR_MESSAGE() AS errMessage
END CATCH

GO

CREATE PROCEDURE sp_e_huesped
@id INT
AS
DELETE Huesped_Registro WHERE Id_Huesped = @id
SELECT * FROM Huesped-----cambiar 1
GO


-----------------------------------------------------------------------
--------------------------------FACTURA--------------------------------
-----------------------------------------------------------------------

CREATE TABLE Factura
(
Id_Factura INT IDENTITY(1,1) PRIMARY KEY,
Fecha_Emision DATETIME,
Id_Usuario INT FOREIGN KEY REFERENCES Usuario(Id_Usuario)
)
GO

ALTER PROCEDURE sp_b_reg_cli_groupby
AS
SELECT CONVERT(VARCHAR(10), CAST(Fecha_Ingreso AS DATE)) 
+ '%' + CONVERT(VARCHAR(10), CAST(Fecha_Salida AS date)) 
+ '%' + Nombre AS F_Estadia, 
Nombre + ' - ' + CONVERT(VARCHAR(12),CAST(Fecha_Ingreso AS DATE),107) + ' hasta ' 
+ CONVERT(VARCHAR(12), CAST(Fecha_Salida AS date),107) AS Datos_Registro
FROM Registro_Cliente r INNER JOIN Cliente c ON r.Id_Cliente = c.Id_Cliente
WHERE Id_Usuario_Salida IS NOT NULL AND Fecha_Salida > GETDATE() - 21
GROUP BY CAST(Fecha_Ingreso AS DATE), CAST(Fecha_Salida AS DATE), Nombre
ORDER BY F_Estadia
GO

--execute sp_b_reg_cli_groupby
--drop procedure sp_b_reg_cli_groupby

CREATE PROCEDURE sp_b_reg_degroupby
@f_ing DATETIME,
@f_sal DATETIME,
@nombre VARCHAR(50)
AS
SELECT Id_Registro_Cliente FROM Registro_Cliente r INNER JOIN Cliente c ON r.Id_Cliente = c.Id_Cliente
WHERE Nombre = @nombre 
AND  CAST(Fecha_Ingreso AS DATE) = CAST(@f_ing AS DATE) 
AND CAST(Fecha_Salida AS DATE) = CAST(@f_sal AS DATE) 
GO


CREATE PROCEDURE sp_c_factura_2
@id_reg INT,
@id_fact INT
AS
UPDATE Registro_Cliente SET Id_Factura = @id_fact 
WHERE Id_Registro_Cliente = @id_reg;
GO

CREATE PROCEDURE sp_c_factura
@id_reg INT,
@f_emision DATETIME,
@id_usu INT
AS
BEGIN TRY      
       BEGIN TRAN tran_c_factura
          INSERT INTO Factura VALUES(@f_emision, @id_usu);
			UPDATE Registro_Cliente SET Id_Factura = (SELECT SCOPE_IDENTITY()) 
			WHERE Id_Registro_Cliente = @id_reg;
			SELECT SCOPE_IDENTITY() as Id_Ultima_Factura
			
       COMMIT TRAN tran_c_factura
END TRY
BEGIN CATCH        
	   ROLLBACK TRAN tran_c_factura  
	   SELECT ERROR_NUMBER() AS errNumber
       , ERROR_SEVERITY() AS errSeverity  
       , ERROR_STATE() AS errState
       , ERROR_PROCEDURE() AS errProcedure
       , ERROR_LINE() AS errLine
       , ERROR_MESSAGE() AS errMessage
END CATCH
GO


-- drop procedure sp_c_factura
--execute sp_c_factura '2017-11-01 12:00:00', 1


CREATE PROCEDURE sp_b_datos_factura
@id_reg INT
AS
SELECT r.Id_Factura, Fecha_Emision, Fecha_Ingreso,
Fecha_Salida, Nombre, Documento, Direccion, Correo,
Telefono1, Telefono2
FROM Factura f INNER JOIN Registro_Cliente r ON f.Id_Factura = r.Id_Factura
INNER JOIN Cliente c ON c.Id_Cliente = r.Id_Cliente
WHERE r.Id_Registro_Cliente = @id_reg
GO


CREATE TABLE Extra
(
Id_Extra INT IDENTITY(1,1) PRIMARY KEY,
Id_Factura INT FOREIGN KEY REFERENCES Factura(Id_Factura),
Descripcion VARCHAR(50),
Costo DECIMAL(9,2),
Cantidad DECIMAL(9,2)
)
GO

CREATE PROCEDURE sp_c_extra
@id_fac INT,
@descripcion VARCHAR(50),
@costo DECIMAL(9,2),
@cantidad DECIMAL(9,2)
AS
INSERT INTO Extra VALUES (@id_fac, @descripcion, @costo, @cantidad)
GO

CREATE PROCEDURE sp_b_extra
@id_fact INT
AS
SELECT * FROM Extra
Where Id_Factura = @id_fact
GO


--select * from registro_cliente
--select * from Usuario
--select * from Cliente
--select * from Registro_Cliente
--select * from Habitacion
--select * from Reserva
--select * from Posible_Reserva
--select * from Factura


--select Nombre + ' - ' + Codigo_Habitacion as Reserva, Id_Reserva , Fecha_Desde, Fecha_Hasta From Cliente c Inner Join Reserva r on c.Id_Cliente = r.Id_Cliente 
--Inner Join Habitacion h on r.Id_Habitacion = h.Id_Habitacion

--select Id_Reserva, Codigo_Habitacion, Fecha_Desde, Fecha_Hasta FROM Reserva r Inner Join Habitacion h on r.Id_Habitacion = h.Id_Habitacion
--ORDER BY Codigo_Habitacion


