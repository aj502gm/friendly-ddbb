CREATE TABLE solicitudes(
    numero_solicitud SERIAL PRIMARY KEY,
    responsable VARCHAR(25),
    centro_costos VARCHAR(25),
    fecha DATE,
    rubro_costos FLOAT
);

CREATE TABLE items(
    codigo_item SERIAL PRIMARY KEY,
    numero_solicitud INT,
    cantidad INT,
    precio_unitario FLoat,
    total FLOAT,

    CONSTRAINT  fk_numero_solicitud
        FOREIGN KEY (numero_solicitud) REFERENCES solicitudes(numero_solicitud)
);

CREATE TABLE ordenes_contractuales(
    numero_orden SERIAL PRIMARY KEY,
    numero_solicitud INT,
    nit VARCHAR(10),
    proveedor VARCHAR(10),
    fecha_emision DATE,
    fecha_entrega DATE,
    total FLOAT,

    CONSTRAINT  fk_numero_solicitud
        FOREIGN KEY (numero_solicitud) REFERENCES solicitudes(numero_solicitud)
);

CREATE TABLE facturas(
    numero_entrada SERIAL PRIMARY KEY ,
    numero_solicitud INT,
    numero_factura VARCHAR(25),
    proveedor VARCHAR(25),
    CONSTRAINT  fk_numero_solicitud
        FOREIGN KEY (numero_solicitud) REFERENCES solicitudes(numero_solicitud)
);
CREATE TABLE entregas(
    numero_salida SERIAL PRIMARY KEY ,
    numero_entrada INT,
    empleado VARCHAR(25),
    fecha_salida DATE,
    fecha_reconocimiento DATE,

    CONSTRAINT  fk_numero_entrada
        FOREIGN KEY (numero_entrada) REFERENCES facturas(numero_entrada)
);

CREATE TABLE bienes(
    codigo SERIAL PRIMARY KEY ,
    responsable VARCHAR(25),
    fecha DATE,
    descripcion TEXT
);