--Creación de base de datos
CREATE DATABASE pizzeria_don_piccolo;

USE pizzeria_don_piccolo;

--Creación de tabla Persona--
CREATE TABLE Persona (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50),
    telefono VARCHAR(50),
    direccion VARCHAR(50),
    correo VARCHAR(50),
    PRIMARY KEY(id)
);

--Creación de tabla Cliente--
CREATE TABLE Cliente (
    id INT AUTO_INCREMENT,
    FOREIGN KEY(id) REFERENCES Persona(id)
);

--Creación de tabla Vendedor--
CREATE TABLE Vendedor (
    id INT AUTO_INCREMENT,
    FOREIGN KEY(id) REFERENCES Persona(id)
);

--Creación de tabla zonaAsignada--
CREATE TABLE zonaAsignada (
    idZona INT AUTO_INCREMENT,
    zona VARCHAR(50),
    precioPorMetro DOUBLE,
    PRIMARY KEY(idZona)
);

--Creación de tabla Repartidor--
CREATE TABLE Repartidor (
    id INT AUTO_INCREMENT,
    idZona INT,
    estado. VARCHAR(50),
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES Persona(id),
    FOREIGN KEY(idZona) REFERENCES zonaAsignada(idZona)
);

--Creación de tabla Pizzas--
CREATE TABLE Pizzas (
    idPizza INT AUTO_INCREMENT,
    tamano VARCHAR(50),
    precioBase DOUBLE,
    tipo VARCHAR(50)
    PRIMARY KEY(idPizza)
)

--Creación de tabla historialPrecios--
CREATE TABLE historialPrecios (
    idHistorial INT AUTO_INCREMENT ,
    idPizza INT,
    precioAnterior DOUBLE,
    precioNuevo DOUBLE,
    fechaCambio DATETIME,
    PRIMARY KEY(idHistorial),
    FOREIGN KEY (idPizza) REFERENCES Pizzas(idPizza)
);

--Creación de tabla Ingrediente--
CREATE TABLE Ingrediente (
    idIngrediente INT AUTO_INCREMENT,
    nombreIngrediente VARCHAR(50),
    precioIngrediente DOUBLE,
    cantidad INT,
    PRIMARY KEY(idIngrediente)
);

--Creación de tabla pizzaIngrediente--
CREATE TABLE pizzaIngrediente (
    idPizza INT,
    idIngrediente INT,
    cantidadUso INT,
    PRIMARY KEY (idPizza, idIngrediente),
    FOREIGN KEY (idPizza) REFERENCES Pizzas(idPizza),
    FOREIGN KEY (idIngrediente) REFERENCES Ingrediente(idIngrediente)
);

--Creación de tabla metodoPago--
CREATE TABLE metodoPago (
    idPago INT AUTO_INCREMENT,
    metodo VARCHAR(50),
    PRIMARY KEY(idPago)
);

--Creación de tabla Pedidos--
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

--Creación de tabla detallePedido--
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

--Creación de tabla Domicilios--
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
    FOREIGN KEY (idRepartidor) REFERENCES Repartidor(idRepartidor)
);

