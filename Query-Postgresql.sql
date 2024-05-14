-- Crear la base de datos
CREATE DATABASE VentasVehiculos;

-- Cambiar al nuevo DB
\c VentasVehiculos;

-- TABLAS

CREATE TABLE PUBLIC.VentasVehiculos (
    year SMALLINT,
    make TEXT,
    model TEXT,
    trim TEXT,
    body TEXT,
    transmission TEXT,
    vin TEXT,
    state TEXT,
    condition INT,
    odometer INT,
    color TEXT,
    interior TEXT,
    seller TEXT,
    mmr INT,
    sellingprice INT,
    saledate TEXT
);

CREATE TABLE Usuario (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    username VARCHAR(50) NOT NULL,
    contraseña VARCHAR(50),
    estatus BOOLEAN DEFAULT TRUE
);

CREATE TABLE Vehiculo (
    id SERIAL PRIMARY KEY,
    año INT,
    kilometraje INT,
    interior TEXT,
    idMarca INT,
    idModelo INT,
    idVersionAuto INT,
    idCarroceria INT,
    idTransmision INT,
    idColor INT,
    idVenta INT,
    idUsuarioCrea INT,
    idUsuarioModifica INT DEFAULT NULL,
    fechaCrea TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fechaModifica TIMESTAMP DEFAULT NULL,
    estatus BOOLEAN DEFAULT TRUE
);

CREATE TABLE Venta (
    id SERIAL PRIMARY KEY,
    vendedor TEXT,
    precioVenta INT,
    fechaVenta TEXT,
    idUsuarioCrea INT,
    idUsuarioModifica INT DEFAULT NULL,
    fechaCrea TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fechaModifica TIMESTAMP DEFAULT NULL,
    estatus BOOLEAN DEFAULT TRUE
);

CREATE TABLE Marca (
    id SERIAL PRIMARY KEY,
    marca TEXT,
    idUsuarioCrea INT,
    idUsuarioModifica INT DEFAULT NULL,
    fechaCrea TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fechaModifica TIMESTAMP DEFAULT NULL,
    estatus BOOLEAN DEFAULT TRUE
);

CREATE TABLE Modelo (
    id SERIAL PRIMARY KEY,
    modelo TEXT,
    idUsuarioCrea INT,
    idUsuarioModifica INT,
    fechaCrea TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fechaModifica TIMESTAMP WITH TIME ZONE,
    estatus BOOLEAN DEFAULT TRUE
);

CREATE TABLE VersionAuto (
    id SERIAL PRIMARY KEY,
    versionAuto TEXT,
    idUsuarioCrea INT,
    idUsuarioModifica INT,
    fechaCrea TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fechaModifica TIMESTAMP WITH TIME ZONE,
    estatus BOOLEAN DEFAULT TRUE
);

CREATE TABLE Carroceria (
    id SERIAL PRIMARY KEY,
    carroceria TEXT,
    idUsuarioCrea INT,
    idUsuarioModifica INT,
    fechaCrea TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fechaModifica TIMESTAMP WITH TIME ZONE,
    estatus BOOLEAN DEFAULT TRUE
);

CREATE TABLE Transmision (
    id SERIAL PRIMARY KEY,
    transmision TEXT,
    idUsuarioCrea INT,
    idUsuarioModifica INT,
    fechaCrea TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fechaModifica TIMESTAMP WITH TIME ZONE,
    estatus BOOLEAN DEFAULT TRUE
);

CREATE TABLE Color (
    id SERIAL PRIMARY KEY,
    color TEXT,
    idUsuarioCrea INT,
    idUsuarioModifica INT,
    fechaCrea TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fechaModifica TIMESTAMP WITH TIME ZONE,
    estatus BOOLEAN DEFAULT TRUE
);

-- Agregar llaves foráneas

ALTER TABLE Vehiculo
ADD CONSTRAINT FK_VehiculoMarca
FOREIGN KEY (idMarca) REFERENCES Marca(id);

ALTER TABLE Vehiculo
ADD CONSTRAINT FK_VehiculoModelo
FOREIGN KEY (idModelo) REFERENCES Modelo(id);

ALTER TABLE Vehiculo
ADD CONSTRAINT FK_VehiculoVersionAuto
FOREIGN KEY (idVersionAuto) REFERENCES VersionAuto(id);

ALTER TABLE Vehiculo
ADD CONSTRAINT FK_VehiculoCarroceria
FOREIGN KEY (idCarroceria) REFERENCES Carroceria(id);

ALTER TABLE Vehiculo
ADD CONSTRAINT FK_VehiculoTransmision
FOREIGN KEY (idTransmision) REFERENCES Transmision(id);

ALTER TABLE Vehiculo
ADD CONSTRAINT FK_VehiculoColor
FOREIGN KEY (idColor) REFERENCES Color(id);

ALTER TABLE Vehiculo
ADD CONSTRAINT FK_VehiculoVenta
FOREIGN KEY (idVenta) REFERENCES Venta(id);

-- CONEXIÓN CON LA TABLA USUARIO

ALTER TABLE Vehiculo
ADD CONSTRAINT FK_VehiculoUsuarioCrea
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(id);

ALTER TABLE Vehiculo
ADD CONSTRAINT FK_VehiculoUsuarioModifica
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(id);

ALTER TABLE Venta
ADD CONSTRAINT FK_VentaUsuarioCrea
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(id);

ALTER TABLE Venta
ADD CONSTRAINT FK_VentaUsuarioModifica
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(id);

ALTER TABLE Marca
ADD CONSTRAINT FK_MarcaUsuarioCrea
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(id);

ALTER TABLE Marca
ADD CONSTRAINT FK_MarcaUsuarioModifica
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(id);

ALTER TABLE Modelo
ADD CONSTRAINT FK_ModeloUsuarioCrea
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(id);

ALTER TABLE Modelo
ADD CONSTRAINT FK_ModeloUsuarioModifica
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(id);

ALTER TABLE VersionAuto
ADD CONSTRAINT FK_VersionAutoUsuarioCrea
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(id);

ALTER TABLE VersionAuto
ADD CONSTRAINT FK_VersionAutoUsuarioModifica
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(id);

ALTER TABLE Carroceria
ADD CONSTRAINT FK_CarroceriaUsuarioCrea
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(id);

ALTER TABLE Carroceria
ADD CONSTRAINT FK_CarroceriaUsuarioModifica
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(id);

ALTER TABLE Transmision
ADD CONSTRAINT FK_TransmisionUsuarioCrea
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(id);

ALTER TABLE Transmision
ADD CONSTRAINT FK_TransmisionUsuarioModifica
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(id);

ALTER TABLE Color
ADD CONSTRAINT FK_ColorUsuarioCrea
FOREIGN KEY (idUsuarioCrea) REFERENCES Usuario(id);

ALTER TABLE Color
ADD CONSTRAINT FK_ColorUsuarioModifica
FOREIGN KEY (idUsuarioModifica) REFERENCES Usuario(id);

-- ÍNDICES

CREATE INDEX IX_Usuario ON Usuario(id);

CREATE INDEX IX_Vehiculo ON Vehiculo(id);

CREATE INDEX IX_Venta ON Venta(id);

CREATE INDEX IX_Marca ON Marca(id);

CREATE INDEX IX_Modelo ON Modelo(id);

CREATE INDEX IX_VersionAuto ON VersionAuto(id);

CREATE INDEX IX_Carroceria ON Carroceria(id);

CREATE INDEX IX_Transmision ON Transmision(id);

CREATE INDEX IX_Color ON Color(id);

--REINICIA SEMILLA 
SELECT pg_get_serial_sequence('Usuario', 'id');
ALTER SEQUENCE public.usuario_id_seq RESTART WITH 1;

--POBLAR

INSERT INTO Usuario (nombre, username, contraseña, estatus)
VALUES ('Admin', 'admin', 'c27ef4184b1ca67f8586e37271ea2c401b7171f8', TRUE);

INSERT INTO Vehiculo (año, kilometraje, interior, idMarca, idModelo, idVersionAuto, idCarroceria, idTransmision, idColor, idVenta, idUsuarioCrea)
SELECT DISTINCT year, odometer, interior,
(SELECT id FROM Marca WHERE marca=make LIMIT 1) AS idMarca,
(SELECT id FROM Modelo WHERE modelo=model LIMIT 1) AS idModelo,
(SELECT id FROM VersionAuto WHERE versionAuto=trim LIMIT 1) AS idVersionAuto,
(SELECT id FROM Carroceria WHERE carroceria=body LIMIT 1) AS idCarroceria,
(SELECT id FROM Transmision WHERE transmision=transmission LIMIT 1) AS idTransmision,
(SELECT MAX(id) FROM Color WHERE color=color LIMIT 1) AS idColor,
(SELECT MAX(id) FROM Venta WHERE vendedor=seller LIMIT 1) AS idVenta,
1 AS idUsuarioCrea 
FROM VentasVehiculos;
select * from Vehiculo;
INSERT INTO Venta (vendedor, precioVenta, fechaVenta, idUsuarioCrea)
SELECT DISTINCT seller, sellingprice, saledate, 1 FROM VentasVehiculos;

INSERT INTO Marca (marca, idUsuarioCrea)
SELECT DISTINCT make, 1 FROM VentasVehiculos;

INSERT INTO Modelo (modelo, idUsuarioCrea)
SELECT DISTINCT model, 1 FROM VentasVehiculos;

INSERT INTO VersionAuto (versionAuto, idUsuarioCrea)
SELECT DISTINCT trim, 1 FROM VentasVehiculos;

INSERT INTO Carroceria (carroceria, idUsuarioCrea)
SELECT DISTINCT body, 1 FROM VentasVehiculos;

INSERT INTO Transmision (transmision, idUsuarioCrea)
SELECT DISTINCT transmission, 1 FROM VentasVehiculos;

INSERT INTO Color (color, idUsuarioCrea)
SELECT DISTINCT color, 1 FROM VentasVehiculos;

-- STORE PROCEDURE PARA INSERTAR VEHÍCULO

CREATE OR REPLACE PROCEDURE SP_InsertarVehiculo(
    año INT,
    kilometraje INT,
    interior TEXT,
    idMarca INT,
    idModelo INT,
    idVersionAuto INT,
    idCarroceria INT,
    idTransmision INT,
    idColor INT,
    idVenta INT,
    idUsuarioCrea INT
)
AS $$
BEGIN
    INSERT INTO Vehiculo (año, kilometraje, interior, idMarca, idModelo, idVersionAuto, idCarroceria, idTransmision, idColor, idVenta, idUsuarioCrea)
    VALUES (año, kilometraje, interior, idMarca, idModelo, idVersionAuto, idCarroceria, idTransmision, idColor, idVenta, idUsuarioCrea);
END;
$$ LANGUAGE plpgsql;

-- STORE PROCEDURE PARA ACTUALIZAR VEHÍCULO

CREATE OR REPLACE PROCEDURE SP_ActualizarVehiculo(
    id INT,
    año INT,
    kilometraje INT,
    interior TEXT,
    idMarca INT,
    idModelo INT,
    idVersionAuto INT,
    idCarroceria INT,
    idTransmision INT,
    idColor INT,
    idVenta INT,
    idUsuarioModifica INT
)
AS $$
BEGIN
    UPDATE Vehiculo
    SET año = año,
        kilometraje = kilometraje,
        interior = interior,
        idMarca = idMarca,
        idModelo = idModelo,
        idVersionAuto = idVersionAuto,
        idCarroceria = idCarroceria,
        idTransmision = idTransmision,
        idColor = idColor,
        idVenta = idVenta,
        idUsuarioModifica = idUsuarioModifica,
        fechaModifica = CURRENT_TIMESTAMP
    WHERE id = id;
END;
$$ LANGUAGE plpgsql;

-- STORE PROCEDURE PARA LEER VEHÍCULO

CREATE OR REPLACE FUNCTION SP_LeerVehiculo()
RETURNS TABLE (
    id INT,
    año INT,
    kilometraje INT,
    interior TEXT,
    idMarca INT,
    idModelo INT,
    idVersionAuto INT,
    idCarroceria INT,
    idTransmision INT,
    idColor INT,
    idVenta INT,
    idUsuarioCrea INT,
    idUsuarioModifica INT,
    fechaCrea TIMESTAMP,
    fechaModifica TIMESTAMP,
    estatus BOOLEAN
)
AS $$
BEGIN
    RETURN QUERY SELECT id, año, kilometraje, interior, idMarca,
	idModelo, idVersionAuto, idCarroceria, idTransmision, idColor, idVenta,
	idUsuarioCrea, idUsuarioModifica, fechaCrea, fechaModifica, estatus FROM Vehiculo;
END;
$$ LANGUAGE plpgsql;

-- STORE PROCEDURE PARA ELIMINAR VEHÍCULO

CREATE OR REPLACE PROCEDURE SP_EliminarVehiculo(
    id INT
)
AS $$
BEGIN
    DELETE FROM Vehiculo
    WHERE id = id;
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE INSERTAR VENTA
CREATE OR REPLACE PROCEDURE SP_InsertarVenta(
    IN vendedor TEXT,
    IN precioVenta INT,
    IN fechaVenta TEXT,
    IN idUsuarioCrea INT
)
AS $$
BEGIN
    INSERT INTO Venta (vendedor, precioVenta, fechaVenta, idUsuarioCrea)
    VALUES (vendedor, precioVenta, fechaVenta, idUsuarioCrea);
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE ACTUALIZAR VENTA
CREATE OR REPLACE PROCEDURE SP_ActualizarVenta(
    IN id INT,
    IN vendedor TEXT,
    IN precioVenta INT,
    IN fechaVenta TEXT,
    IN idUsuarioModifica INT
)
AS $$
BEGIN
    UPDATE Venta
    SET vendedor = vendedor,
        precioVenta = precioVenta,
        fechaVenta = fechaVenta,
        idUsuarioModifica = idUsuarioModifica,
        fechaModifica = CURRENT_TIMESTAMP
    WHERE id = id;
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE LEER VENTA

CREATE OR REPLACE FUNCTION SP_LeerVenta()
	RETURNS TABLE(
	id INT,
	vendedor TEXT,
	precioVenta INT,
	fechaVenta TEXT,
	idUsuarioCrea INT,
	idUsuarioModifica INT,
	fechaCrea TIMESTAMP,
	fechaModifica TIMESTAMP,
	estatus BOOLEAN
)
AS $$
BEGIN
	RETURN QUERY SELECT id, vendedor, precioVenta, fechaVenta, idUsuarioCrea,
	idUsuarioModifica, fechaCrea, fechaModifica , estatus FROM Venta;
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE ELIMINAR VENTA
CREATE OR REPLACE PROCEDURE SP_EliminarVenta(
    IN id INT
)
AS $$
BEGIN
    DELETE FROM Venta
    WHERE id = id;
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE INSERTAR MARCA

CREATE OR REPLACE PROCEDURE SP_InsertarMarca(
    IN marca TEXT,
    IN idUsuarioCrea INT
)
AS $$
BEGIN
    INSERT INTO Marca (marca, idUsuarioCrea)
    VALUES (marca, idUsuarioCrea);
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE ACTUALIZAR MARCA

CREATE OR REPLACE PROCEDURE SP_ActualizarMarca(
    IN id INT,
    IN marca TEXT,
    IN idUsuarioModifica INT
)
AS $$
BEGIN
    UPDATE Marca
    SET marca = marca,
        idUsuarioModifica = idUsuarioModifica,
        fechaModifica = CURRENT_TIMESTAMP
    WHERE id = id;
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE LEER MARCA

CREATE OR REPLACE FUNCTION SP_LeerMarca()
	RETURNS TABLE(
	id INT,
	marca TEXT,
	idUsuarioCrea INT,
	idUsuarioModifica INT,
	fechaCrea TIMESTAMP,
	fechaModifica TIMESTAMP,
	estatus BOOLEAN
)
AS $$
BEGIN
	RETURN QUERY SELECT id, marca, idUsuarioCrea, idUsuarioModifica,
	fechaCrea, fechaModifica , estatus FROM Marca;
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE ELIMINAR MARCA

CREATE OR REPLACE PROCEDURE SP_EliminarMarca(
    IN id INT
)
AS $$
BEGIN
    DELETE FROM Marca
    WHERE id = id;
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE INSERTAR MODELO

CREATE OR REPLACE PROCEDURE SP_InsertarModelo(
    IN modelo TEXT,
    IN idUsuarioCrea INT
)
AS $$
BEGIN
    INSERT INTO Modelo (modelo, idUsuarioCrea)
    VALUES (modelo, idUsuarioCrea);
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE ACTUALIZAR MODELO

CREATE OR REPLACE PROCEDURE SP_ActualizarModelo(
    IN id INT,
    IN modelo TEXT,
    IN idUsuarioModifica INT
)
AS $$
BEGIN
    UPDATE Modelo
    SET modelo = modelo,
        idUsuarioModifica = idUsuarioModifica,
        fechaModifica = CURRENT_TIMESTAMP
    WHERE id = id;
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE LEER MODELO

CREATE OR REPLACE FUNCTION SP_LeerModelo()
	RETURNS TABLE(
	id INT,
	modelo TEXT,
	idUsuarioCrea INT,
	idUsuarioModifica INT,
	fechaCrea TIMESTAMP,
	fechaModifica TIMESTAMP,
	estatus BOOLEAN
)
AS $$
BEGIN
	RETURN QUERY SELECT id, marca, idUsuarioCrea, idUsuarioModifica,
	fechaCrea, fechaModifica , estatus FROM Modelo;
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE ELIMINAR MODELO

CREATE OR REPLACE PROCEDURE SP_EliminarModelo(
    IN id INT
)
AS $$
BEGIN
    DELETE FROM Modelo
    WHERE id = id;
END;
$$ LANGUAGE plpgsql;


--STORE PROCEDURE INSERTAR VERSIONAUTO

CREATE OR REPLACE PROCEDURE SP_InsertarVersionAuto(
    IN versionAuto TEXT,
    IN idUsuarioCrea INT
)
AS $$
BEGIN
    INSERT INTO VersionAuto (versionAuto, idUsuarioCrea)
    VALUES (versionAuto, idUsuarioCrea);
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE ACTUALIZAR VERSIONAUTO

CREATE OR REPLACE PROCEDURE SP_ActualizarVersionAuto(
    IN id INT,
    IN versionAuto TEXT,
    IN idUsuarioModifica INT
)
AS $$
BEGIN
    UPDATE VersionAuto
    SET versionAuto = versionAuto,
        idUsuarioModifica = idUsuarioModifica,
        fechaModifica = CURRENT_TIMESTAMP
    WHERE id = id;
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE LEER VERSIONAUTO

CREATE OR REPLACE FUNCTION SP_LeerVersionAuto()
	RETURNS TABLE(
	id INT,
	versionAuto TEXT,
	idUsuarioCrea INT,
	idUsuarioModifica INT,
	fechaCrea TIMESTAMP,
	fechaModifica TIMESTAMP,
	estatus BOOLEAN
)
AS $$
BEGIN
	RETURN QUERY SELECT id, versionAuto, idUsuarioCrea, idUsuarioModifica,
	fechaCrea, fechaModifica , estatus FROM VersionAuto;
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE ELIMINAR VERSIONAUTO

CREATE OR REPLACE PROCEDURE SP_EliminarVersionAuto(
    IN id INT
)
AS $$
BEGIN
    DELETE FROM VersionAuto
    WHERE id = id;
END;
$$ LANGUAGE plpgsql;


--STORE PROCEDURE INSERTAR CARROCERIA

CREATE OR REPLACE PROCEDURE SP_InsertarCarroceria(
    IN carroceria TEXT,
    IN idUsuarioCrea INT
)
AS $$
BEGIN
    INSERT INTO Carroceria (carroceria, idUsuarioCrea)
    VALUES (carroceria, idUsuarioCrea);
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE ACTUALIZAR CARROCERIA

CREATE OR REPLACE PROCEDURE SP_ActualizarCarroceria(
    IN id INT,
    IN carroceria TEXT,
    IN idUsuarioModifica INT
)
AS $$
BEGIN
    UPDATE Carroceria
    SET carroceria = carroceria,
        idUsuarioModifica = idUsuarioModifica,
        fechaModifica = CURRENT_TIMESTAMP
    WHERE id = id;
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE LEER CARROCERIA

CREATE OR REPLACE FUNCTION SP_LeerCarroceria()
	RETURNS TABLE(
	id INT,
	carroceria TEXT,
	idUsuarioCrea INT,
	idUsuarioModifica INT,
	fechaCrea TIMESTAMP,
	fechaModifica TIMESTAMP,
	estatus BOOLEAN
)
AS $$
BEGIN
	RETURN QUERY SELECT id, carroceria, idUsuarioCrea, idUsuarioModifica,
	fechaCrea, fechaModifica , estatus FROM Carroceria;
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE ELIMINAR CARROCERIA

CREATE OR REPLACE PROCEDURE SP_EliminarCarroceria(
    IN id INT
)
AS $$
BEGIN
    DELETE FROM Carroceria
    WHERE id = id;
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE INSERTAR TRANSMISION

CREATE OR REPLACE PROCEDURE SP_InsertarTransmision(
    IN transmision TEXT,
    IN idUsuarioCrea INT
)
AS $$
BEGIN
    INSERT INTO Transmision (transmision, idUsuarioCrea)
    VALUES (transmision, idUsuarioCrea);
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE ACTUALIZAR TRANSMISION

CREATE OR REPLACE PROCEDURE SP_ActualizarTransmision(
    IN id INT,
    IN transmision TEXT,
    IN idUsuarioModifica INT
)
AS $$
BEGIN
    UPDATE Transmision
    SET transmision = transmision,
        idUsuarioModifica = idUsuarioModifica,
        fechaModifica = CURRENT_TIMESTAMP
    WHERE id = id;
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE LEER TRANSMISION

CREATE OR REPLACE FUNCTION SP_LeerTransmision()
	RETURNS TABLE(
	id INT,
	transmision TEXT,
	idUsuarioCrea INT,
	idUsuarioModifica INT,
	fechaCrea TIMESTAMP,
	fechaModifica TIMESTAMP,
	estatus BOOLEAN
)
AS $$
BEGIN
	RETURN QUERY SELECT id, transmision, idUsuarioCrea, idUsuarioModifica,
	fechaCrea, fechaModifica , estatus FROM Transmision;
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE ELIMINAR TRANSMISION

CREATE OR REPLACE PROCEDURE SP_EliminarTransmision(
    IN id INT
)
AS $$
BEGIN
    DELETE FROM Transmision
    WHERE id = id;
END;
$$ LANGUAGE plpgsql;


--STORE PROCEDURE INSERTAR COLOR

CREATE OR REPLACE PROCEDURE SP_InsertarColor(
    IN color TEXT,
    IN idUsuarioCrea INT
)
AS $$
BEGIN
    INSERT INTO Color (color, idUsuarioCrea)
    VALUES (color, idUsuarioCrea);
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE ACTUALIZAR COLOR

CREATE OR REPLACE PROCEDURE SP_ActualizarColor(
    IN id INT,
    IN color TEXT,
    IN idUsuarioModifica INT
)
AS $$
BEGIN
    UPDATE Color
    SET color = color,
        idUsuarioModifica = idUsuarioModifica,
        fechaModifica = CURRENT_TIMESTAMP
    WHERE id = id;
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE LEER COLOR

CREATE OR REPLACE FUNCTION SP_LeerColor()
	RETURNS TABLE(
	id INT,
	color TEXT,
	idUsuarioCrea INT,
	idUsuarioModifica INT,
	fechaCrea TIMESTAMP,
	fechaModifica TIMESTAMP,
	estatus BOOLEAN
)
AS $$
BEGIN
	RETURN QUERY SELECT id, color, idUsuarioCrea, idUsuarioModifica,
	fechaCrea, fechaModifica , estatus FROM Color;
END;
$$ LANGUAGE plpgsql;

--STORE PROCEDURE ELIMINAR COLOR

CREATE OR REPLACE PROCEDURE SP_EliminarColor(
    IN id INT
)
AS $$
BEGIN
    DELETE FROM Color
    WHERE id = id;
END;
$$ LANGUAGE plpgsql;

--VIEW 

CREATE VIEW VW_vehiculosBusqueda AS
SELECT 
    Vehiculo.año AS "Año",
    Vehiculo.kilometraje AS "Kilometraje",
    Vehiculo.interior AS "Interior",
    Modelo.modelo AS "Modelo",
    Marca.marca AS "Marca",
    Transmision.transmision AS "Transmision",
    Carroceria.carroceria AS "Carroceria",
    Color.color AS "Color",
    VersionAuto.versionAuto AS "Version",
    venta.vendedor AS "Vendedor",
    venta.precioVenta AS "Precio de venta",
    venta.fechaVenta AS "Fecha de Venta"
FROM 
    Vehiculo
    INNER JOIN Modelo ON Vehiculo.idModelo = Modelo.id
    INNER JOIN Marca ON Vehiculo.idMarca = Marca.id
    INNER JOIN Transmision ON Vehiculo.idTransmision = Transmision.id
    INNER JOIN Carroceria ON Vehiculo.idCarroceria = Carroceria.id
    INNER JOIN Color ON Vehiculo.idColor = Color.id
    INNER JOIN VersionAuto ON Vehiculo.idVersionAuto = VersionAuto.id
    INNER JOIN Venta ON Vehiculo.idVenta = Venta.id;


--IMPORTAR CSV 
select * from VentasVehiculos;
COPY VentasVehiculos FROM 'C:\Program Files\PostgreSQL\16\data\VentasVehiculos.csv' DELIMITER ';' CSV HEADER;
se
