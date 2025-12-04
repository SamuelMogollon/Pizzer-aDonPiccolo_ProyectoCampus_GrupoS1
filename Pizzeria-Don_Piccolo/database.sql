
CREATE DATABASE pizzeria_don_piccolo;

USE pizzeria_don_piccolo;


CREATE TABLE Persona (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50),
    telefono VARCHAR(50),
    direccion VARCHAR(50),
    correo VARCHAR(50),
    PRIMARY KEY(id)
);


CREATE TABLE Cliente (
    id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES Persona(id)
);


CREATE TABLE Vendedor (
    id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES Persona(id)
);


CREATE TABLE zonaAsignada (
    idZona INT NOT NULL AUTO_INCREMENT,
    zona VARCHAR(50),
    precioPorMetro DOUBLE,
    PRIMARY KEY(idZona)
);


CREATE TABLE Repartidor (
    id INT NOT NULL ,
    idZona INT,
    estado VARCHAR(50),
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES Persona(id),
    FOREIGN KEY(idZona) REFERENCES zonaAsignada(idZona)
);

CREATE TABLE Pizzas (
    idPizza INT NOT NULL AUTO_INCREMENT,
    tamano VARCHAR(50),
    precioBase DOUBLE,
    tipo VARCHAR(50),
    PRIMARY KEY(idPizza)
);

CREATE TABLE historialPrecios (
    idHistorial INT NOT NULL AUTO_INCREMENT ,
    idPizza INT,
    precioAnterior DOUBLE,
    precioNuevo DOUBLE,
    fechaCambio DATETIME,
    PRIMARY KEY(idHistorial),
    FOREIGN KEY (idPizza) REFERENCES Pizzas(idPizza)
);


CREATE TABLE Ingrediente (
    idIngrediente INT NOT NULL AUTO_INCREMENT,
    nombreIngrediente VARCHAR(50),
    precioIngrediente DOUBLE,
    cantidad INT,
    PRIMARY KEY(idIngrediente)
);

CREATE TABLE pizzaIngrediente (
    idPizza INT NOT NULL,
    idIngrediente INT,
    cantidadUso INT,
    PRIMARY KEY (idPizza, idIngrediente),
    FOREIGN KEY (idPizza) REFERENCES Pizzas(idPizza),
    FOREIGN KEY (idIngrediente) REFERENCES Ingrediente(idIngrediente)
);

CREATE TABLE metodoPago (
    idPago INT AUTO_INCREMENT,
    metodo VARCHAR(50),
    PRIMARY KEY(idPago)
);

CREATE TABLE Pedidos (
    idPedido INT AUTO_INCREMENT,
    idCliente INT,
    idVendedor INT,
    idMetodoPago INT,
    fechaPedido DATETIME,
    estado VARCHAR(50),
    tipoPedido VARCHAR(50),
    recibido DOUBLE,
    total DOUBLE,
    PRIMARY KEY(idPedido),
    FOREIGN KEY (idCliente) REFERENCES Cliente(id),
    FOREIGN KEY (idVendedor) REFERENCES Vendedor(id),
    FOREIGN KEY (idMetodoPago) REFERENCES metodoPago(idPago)
);

CREATE TABLE detallePedido (
    idDetallePedido INT AUTO_INCREMENT,
    idPedido INT,
    idPizza INT,
    cantidadPizzas INT,
    subtotal DOUBLE,
    PRIMARY KEY(idDetallePedido),
    FOREIGN KEY (idPedido) REFERENCES Pedidos(idPedido),
    FOREIGN KEY (idPizza) REFERENCES Pizzas(idPizza)
);

CREATE TABLE Domicilios (
    idDomicilio INT AUTO_INCREMENT,
    idPedido INT UNIQUE,
    idRepartidor INT,
    horaSalida DATETIME,
    horaEntrega DATETIME,
    distanciaAprox VARCHAR(50),
    costoDomicilio DOUBLE,
    totalConDomi DOUBLE,
    PRIMARY KEY(idDomicilio),
    FOREIGN KEY (idPedido) REFERENCES Pedidos(idPedido),
    FOREIGN KEY (idRepartidor) REFERENCES Repartidor(id)
);

-- =============================
-- INSERTS PARA BASE PIIZZERIA 
-- =============================

INSERT INTO Persona (nombre, telefono, direccion, correo) VALUES
('Carlos Gómez', '3104567890', 'Calle 12 #4-55', 'carlos.gomez@gmail.com'),
('María López', '3119876543', 'Carrera 20 #15-30', 'maria.lopez@hotmail.com'),
('Andrés Martínez', '3121234567', 'Av 3 #45-12', 'andres.mtz@gmail.com'),
('Laura Pérez', '3102223344', 'Calle 8 #9-21', 'laura.perez@yahoo.com'),
('Jorge Ramírez', '3135556677', 'Cra 50 #22-18', 'jorge.ramirez@gmail.com'),
('Diana Torres', '3157778899', 'Calle 100 #20-10', 'diana.torres@hotmail.com'),
('Sebastián Vega', '3201112233', 'Carrera 9 #30-04', 'sebastian.vega@gmail.com'),
('Natalia Ruiz', '3189988776', 'Calle 70 #25-17', 'natalia.ruiz@yahoo.com'),
('Felipe Herrera', '3172233445', 'Cra 15 #44-60', 'felipe.herrera@gmail.com'),
('Camila Mendoza', '3167788990', 'Av 8 #55-33', 'camila.mendoza@hotmail.com');

INSERT INTO Cliente (id) VALUES
(1),
(2),
(3);

INSERT INTO Vendedor (id) VALUES
(4),
(5);

INSERT INTO zonaAsignada (zona, precioPorMetro) VALUES
('Norte', 1200),
('Sur', 1000),
('Centro', 1500),
('Occidente', 1100),
('Oriente', 1300);

INSERT INTO Repartidor (id, idZona, estado) VALUES
(6, 1, 'Disponible'),
(7, 2, 'No disponible'),
(8, 3, 'Disponible');

INSERT INTO Pizzas (tamano, precioBase, tipo) VALUES
('Personal', 14000, 'Clásica'),
('Mediana', 24000, 'Clásica'),
('Grande', 34000, 'Clásica'),

('Personal', 17000, 'Especial'),
('Mediana', 27000, 'Especial'),
('Grande', 37000, 'Especial'),

('Personal', 16000, 'Vegetariana'),
('Mediana', 26000, 'Vegetariana'),
('Grande', 36000, 'Vegetariana');

INSERT INTO Ingrediente (nombreIngrediente, precioIngrediente, cantidad) VALUES
('Queso Mozzarella', 3000, 50),
('Jamón', 2500, 40),
('Pepperoni', 2800, 35),
('Champiñones', 2000, 30),
('Pimiento', 1500, 25),
('Cebolla', 1200, 20),
('Aceitunas', 1800, 25),
('Piña', 1800, 20),
('Tomate', 1000, 40),
('Salsa de la Casa', 500, 100);

INSERT INTO pizzaIngrediente (idPizza, idIngrediente, cantidadUso) VALUES
(1, 2, 1), 
(1, 1, 2), 
(1, 3, 1),

(2, 2, 1), 
(2, 1, 2), 
(2, 3, 1),

(3, 2, 1), 
(3, 1, 2), 
(3, 3, 1),

(4, 2, 1),
(4, 1, 2),
(4, 4, 1),
(4, 5, 1),
(4, 6, 1),

(5, 2, 1),
(5, 1, 2),
(5, 4, 1),
(5, 5, 1),
(5, 6, 1),

(6, 2, 1),
(6, 1, 2),
(6, 4, 1),
(6, 5, 1),
(6, 6, 1),

(7, 2, 1),
(7, 1, 2),
(7, 5, 1),
(7, 7, 1),
(7, 8, 1),

(8, 2, 1),
(8, 1, 2),
(8, 5, 1),
(8, 7, 1),
(8, 8, 1),

(9, 2, 1),
(9, 1, 2),
(9, 5, 1),
(9, 7, 1),
(9, 8, 1);

INSERT INTO metodoPago (metodo) VALUES
('Efectivo'),
('Tarjeta'),
('App');

INSERT INTO Pedidos (idCliente, idVendedor, idMetodoPago, fechaPedido, estado, tipoPedido, recibido, total)
VALUES
(1, 4, 1, '2025-12-03 12:30:00', 'Pendiente', 'Domicilio', 50000, 45000),
(2, 5, 2, '2025-12-02 14:10:00', 'Entregado', 'Local', 27000, 27000),
(3, 4, 3, '2025-12-01 18:45:00', 'Cancelado', 'Domicilio', 0, 36000),
(1, 5, 2, '2025-12-03 16:00:00', 'Entregado', 'Domicilio', 60000, 55000);

INSERT INTO detallePedido (idPedido, idPizza, cantidadPizzas, subtotal)
VALUES
(1, 2, 2, 48000),
(1, 5, 1, 27000),
(2, 3, 1, 34000),
(2, 8, 1, 26000),
(3, 6, 1, 37000),
(4, 1, 3, 42000),
(4, 4, 2, 34000);

INSERT INTO Domicilios (idPedido, idRepartidor, horaSalida, horaEntrega, distanciaAprox, costoDomicilio, totalConDomi)
VALUES
(1, 6, '2025-12-03 12:45:00', '2025-12-03 13:15:00', '5000 m', 5000, 50000),
(3, 8, '2025-12-01 19:00:00', '2025-12-01 19:40:00', '8000 m', 6000, 42000),
(4, 6, '2025-12-03 16:15:00', '2025-12-03 16:50:00', '7000 m', 5500, 60500);