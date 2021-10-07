CREATE DATABASE tienda;

USE tienda;

CREATE TABLE IF NOT EXISTS facturas(
    id INT PRIMARY KEY AUTO_INCREMENT,
    serie VARCHAR(10),
    nombre VARCHAR(50),
    nit INT,
    direccion VARCHAR(50),
    total DOUBLE DEFAULT 0.0,
    iva DECIMAL(9,2) AS (total*0.12)
);

CREATE TABLE detalles_facturas(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombreProducto VARCHAR(50),
    precioProducto DOUBLE,
    cantidad INT,
    subTotal DOUBLE AS (precioProducto * cantidad),
    id_factura INT,

    CONSTRAINT FK_id foreign key (id_factura)
        REFERENCES facturas(id)
        ON DELETE RESTRICT  ON UPDATE RESTRICT
);

INSERT INTO facturas(serie,nombre, nit, direccion)
    VALUES('A1-2254', 'Empresa Fake', 123456, '6ta Avenida A');

SELECT * FROM facturas;

/*TRIGGER INSERCION*/
DROP TRIGGER tgr_insercion_detalles_facturas_suma_total;
DROP TRIGGER tgr_insercion_detalles_facturas_resta_total;

CREATE TRIGGER tgr_insercion_detalles_facturas_suma_total
    AFTER INSERT ON detalles_facturas FOR EACH ROW
        UPDATE facturas SET total = total + NEW.subTotal
            WHERE facturas.id = NEW.id_factura;
/*TRIGGER DELETE*/
CREATE TRIGGER tgr_insercion_detalles_facturas_resta_total
    AFTER DELETE ON detalles_facturas FOR EACH ROW
        UPDATE facturas SET total = total - OLD.subTotal
            WHERE facturas.id = OLD.id_factura;
/*TRIGGER UPDATE*/
CREATE TRIGGER tgr_update_detalles_facturas_actualizacion_total
    AFTER UPDATE ON detalles_facturas FOR EACH ROW
        BEGIN
            UPDATE facturas SET total = total - OLD.subTotal
                WHERE  id = OLD.id_factura;
            UPDATE facturas SET total = total + NEW.subtOTAL
                WHERE id = NEW.id_factura;
        END;


SELECT * FROM detalles_facturas;

INSERT INTO detalles_facturas(nombreproducto, precioproducto, cantidad, id_factura)
    VALUES('Apple Watch', 150, 3, 4);

DELETE FROM  detalles_facturas WHERE id = 11;

ALTER TABLE facturas
    ADD COLUMN categoria ENUM('Baja', 'Media', 'Alta', 'Premium');

SELECT * FROM facturas;

CREATE PROCEDURE prd_contar_cantidad_facturas_cliente(IN nombreCliente VARCHAR(30), OUT cantidadFacturas INT)
    BEGIN
        SELECT COUNT(*) AS conteo INTO cantidadFacturas FROM (
            SELECT facturas.nombre, facturas.total, detalles_facturas.id_factura FROM facturas
                INNER JOIN detalles_facturas on facturas.id = detalles_facturas.id_factura WHERE facturas.nombre = nombreCliente)AS T;
    END;
CALL prd_contar_cantidad_facturas_cliente('Empresa Fake', @cantidad);
SELECT @cantidad;
CREATE PROCEDURE prd_set_categoria_factura(IN facturaId INT)
    BEGIN
        DECLARE montoTotal DOUBLE;
        DECLARE categoriaFact INT;
        SET montoTotal = (SELECT total FROM facturas WHERE id = facturaID);

        IF (montoTotal <= 100) THEN
            SET categoriaFact = 1;
        ELSEIF(montoTotal > 100 AND montoTotal <= 500) THEN
            SET categoriaFact = 2;
        ELSEIF(montoTotal > 500 AND montoTotal <= 1000) THEN
            SET categoriaFact = 3;
        ELSE
            SET categoriaFact = 4;
        END IF;
        UPDATE facturas set categoria = categoriaFact WHERE id = facturaId;
    END;
/*LLAMADO*/
call prd_set_categoria_factura(4);