-- Crear la base de datos
CREATE DATABASE VentasVehiculos;

-- Utilizar la base de datos creada
USE VentasVehiculos;

-- TABLAS
select * from ventasvehiculos
CREATE TABLE Usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    username VARCHAR(50) NOT NULL,
    contraseña VARCHAR(50),
    estatus BIT DEFAULT 1
);

CREATE TABLE Vehiculo (
    id INT AUTO_INCREMENT PRIMARY KEY,
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
    fechaCrea DATETIME DEFAULT CURRENT_TIMESTAMP,
    fechaModifica DATETIME DEFAULT NULL,
    estatus BIT DEFAULT 1
);

CREATE TABLE Venta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    vendedor TEXT,
    precioVenta INT,
    fechaVenta TEXT,
    idUsuarioCrea INT,
    idUsuarioModifica INT DEFAULT NULL,
    fechaCrea DATETIME DEFAULT CURRENT_TIMESTAMP,
    fechaModifica DATETIME DEFAULT NULL,
    estatus BIT DEFAULT 1
);

CREATE TABLE Marca (
    id INT AUTO_INCREMENT PRIMARY KEY,
    marca TEXT,
    idUsuarioCrea INT,
    idUsuarioModifica INT DEFAULT NULL,
    fechaCrea DATETIME DEFAULT CURRENT_TIMESTAMP,
    fechaModifica DATETIME DEFAULT NULL,
    estatus BIT DEFAULT 1
);

CREATE TABLE Modelo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    modelo TEXT,
    idUsuarioCrea INT,
    idUsuarioModifica INT DEFAULT NULL,
    fechaCrea DATETIME DEFAULT CURRENT_TIMESTAMP,
    fechaModifica DATETIME DEFAULT NULL,
    estatus BIT DEFAULT 1
);

CREATE TABLE VersionAuto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    versionAuto TEXT,
    idUsuarioCrea INT,
    idUsuarioModifica INT DEFAULT NULL,
    fechaCrea DATETIME DEFAULT CURRENT_TIMESTAMP,
    fechaModifica DATETIME DEFAULT NULL,
    estatus BIT DEFAULT 1
);

CREATE TABLE Carroceria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    carroceria TEXT,
    idUsuarioCrea INT,
    idUsuarioModifica INT DEFAULT NULL,
    fechaCrea DATETIME DEFAULT CURRENT_TIMESTAMP,
    fechaModifica DATETIME DEFAULT NULL,
    estatus BIT DEFAULT 1
);

CREATE TABLE Transmision (
    id INT AUTO_INCREMENT PRIMARY KEY,
    transmision TEXT,
    idUsuarioCrea INT,
    idUsuarioModifica INT DEFAULT NULL,
    fechaCrea DATETIME DEFAULT CURRENT_TIMESTAMP,
    fechaModifica DATETIME DEFAULT NULL,
    estatus BIT DEFAULT 1
);

CREATE TABLE Color (
    id INT AUTO_INCREMENT PRIMARY KEY,
    color TEXT,
    idUsuarioCrea INT,
    idUsuarioModifica INT DEFAULT NULL,
    fechaCrea DATETIME DEFAULT CURRENT_TIMESTAMP,
    fechaModifica DATETIME DEFAULT NULL,
    estatus BIT DEFAULT 1
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

-- INDEX

CREATE INDEX IX_Usuario ON Usuario(id);

CREATE INDEX IX_Vehiculo ON Vehiculo(id);

CREATE INDEX IX_Venta ON Venta(id);

CREATE INDEX IX_Marca ON Marca(id);

CREATE INDEX IX_Modelo ON Modelo(id);

CREATE INDEX IX_VersionAuto ON VersionAuto(id);

CREATE INDEX IX_Carroceria ON Carroceria(id);

CREATE INDEX IX_Transmision ON Transmision(id);

CREATE INDEX IX_Color ON Color(id);

-- POBLAR 

INSERT INTO Usuario (nombre, username, contraseña)
VALUES ('Admin', 'admin', SHA1('admin'));

INSERT INTO Vehiculo (año, kilometraje, interior, idMarca, idModelo, idVersionAuto, idCarroceria, idTransmision, idColor, idVenta, idUsuarioCrea)
SELECT DISTINCT year, odometer, interior,
(SELECT id FROM Marca WHERE marca=make) AS idMarca,
(SELECT id FROM Modelo WHERE modelo=model) AS idModelo,
(SELECT id FROM VersionAuto WHERE versionAuto=trim) AS idVersionAuto,
(SELECT id FROM Carroceria WHERE carroceria=body) AS idCarroceria,
(SELECT id FROM Transmision WHERE transmision=transmission) AS idTransmision,
(SELECT MAX(id) FROM Color WHERE color=color) AS idColor,
(SELECT MAX(id) FROM Venta WHERE vendedor=seller) AS idVenta,
1 AS idUsuarioCrea
FROM VentasVehiculos;

delete from Marca;
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

select * from carroceria 
-- STORE PROCEDURE 

-- Procedimiento Almacenado para Insertar Vehículo
DELIMITER //

CREATE PROCEDURE SP_InsertarVehiculo(
    IN p_año INT,
    IN p_kilometraje INT,
    IN p_interior TEXT,
    IN p_idMarca INT,
    IN p_idModelo INT,
    IN p_idVersionAuto INT,
    IN p_idCarroceria INT,
    IN p_idTransmision INT,
    IN p_idColor INT,
    IN p_idVenta INT,
    IN p_idUsuarioCrea INT
)
BEGIN
    INSERT INTO Vehiculo (año, kilometraje, interior, idMarca, idModelo, idVersionAuto, idCarroceria, idTransmision, idColor, idVenta, idUsuarioCrea)
    VALUES (p_año, p_kilometraje, p_interior, p_idMarca, p_idModelo, p_idVersionAuto, p_idCarroceria, p_idTransmision, p_idColor, p_idVenta, p_idUsuarioCrea);
END //

DELIMITER ;

-- Procedimiento Almacenado para Actualizar Vehículo
DELIMITER //

CREATE PROCEDURE SP_ActualizarVehiculo(
    IN p_id INT,
    IN p_año INT,
    IN p_kilometraje INT,
    IN p_interior TEXT,
    IN p_idMarca INT,
    IN p_idModelo INT,
    IN p_idVersionAuto INT,
    IN p_idCarroceria INT,
    IN p_idTransmision INT,
    IN p_idColor INT,
    IN p_idVenta INT,
    IN p_idUsuarioModifica INT
)
BEGIN
    UPDATE Vehiculo
    SET año = p_año,
        kilometraje = p_kilometraje,
        interior = p_interior,
        idMarca = p_idMarca,
        idModelo = p_idModelo,
        idVersionAuto = p_idVersionAuto,
        idCarroceria = p_idCarroceria,
        idTransmision = p_idTransmision,
        idColor = p_idColor,
        idVenta = p_idVenta,
        idUsuarioModifica = p_idUsuarioModifica,
        fechaModifica = CURRENT_TIMESTAMP
    WHERE id = p_id;
END //

DELIMITER ;

-- Procedimiento Almacenado para Leer Vehículo
DELIMITER //

CREATE PROCEDURE SP_LeerVehiculo()
BEGIN
    SELECT id, año, kilometraje, interior, idMarca, idModelo, idVersionAuto, idCarroceria, idTransmision, idColor, idVenta, idUsuarioCrea, idUsuarioModifica, fechaCrea, fechaModifica, estatus
    FROM Vehiculo;
END //

DELIMITER ;

-- Procedimiento Almacenado para Eliminar Vehículo
DELIMITER //

CREATE PROCEDURE SP_EliminarVehiculo(
    IN p_id INT
)
BEGIN
    DELETE FROM Vehiculo
    WHERE id = p_id;
END //

DELIMITER ;

-- SP INSERTAR DE TABLA VENTA

DELIMITER //

CREATE PROCEDURE SP_InsertarVenta(
    IN p_vendedor TEXT,
    IN p_precioVenta INT,
    IN p_fechaVenta TEXT,
    IN p_idUsuarioCrea INT
)
BEGIN
    INSERT INTO Venta (vendedor, precioVenta, fechaVenta, idUsuarioCrea)
    VALUES (p_vendedor, p_precioVenta, p_fechaVenta, p_idUsuarioCrea);
END //

DELIMITER ;

-- SP ACTUALIZAR DE TABLA Venta 

DELIMITER //

CREATE PROCEDURE SP_ActualizarVenta(
    IN p_id INT,
    IN p_vendedor TEXT,
    IN p_precioVenta INT,
    IN p_fechaVenta TEXT,
    IN p_idUsuarioModifica INT
)
BEGIN
    UPDATE Venta
    SET vendedor = p_vendedor,
        precioVenta = p_precioVenta,
        fechaVenta = p_fechaVenta,
        idUsuarioModifica = p_idUsuarioModifica,
        fechaModifica = CURRENT_TIMESTAMP
    WHERE id = p_id;
END //

DELIMITER ;

-- SP LEER DE TABLA Venta

DELIMITER //

CREATE PROCEDURE SP_LeerVenta()
BEGIN
    SELECT id, vendedor, precioVenta, fechaVenta, idUsuarioCrea, idUsuarioModifica, fechaCrea, fechaModifica, estatus
    FROM Venta;
END //

DELIMITER ;

-- SP ELIMINAR DE TABLA Venta

DELIMITER //

CREATE PROCEDURE SP_EliminarVenta(
    IN p_id INT
)
BEGIN
    DELETE FROM Venta
    WHERE id = p_id;
END //

DELIMITER ;

-- SP INSERTAR DE TABLA Marca

DELIMITER //

CREATE PROCEDURE SP_InsertarMarca(
    IN p_marca TEXT,
    IN p_idUsuarioCrea INT
)
BEGIN
    INSERT INTO Marca (marca, idUsuarioCrea)
    VALUES (p_marca, p_idUsuarioCrea);
END //

DELIMITER ;

-- SP ACTUALIZAR DE TABLA Marca

DELIMITER //

CREATE PROCEDURE SP_ActualizarMarca(
    IN p_id INT,
    IN p_marca TEXT,
    IN p_idUsuarioModifica INT
)
BEGIN
    UPDATE Marca
    SET marca = p_marca,
        idUsuarioModifica = p_idUsuarioModifica,
        fechaModifica = CURRENT_TIMESTAMP
    WHERE id = p_id;
END //

DELIMITER ;

-- SP LEER DE TABLA Marca

DELIMITER //

CREATE PROCEDURE SP_LeerMarca()
BEGIN
    SELECT id, marca, idUsuarioCrea, idUsuarioModifica, fechaCrea, fechaModifica, estatus
    FROM Marca;
END //

DELIMITER ;

-- SP ELIMINAR DE TABLA Marca

DELIMITER //

CREATE PROCEDURE SP_EliminarMarca(
    IN p_id INT
)
BEGIN
    DELETE FROM Marca
    WHERE id = p_id;
END //

DELIMITER ;

-- SP INSERTAR DE TABLA Modelo

DELIMITER //

CREATE PROCEDURE SP_InsertarModelo(
    IN p_modelo TEXT,
    IN p_idUsuarioCrea INT
)
BEGIN
    INSERT INTO Modelo (modelo, idUsuarioCrea)
    VALUES (p_modelo, p_idUsuarioCrea);
END //

DELIMITER ;

-- SP ACTUALIZAR DE TABLA Modelo

DELIMITER //

CREATE PROCEDURE SP_ActualizarModelo(
    IN p_id INT,
    IN p_modelo TEXT,
    IN p_idUsuarioModifica INT
)
BEGIN
    UPDATE Modelo
    SET modelo = p_modelo,
        idUsuarioModifica = p_idUsuarioModifica,
        fechaModifica = CURRENT_TIMESTAMP
    WHERE id = p_id;
END //

DELIMITER ;

-- SP LEER DE TABLA Modelo

DELIMITER //

CREATE PROCEDURE SP_LeerModelo()
BEGIN
    SELECT id, modelo, idUsuarioCrea, idUsuarioModifica, fechaCrea, fechaModifica, estatus
    FROM Modelo;
END //

DELIMITER ;

-- SP ELIMINAR DE TABLA Modelo

DELIMITER //

CREATE PROCEDURE SP_EliminarModelo(
    IN p_id INT
)
BEGIN
    DELETE FROM Modelo
    WHERE id = p_id;
END //

DELIMITER ;

-- SP INSERTAR DE TABLA VersionAuto

DELIMITER //

CREATE PROCEDURE SP_InsertarVersionAuto(
    IN p_versionAuto TEXT,
    IN p_idUsuarioCrea INT
)
BEGIN
    INSERT INTO VersionAuto (versionAuto, idUsuarioCrea)
    VALUES (p_versionAuto, p_idUsuarioCrea);
END //

DELIMITER ;

-- SP ACTUALIZAR DE TABLA VersionAuto

DELIMITER //

CREATE PROCEDURE SP_ActualizarVersionAuto(
    IN p_id INT,
    IN p_versionAuto TEXT,
    IN p_idUsuarioModifica INT
)
BEGIN
    UPDATE VersionAuto
    SET versionAuto = p_versionAuto,
        idUsuarioModifica = p_idUsuarioModifica,
        fechaModifica = CURRENT_TIMESTAMP
    WHERE id = p_id;
END //

DELIMITER ;

-- SP LEER DE TABLA VersionAuto

DELIMITER //

CREATE PROCEDURE SP_LeerVersionAuto()
BEGIN
    SELECT id, versionAuto, idUsuarioCrea, idUsuarioModifica, fechaCrea, fechaModifica, estatus
    FROM VersionAuto;
END //

DELIMITER ;

-- SP ELIMINAR DE TABLA VersionAuto

DELIMITER //

CREATE PROCEDURE SP_EliminarVersionAuto(
    IN p_id INT
)
BEGIN
    DELETE FROM VersionAuto
    WHERE id = p_id;
END //

DELIMITER ;

-- SP INSERTAR DE TABLA Carroceria

DELIMITER //

CREATE PROCEDURE SP_InsertarCarroceria(
    IN p_carroceria TEXT,
    IN p_idUsuarioCrea INT
)
BEGIN
    INSERT INTO Carroceria (carroceria, idUsuarioCrea)
    VALUES (p_carroceria, p_idUsuarioCrea);
END //

DELIMITER ;

-- SP ACTUALIZAR DE TABLA Carroceria

DELIMITER //

CREATE PROCEDURE SP_ActualizarCarroceria(
    IN p_id INT,
    IN p_carroceria TEXT,
    IN p_idUsuarioModifica INT
)
BEGIN
    UPDATE Carroceria
    SET carroceria = p_carroceria,
        idUsuarioModifica = p_idUsuarioModifica,
        fechaModifica = CURRENT_TIMESTAMP
    WHERE id = p_id;
END //

DELIMITER ;

-- SP LEER DE TABLA Carroceria

DELIMITER //

CREATE PROCEDURE SP_LeerCarroceria()
BEGIN
    SELECT id, carroceria, idUsuarioCrea, idUsuarioModifica, fechaCrea, fechaModifica, estatus
    FROM Carroceria;
END //

DELIMITER ;

-- SP ELIMINAR DE TABLA Carroceria

DELIMITER //

CREATE PROCEDURE SP_EliminarCarroceria(
    IN p_id INT
)
BEGIN
    DELETE FROM Carroceria
    WHERE id = p_id;
END //

DELIMITER ;

-- SP INSERTAR DE TABLA Transmision

DELIMITER //

CREATE PROCEDURE SP_InsertarTransmision(
    IN p_transmision TEXT,
    IN p_idUsuarioCrea INT
)
BEGIN
    INSERT INTO Transmision (transmision, idUsuarioCrea)
    VALUES (p_transmision, p_idUsuarioCrea);
END //

DELIMITER ;

-- SP ACTUALIZAR DE TABLA Transmision

DELIMITER //

CREATE PROCEDURE SP_ActualizarTransmision(
    IN p_id INT,
    IN p_transmision TEXT,
    IN p_idUsuarioModifica INT
)
BEGIN
    UPDATE Transmision
    SET transmision = p_transmision,
        idUsuarioModifica = p_idUsuarioModifica,
        fechaModifica = CURRENT_TIMESTAMP
    WHERE id = p_id;
END //

DELIMITER ;

-- SP LEER DE TABLA Transmision

DELIMITER //

CREATE PROCEDURE SP_LeerTransmision()
BEGIN
    SELECT id, transmision, idUsuarioCrea, idUsuarioModifica, fechaCrea, fechaModifica, esatus
    FROM Transmision;
END //

DELIMITER ;

-- SP ELIMINAR DE TABLA Transmision

DELIMITER //

CREATE PROCEDURE SP_EliminarTransmision(
    IN p_id INT
)
BEGIN
    DELETE FROM Transmision
    WHERE id = p_id;
END //

DELIMITER ;

-- SP INSERTAR DE TABLA Color

DELIMITER //

CREATE PROCEDURE SP_InsertarColor(
    IN p_color TEXT,
    IN p_idUsuarioCrea INT
)
BEGIN
    INSERT INTO Color (color, idUsuarioCrea)
    VALUES (p_color, p_idUsuarioCrea);
END //

DELIMITER ;

-- SP ACTUALIZAR DE TABLA Color

DELIMITER //

CREATE PROCEDURE SP_ActualizarColor(
    IN p_id INT,
    IN p_color TEXT,
    IN p_idUsuarioModifica INT
)
BEGIN
    UPDATE Color
    SET color = p_color,
        idUsuarioModifica = p_idUsuarioModifica,
        fechaModifica = CURRENT_TIMESTAMP
    WHERE id = p_id;
END //

DELIMITER ;

-- SP LEER DE TABLA Color

DELIMITER //

CREATE PROCEDURE SP_LeerColor()
BEGIN
    SELECT id, color, idUsuarioCrea, idUsuarioModifica, fechaCrea, fechaModifica, estatus
    FROM Color;
END //

DELIMITER ;

-- SP ELIMINAR DE TABLA Color

DELIMITER //

CREATE PROCEDURE SP_EliminarColor(
    IN p_id INT
)
BEGIN
    DELETE FROM Color
    WHERE id = p_id;
END //

DELIMITER ;

-- VIEW (PENDIENTE)

CREATE VIEW VW_vehiculosBusqueda AS
SELECT 
    Vehiculo.año AS Año,
    Vehiculo.kilometraje AS Kilometraje,
    Vehiculo.interior AS Interior,
    Modelo.modelo AS Modelo,
    Marca.marca AS Marca,
    Transmision.transmision AS Transmision,
    Carroceria.carroceria AS Carroceria, 
    Color.color AS Color,
    VersionAuto.versionAuto AS Version,
    Venta.vendedor AS Vendedor, 
    Venta.precioVenta AS `Precio de venta`, 
    Venta.fechaVenta AS `Fecha de Venta`
FROM 
    Vehiculo
INNER JOIN 
    Modelo ON Vehiculo.idModelo = Modelo.id
INNER JOIN 
    Marca ON Vehiculo.idMarca = Marca.id
INNER JOIN 
    Transmision ON Vehiculo.idTransmision = Transmision.id
INNER JOIN 
    Carroceria ON Vehiculo.idCarroceria = Carroceria.id
INNER JOIN 
    Color ON Vehiculo.idColor = Color.id
INNER JOIN 
    VersionAuto ON Vehiculo.idVersionAuto = VersionAuto.id
INNER JOIN 
    Venta ON Vehiculo.idVenta = Venta.id;

select * from Modelo