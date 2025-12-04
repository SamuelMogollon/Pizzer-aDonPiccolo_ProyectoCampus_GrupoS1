--1.Trigger de actualización automática de stock de ingredientes cuando se realiza un pedido.
DELIMITER //

CREATE TRIGGER descuentoStock
AFTER INSERT ON detallePedido
FOR EACH ROW
BEGIN
    UPDATE Ingrediente i
    LEFT JOIN pizzaIngrediente pi 
        ON i.idIngrediente = pi.idIngrediente
    SET i.cantidad = i.cantidad - (pi.cantidadUso * NEW.cantidadPizzas)
    WHERE pi.idPizza = NEW.idPizza;
END //

DELIMITER ;

--2.Trigger de auditoría que registre en una tabla historial_precios cada vez que se modifique el precio de una pizza.

DELIMITER //

CREATE TRIGGER historialPrecio
AFTER UPDATE ON Pizzas
FOR EACH ROW
BEGIN
    -- Solo registrar si el precio cambió
    IF OLD.precioBase != NEW.precioBase THEN
        INSERT INTO historialPrecios (
            idPizza,
            precioAnterior,
            precioNuevo,
            fechaCambio
        )
        VALUES (
            OLD.idPizza,
            OLD.precioBase,
            NEW.precioBase,
            NOW()
        );
    END IF;
END //

DELIMITER ;

--3.Trigger para marcar repartidor como “disponible” nuevamente cuando termina un domicilio.

DELIMITER //

CREATE TRIGGER repartidorDisponible
AFTER UPDATE ON Domicilios
FOR EACH ROW
BEGIN
    -- Solo se ejecuta si antes NO tenía horaEntrega y ahora sí tiene
    IF OLD.horaEntrega IS NULL AND NEW.horaEntrega IS NOT NULL THEN
        
        UPDATE Repartidor SET estado = 'Disponible' WHERE id = NEW.idRepartidor;
    END IF;
END //

DELIMITER ;
