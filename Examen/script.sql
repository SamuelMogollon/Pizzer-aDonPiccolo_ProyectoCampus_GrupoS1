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

CREATE TABLE Pedidos (
    idPedido INT AUTO_INCREMENT,
    idCliente INT,
    MetodoPago VARCHAR(50),
    fechaPedido DATETIME,
    estado VARCHAR(50),
    total DOUBLE,
    PRIMARY KEY(idPedido),
    FOREIGN KEY (idCliente) REFERENCES Cliente(id),
);

CREATE TABLE Pizzas (
    idPizza INT AUTO_INCREMENT,
    tamano VARCHAR(50),
    precioBase DOUBLE,
    tipo VARCHAR(50),
    PRIMARY KEY(idPizza)
);

CREATE TABLE pedido_pizza (
    idPedido INT,
    idPizza INT,
    cantidad INT,
    FOREIGN KEY (idPedido) REFERENCES Pedidos(idPedido),
    FOREIGN KEY (idPizza) REFERENCES Pizzas(idPizza)
)
--Consulta #1
-- hacemos un select a la tabla pedidos para sacar los datos que se necesitan, se hace unn left join hacia la tabla persona, para sacar el nombre
SELECT p.idPedido, p.estado, p.total, pe.nombre  FROM Pedidos p LEFT JOIN Persona pe ON p.idPedido = pe.id ORDER BY p.idPedido;

--Consulta #2
-- hacemos un select a la tabla pedidos donde el estado del pedido sea entregado y se filtre segun la fecha dada
SELECT idPedido, idCliente, fechaPedido, total
FROM Pedidos
WHERE estado='entregado' BETWEEN '2025-12-01' AND '2025-12-03';

--Consulta #3
-- Se usa un select hacia la tabla pedidos para agrupar por el metodo de pago 
SELECT idPedido FROM Pedidos GROUP BY idMetodoPago HAVING metodo = 'Efectivo';

--Consulta #4
--hacemos un select hacia la tabla pedidos, agrupamos por el idCliente y tenemos el clienteFrecuente
SELECT COUNT(idCliente) AS ClienteFrecuente FROM Pedidos GROUP BY idCliente HAVING ClienteFrecuente > 5; 