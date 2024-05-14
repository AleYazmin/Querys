CREATE DATABASE VentasVehiculos
USE VentasVehiculos
GO

--TABLAS

CREATE TABLE Usuario(
id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
nombre VARCHAR(50) NOT NULL,
username VARCHAR(50) NOT NULL,
contraseña VARCHAR(50),
estatus BIT DEFAULT 1
)

CREATE TABLE Vehiculo(
id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
año INT NULL,
kilometraje INT NULL,
interior NVARCHAR(MAX)NULL,
idMarca INT,
idModelo INT,
idVersionAuto INT,
idCarroceria INT,
idTransmision INT,
idColor INT,
idVenta INT,
idUsuarioCrea INT,
idUsuarioModifica INT DEFAULT NULL,
fechaCrea DATETIME DEFAULT GETDATE(),
fechaModifica DATETIME DEFAULT NULL,
estatus BIT DEFAULT 1
)

CREATE TABLE Venta(
id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
vendedor NVARCHAR(MAX) NULL,
precioVenta INT NULL,
fechaVenta NVARCHAR(MAX) NULL,
idUsuarioCrea INT,
idUsuarioModifica INT DEFAULT NULL,
fechaCrea DATETIME DEFAULT GETDATE(),
fechaModifica DATETIME DEFAULT NULL,
estatus BIT DEFAULT 1
)

CREATE TABLE Marca(
id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
marca NVARCHAR(MAX) NULL,
idUsuarioCrea INT,
idUsuarioModifica INT DEFAULT NULL,
fechaCrea DATETIME DEFAULT GETDATE(),
fechaModifica DATETIME DEFAULT NULL,
estatus BIT DEFAULT 1
)
CREATE TABLE Modelo(
id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
modelo NVARCHAR(MAX) NULL,
idUsuarioCrea INT,
idUsuarioModifica INT DEFAULT NULL,
fechaCrea DATETIME DEFAULT GETDATE(),
fechaModifica DATETIME DEFAULT NULL,
estatus BIT DEFAULT 1
)

CREATE TABLE VersionAuto(
id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
versionAuto NVARCHAR(MAX) NULL,
idUsuarioCrea INT,
idUsuarioModifica INT DEFAULT NULL,
fechaCrea DATETIME DEFAULT GETDATE(),
fechaModifica DATETIME DEFAULT NULL,
estatus BIT DEFAULT 1
)

CREATE TABLE Carroceria(
id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
carroceria NVARCHAR(MAX) NULL,
idUsuarioCrea INT,
idUsuarioModifica INT DEFAULT NULL,
fechaCrea DATETIME DEFAULT GETDATE(),
fechaModifica DATETIME DEFAULT NULL,
estatus BIT DEFAULT 1
)

CREATE TABLE Transmision(
id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
transmision NVARCHAR(MAX) NULL,
idUsuarioCrea INT,
idUsuarioModifica INT DEFAULT NULL,
fechaCrea DATETIME DEFAULT GETDATE(),
fechaModifica DATETIME DEFAULT NULL,
esatus BIT DEFAULT 1
)

CREATE TABLE Color(
id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
color NVARCHAR(MAX) NULL,
idUsuarioCrea INT,
idUsuarioModifica INT DEFAULT NULL,
fechaCrea DATETIME DEFAULT GETDATE(),
fechaModifica DATETIME DEFAULT NULL,
estatus BIT DEFAULT 1
)

--Agregar llaves foraneas

ALTER TABLE Vehiculo
ADD CONSTRAINT FK_VehiculoMarca
FOREIGN KEY (idMarca) REFERENCES Marca(id)

ALTER TABLE Vehiculo
ADD CONSTRAINT FK_VehiculoModelo
FOREIGN KEY (idModelo) REFERENCES Modelo(id)

ALTER TABLE Vehiculo
ADD CONSTRAINT FK_VehiculoVersionAuto
FOREIGN KEY (idVersionAuto) REFERENCES VersionAuto(id)

ALTER TABLE Vehiculo
ADD CONSTRAINT FK_VehiculoCarroceria
FOREIGN KEY (idCarroceria) REFERENCES Carroceria(id)

ALTER TABLE Vehiculo
ADD CONSTRAINT FK_VehiculoTransmision
FOREIGN KEY (idTransmision) REFERENCES Transmision(id)

ALTER TABLE Vehiculo
ADD CONSTRAINT FK_VehiculoColor
FOREIGN KEY (idColor) REFERENCES Color(id)

ALTER TABLE Vehiculo
ADD CONSTRAINT FK_VehiculoVenta
FOREIGN KEY (idVenta) REFERENCES Venta(id)

--CONEXION CON TABLA USUARIO  

ALTER TABLE Vehiculo
ADD CONSTRAINT FK_VehiculoUsuarioCrea
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(id)

ALTER TABLE Vehiculo
ADD CONSTRAINT FK_VehiculoUsuarioModifica
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(id)

ALTER TABLE Venta
ADD CONSTRAINT FK_VentaUsuarioCrea
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(id)

ALTER TABLE Venta
ADD CONSTRAINT FK_VentaUsuarioModifica
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(id) 

ALTER TABLE Marca
ADD CONSTRAINT FK_MarcaUsuarioCrea
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(id)

ALTER TABLE Marca
ADD CONSTRAINT FK_MarcaUsuarioModifica
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(id) 

ALTER TABLE Modelo
ADD CONSTRAINT FK_ModeloUsuarioCrea
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(id)

ALTER TABLE Modelo
ADD CONSTRAINT FK_ModeloUsuarioModifica
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(id)

ALTER TABLE VersionAuto
ADD CONSTRAINT FK_VersionAutoUsuarioCrea
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(id)

ALTER TABLE VersionAuto
ADD CONSTRAINT FK_VersionAutoUsuarioModifica
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(id)

ALTER TABLE Carroceria
ADD CONSTRAINT FK_CarroceriaUsuarioCrea
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(id)

ALTER TABLE Carroceria
ADD CONSTRAINT FK_CarroceriaUsuarioModifica
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(id)

ALTER TABLE Transmision
ADD CONSTRAINT FK_TransmisionUsuarioCrea
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(id)

ALTER TABLE Transmision
ADD CONSTRAINT FK_TransmisionUsuarioModifica
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(id)

ALTER TABLE Color
ADD CONSTRAINT FK_ColorUsuarioCrea
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(id)

ALTER TABLE Color
ADD CONSTRAINT FK_ColorUsuarioModifica
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(id)

--INDEX

CREATE INDEX IX_Usuario ON usuario(id)

CREATE INDEX IX_Vehiculo ON Vehiculo(id)

CREATE INDEX IX_Venta ON Venta(id)

CREATE INDEX IX_Marca ON Marca(id)

CREATE INDEX IX_Modelo ON Modelo(id)

CREATE INDEX IX_VersionAuto ON VersionAuto(id)

CREATE INDEX IX_Carroceria ON Carroceria(id)

CREATE INDEX IX_Transmision ON Transmision(id)

CREATE INDEX IX_Color ON Color(id)

--POBLAR

INSERT INTO Usuario (nombre, username, contraseña)
VALUES ('Admin','admin',CONVERT(NVARCHAR(50), HASHBYTES('SHA1','admin'),1))

INSERT INTO Vehiculo (año, kilometraje, interior, idMarca, idModelo, idVersionAuto, idCarroceria, idTransmision, idColor, idVenta, idUsuarioCrea)
SELECT DISTINCT year, odometer, interior,
(SELECT id FROM Marca WHERE marca=make) AS Marca,
(SELECT id FROM Modelo WHERE modelo=model) AS Modelo,
(SELECT id FROM VersionAuto WHERE versionAuto=trim) AS VersionAuto,
(SELECT id FROM Carroceria WHERE carroceria=body) AS Carroceria,
(SELECT id FROM Transmision WHERE transmision=transmission) AS Transmision,
(SELECT MAX(id) FROM Color WHERE color=color) AS Color,
(SELECT MAX(id) FROM Venta WHERE vendedor=seller) AS Venta,
1 AS idUsuario 
FROM VentasVehiculos 

select * from Usuario
INSERT INTO Venta (vendedor, precioVenta, fechaVenta, idUsuarioCrea)
SELECT DISTINCT seller, sellingprice, saledate, 1 FROM VentasVehiculos 

INSERT INTO Marca (marca, idUsuarioCrea)
SELECT DISTINCT make, 1 FROM VentasVehiculos 

INSERT INTO Modelo (modelo, idUsuarioCrea)
SELECT DISTINCT model, 1 FROM VentasVehiculos

INSERT INTO VersionAuto (versionAuto, idUsuarioCrea)
SELECT DISTINCT trim, 1 FROM VentasVehiculos

INSERT INTO Carroceria (carroceria, idUsuarioCrea)
SELECT DISTINCT body, 1 FROM VentasVehiculos

INSERT INTO Transmision (transmision, idUsuarioCrea)
SELECT DISTINCT transmission, 1 FROM VentasVehiculos 

INSERT INTO Color (color, idUsuarioCrea)
SELECT DISTINCT color, 1 FROM VentasVehiculos

select * from Vehiculo
--STORE PROCEDURE 

CREATE PROCEDURE SP_InsertarVehiculo
    @año INT,
    @kilometraje INT,
    @interior NVARCHAR(MAX),
    @idMarca INT,
    @idModelo INT,
    @idVersionAuto INT,
    @idCarroceria INT,
    @idTransmision INT,
    @idColor INT,
    @idVenta INT,
    @idUsuarioCrea INT
AS
BEGIN
    INSERT INTO Vehiculo (año, kilometraje, interior, idMarca, idModelo, idVersionAuto, idCarroceria, idTransmision, idColor, idVenta, idUsuarioCrea)
    VALUES (@año, @kilometraje, @interior, @idMarca, @idModelo, @idVersionAuto, @idCarroceria, @idTransmision, @idColor, @idVenta, @idUsuarioCrea)
END
GO

--Store Procedure
--ACTUALIZAR

CREATE PROCEDURE SP_ActualizarVehiculo
    @id INT,
    @año INT,
    @kilometraje INT,
    @interior NVARCHAR(MAX),
    @idMarca INT,
    @idModelo INT,
    @idVersionAuto INT,
    @idCarroceria INT,
    @idTransmision INT,
    @idColor INT,
    @idVenta INT,
    @idUsuarioModifica INT
AS
BEGIN
    UPDATE Vehiculo
    SET año = @año,
        kilometraje = @kilometraje,
        interior = @interior,
        idMarca = @idMarca,
        idModelo = @idModelo,
        idVersionAuto = @idVersionAuto,
        idCarroceria = @idCarroceria,
        idTransmision = @idTransmision,
        idColor = @idColor,
        idVenta = @idVenta,
        idUsuarioModifica = @idUsuarioModifica,
        fechaModifica = GETDATE()
    WHERE id = @id
END
GO

--LEER

CREATE PROCEDURE SP_BuscarVehiculoPorID
    @vehiculoID INT
AS
BEGIN
    SELECT id, año, kilometraje, interior, idMarca, idModelo, idVersionAuto, idCarroceria, idTransmision, idColor, idVenta, idUsuarioCrea, idUsuarioModifica, fechaCrea, fechaModifica, estatus
    FROM Vehiculo
    WHERE id = @vehiculoID;
END
GO


--ELIMINAR

CREATE PROCEDURE SP_EliminarVehiculo
    @vehiculoId INT
AS
BEGIN
    -- Actualizar el estado del vehículo a 0
    UPDATE Vehiculo
    SET estatus = 0
    WHERE id = @vehiculoId;
END

GO

--SP INSERTAR DE TABLA VENTAS

CREATE PROCEDURE SP_InsertarVenta
    @vendedor NVARCHAR(MAX),
    @precioVenta INT,
    @fechaVenta NVARCHAR(MAX),
    @idUsuarioCrea INT
AS
BEGIN
    INSERT INTO Venta (vendedor, precioVenta, fechaVenta, idUsuarioCrea)
    VALUES (@vendedor, @precioVenta, @fechaVenta, @idUsuarioCrea)
END
GO
--SP ACTUALIZAR DE TABLA Venta 

CREATE PROCEDURE SP_ActualizarVenta
    @id INT,
    @vendedor NVARCHAR(MAX),
    @precioVenta INT,
    @fechaVenta NVARCHAR(MAX),
    @idUsuarioModifica INT
AS
BEGIN
    UPDATE Venta
    SET vendedor = @vendedor,
        precioVenta = @precioVenta,
        fechaVenta = @fechaVenta,
        idUsuarioModifica = @idUsuarioModifica,
        fechaModifica = GETDATE()
    WHERE id = @id
END
GO

--SP LEER DE TABLA Venta

CREATE PROCEDURE SP_LeerVenta
AS
BEGIN
    SELECT id, vendedor, precioVenta, fechaVenta, idUsuarioCrea, idUsuarioModifica, fechaCrea, fechaModifica, estatus
    FROM Venta
END
GO

--SP ELIMINAR DE TABLA Venta

CREATE PROCEDURE SP_EliminarVenta
    @id INT
AS
BEGIN
    DELETE FROM Venta
    WHERE id = @id
END
GO

--SP INSERTAR DE TABLA Marca

CREATE PROCEDURE SP_InsertarMarca
    @marca NVARCHAR(MAX),
    @idUsuarioCrea INT
AS
BEGIN
    INSERT INTO Marca (marca, idUsuarioCrea)
    VALUES (@marca, @idUsuarioCrea)
END
GO

--SP ACTUALIZAR DE TABLA Marca

CREATE PROCEDURE SP_ActualizarMarca
    @id INT,
    @marca NVARCHAR(MAX),
    @idUsuarioModifica INT
AS
BEGIN
    UPDATE Marca
    SET marca = @marca,
        idUsuarioModifica = @idUsuarioModifica,
        fechaModifica = GETDATE()
    WHERE id = @id
END
GO

--SP LEER DE TABLA Marca

CREATE PROCEDURE SP_LeerMarca
AS
BEGIN
    SELECT id, marca, idUsuarioCrea, idUsuarioModifica, fechaCrea, fechaModifica, estatus
    FROM Marca
END
GO

--SP ELIMINAR DE TABLA Marca

CREATE PROCEDURE SP_EliminarMarca
    @id INT
AS
BEGIN
    DELETE FROM Marca
    WHERE id = @id
END
GO

--SP INSERTAR DE TABLA Modelo

CREATE PROCEDURE SP_InsertarModelo
    @modelo NVARCHAR(MAX),
    @idUsuarioCrea INT
AS
BEGIN
    INSERT INTO Modelo (modelo, idUsuarioCrea)
    VALUES (@modelo, @idUsuarioCrea)
END
GO

--SP ACTUALIZAR DE TABLA Modelo

CREATE PROCEDURE SP_ActualizarModelo
    @id INT,
    @modelo NVARCHAR(MAX),
    @idUsuarioModifica INT
AS
BEGIN
    UPDATE Modelo
    SET modelo = @modelo,
        idUsuarioModifica = @idUsuarioModifica,
        fechaModifica = GETDATE()
    WHERE id = @id
END
GO

--SP LEER DE TABLA Modelo

CREATE PROCEDURE SP_LeerModelo
AS
BEGIN
    SELECT id, modelo, idUsuarioCrea, idUsuarioModifica, fechaCrea, fechaModifica, estatus
    FROM Modelo
END
GO

--SP ELIMINAR DE TABLA Modelo

CREATE PROCEDURE SP_EliminarModelo
    @id INT
AS
BEGIN
    DELETE FROM Modelo
    WHERE id = @id
END
GO

--SP INSERTAR DE TABLA VersionAuto

CREATE PROCEDURE SP_InsertarVersionAuto
    @versionAuto NVARCHAR(MAX),
    @idUsuarioCrea INT
AS
BEGIN
    INSERT INTO VersionAuto (versionAuto, idUsuarioCrea)
    VALUES (@versionAuto, @idUsuarioCrea)
END
GO

--SP ACTUALIZAR DE TABLA VersionAuto

CREATE PROCEDURE SP_ActualizarVersionAuto
    @id INT,
    @versionAuto NVARCHAR(MAX),
    @idUsuarioModifica INT
AS
BEGIN
    UPDATE VersionAuto
    SET versionAuto = @versionAuto,
        idUsuarioModifica = @idUsuarioModifica,
        fechaModifica = GETDATE()
    WHERE id = @id
END
GO

--SP LEER DE TABLA VersionAuto

CREATE PROCEDURE SP_LeerVersionAuto
AS
BEGIN
    SELECT id, versionAuto, idUsuarioCrea, idUsuarioModifica, fechaCrea, fechaModifica, estatus
    FROM VersionAuto
END
GO

--SP ELIMINAR DE TABLA VersionAuto

CREATE PROCEDURE SP_EliminarVersionAuto
    @id INT
AS
BEGIN
    DELETE FROM VersionAuto
    WHERE id = @id
END
GO

--SP INSERTAR DE TABLA Carroceria

CREATE PROCEDURE SP_InsertarCarroceria
    @carroceria NVARCHAR(MAX),
    @idUsuarioCrea INT
AS
BEGIN
    INSERT INTO Carroceria (carroceria, idUsuarioCrea)
    VALUES (@carroceria, @idUsuarioCrea)
END
GO

--SP ACTUALIZAR DE TABLA Carroceria

CREATE PROCEDURE SP_ActualizarCarroceria
    @id INT,
    @carroceria NVARCHAR(MAX),
    @idUsuarioModifica INT
AS
BEGIN
    UPDATE Carroceria
    SET carroceria = @carroceria,
        idUsuarioModifica = @idUsuarioModifica,
        fechaModifica = GETDATE()
    WHERE id = @id
END
GO

--SP LEER DE TABLA Carroceria

CREATE PROCEDURE SP_LeerCarroceria
AS
BEGIN
    SELECT id, carroceria, idUsuarioCrea, idUsuarioModifica, fechaCrea, fechaModifica, estatus
    FROM Carroceria
END
GO

--SP ELIMINAR DE TABLA Carroceria

CREATE PROCEDURE SP_EliminarCarroceria
    @id INT
AS
BEGIN
    DELETE FROM VersionAuto
    WHERE id = @id
END
GO

--SP INSERTAR DE TABLA Transmision

CREATE PROCEDURE SP_InsertarTransmision
    @transmision NVARCHAR(MAX),
    @idUsuarioCrea INT
AS
BEGIN
    INSERT INTO Transmision (transmision, idUsuarioCrea)
    VALUES (@transmision, @idUsuarioCrea)
END
GO

--SP ACTUALIZAR DE TABLA Transmision

CREATE PROCEDURE SP_ActualizarTransmision
    @id INT,
    @transmision NVARCHAR(MAX),
    @idUsuarioModifica INT
AS
BEGIN
    UPDATE Transmision
    SET transmision = @transmision,
        idUsuarioModifica = @idUsuarioModifica,
        fechaModifica = GETDATE()
    WHERE id = @id
END
GO

--SP LEER DE TABLA TABLA Transmision

CREATE PROCEDURE SP_LeerTransmision
AS
BEGIN
    SELECT id, transmision, idUsuarioCrea, idUsuarioModifica, fechaCrea, fechaModifica, esatus
    FROM Transmision
END
GO

--SP ELIMINAR DE TABLA Transmision

CREATE PROCEDURE SP_EliminarTransmision
    @id INT
AS
BEGIN
    DELETE FROM Transmision
    WHERE id = @id
END
GO

--SP INSERTAR DE TABLA Color

CREATE PROCEDURE SP_InsertarColor
    @color NVARCHAR(MAX),
    @idUsuarioCrea INT
AS
BEGIN
    INSERT INTO Color (color, idUsuarioCrea)
    VALUES (@color, @idUsuarioCrea)
END
GO

--SP ACTUALIZAR DE TABLA Color

CREATE PROCEDURE SP_ActualizarColor
    @id INT,
    @color NVARCHAR(MAX),
    @idUsuarioModifica INT
AS
BEGIN
    UPDATE Color
    SET color = @color,
        idUsuarioModifica = @idUsuarioModifica,
        fechaModifica = GETDATE()
    WHERE id = @id
END
GO

--SP LEER DE TABLA Color

CREATE PROCEDURE SP_LeerColor
AS
BEGIN
    SELECT id, color, idUsuarioCrea, idUsuarioModifica, fechaCrea, fechaModifica, estatus
    FROM Color
END
GO

--SP ELIMINAR DE TABLA Color

CREATE PROCEDURE SP_EliminarColor
    @id INT
AS
BEGIN
    DELETE FROM Color
    WHERE id = @id
END
GO

--RESEED
DBCC CHECKIDENT ('ZONA', RESEED, 0)
GO

--VIEW

CREATE VIEW VW_vehiculosBusqueda
AS
select Vehiculo.id, Vehiculo.año AS [Año], Vehiculo.kilometraje AS [Kilometraje],Vehiculo.interior AS [Interior],
Modelo.modelo AS [Modelo],
Marca.marca AS [Marca],
Transmision.transmision AS [Transmision],
Carroceria.carroceria AS [Carroceria], 
Color.color AS [Color],
VersionAuto.versionAuto AS [Version],
venta.vendedor AS [Vendedor], venta.precioVenta AS [Precio de venta], venta.fechaVenta AS [Fecha de Venta],
vehiculo.estatus
from Vehiculo
inner join Modelo ON Vehiculo.idModelo=Modelo.id
inner join Marca ON Vehiculo.idMarca=Marca.id
inner join Transmision ON Vehiculo.idTransmision=Transmision.id
inner join Carroceria ON Vehiculo.idCarroceria=Carroceria.id
INNER JOIN Color ON Vehiculo.idColor=Color.id
inner join VersionAuto ON Vehiculo.idVersionAuto=VersionAuto.id
INNER JOIN Venta ON Vehiculo.idVenta=Venta.id
--sp_helptext VW_VentaVehiculoBusqueda
--sp_depends VW_VentaVehiculoBusqueda
select * from VentasVehiculos

SELECT * FROM VW_vehiculosBusqueda WHERE marca = 'Honda'
marcaSeleccionada