SELECT idPedido, idCliente, fechaPedido, total
FROM Pedidos
WHERE fechaPedido BETWEEN '2025-12-01' AND '2025-12-03';

SELECT idPizza, COUNT(*) AS cantidadVendida
FROM DetallePedido
GROUP BY idPizza
ORDER BY cantidadVendida DESC;

SELECT r.id AS idRepartidor, r.estado, d.idPedido
FROM Repartidor r
LEFT JOIN Domicilios d ON r.id = d.idRepartidor
ORDER BY r.id;

--consulta 4 falta

SELECT idCliente, SUM(total) AS totalGastado
FROM Pedidos
GROUP BY idCliente
HAVING totalGastado > 50000;

SELECT *
FROM Pizzas
WHERE tipo LIKE '%geta%';

--consulta 7 falta