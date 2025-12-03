--1.Función para calcular el total de un pedido (sumando precios de pizzas + costo de envío + IVA).

DELIMITER //
CREATE FUNCTION CalcularTotalPedido(v_idPedido INT)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    DECLARE v_subtotal DOUBLE DEFAULT 0;
    DECLARE costoDomicilio DOUBLE DEFAULT 0;
    DECLARE totalPedido DOUBLE DEFAULT 0;
    
    -- Suma los subtotales de las pizzas
    SELECT IFNULL(SUM(subtotal), 0) INTO v_subtotal FROM detallePedido WHERE idPedido = v_idPedido;
    
    -- Obtiene el costo del domicilio si existe
    SELECT IFNULL(costoDomicilio, 0) INTO costoDomicilio FROM Domicilios WHERE idPedido = v_idPedido;
    
    -- Calcula el total incluyendo IVA del 19%
    SET totalPedido = (v_subtotal + costoDomicilio) * 1.19;
    
    RETURN totalPedido;
END; //
DELIMITER ;

SELECT calcularTotalPedido(id) AS TotalPedido;

--2.Función para calcular la ganancia neta diaria (ventas - costos de ingredientes).

DELIMITER //
CREATE FUNCTION gananciaNetaDiaria(fecha DATE)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    DECLARE totalVentas DOUBLE DEFAULT 0;
    DECLARE totalCostosIngredientes DOUBLE DEFAULT 0;
    DECLARE ganancia DOUBLE DEFAULT 0;

    -- Sumar todas las ventas del día (Pedidos tipo Local o Domicilio)
    SELECT IFNULL(SUM(dp.subtotal),0) INTO totalVentas FROM Pedidos p LEFT JOIN detallePedido dp ON p.idPedido = dp.idPedido WHERE DATE(p.fechaPedido) = fecha;

    -- Calcular el costo de ingredientes usados en todas las pizzas vendidas
    SELECT IFNULL(SUM(dp.cantidadPizzas * pi.cantidadUso * i.precioIngrediente),0) INTO totalCostosIngredientes FROM Pedidos p LEFT JOIN detallePedido dp ON p.idPedido = dp.idPedido LEFT JOIN pizzaIngrediente pi ON dp.idPizza = pi.idPizza LEFT JOIN Ingrediente i ON pi.idIngrediente = i.idIngrediente WHERE DATE(p.fechaPedido) = fecha;
    
    -- Ganancia neta
    SET ganancia = totalVentas - totalCostosIngredientes;

    RETURN ganancia;
END; //
DELIMITER ;

SELECT gananciaNetaDiaria('2025-12-03') AS Ganancia;

--3.Procedimiento para cambiar automáticamente el estado del pedido a “entregado” cuando se registre la hora de entrega.

DELIMITER //
CREATE PROCEDURE marcarPedidoEntregado(
    IN v_idPedido INT,
    IN v_horaEntrega DATETIME
)
BEGIN
    -- Actualizar la hora de entrega en Domicilios
    UPDATE Domicilios SET horaEntrega = v_horaEntrega WHERE idPedido = v_idPedido;
    
    -- Actualizar el estado del pedido a 'Entregado'
    UPDATE Pedidos SET estado = 'Entregado' WHERE idPedido = v_idPedido;
END;//

DELIMITER ;