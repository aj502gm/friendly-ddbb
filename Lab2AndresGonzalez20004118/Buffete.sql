CREATE DATABASE buffete;
/*DEFINICION DE LA ESTRUCTURA*/
CREATE TABLE clientes(
	id SERIAL PRIMARY KEY,
	dpi VARCHAR(13),
	nombre VARCHAR(15),
	apellido VARCHAR(15),
	direccion TEXT,
	telefono VARCHAR(8),
	email VARCHAR(20),
	lugar_trabajo VARCHAR(15),
	direccion_trabajo TEXT,
	
	CONSTRAINT unique_dpi UNIQUE(dpi),
	CONSTRAINT validacion_cliente CHECK (email ~ $$\A..+\@..+\.(com|edu|net|org)\Z$$)
);

CREATE TYPE ESTADO2 as ENUM ('en tramite', 'archivado', 'rechazado', 'detenido');
CREATE TYPE CASO2 as ENUM ('judicial', 'civil', 'penal', 'fiscal');

CREATE TABLE casos(
	id_caso SERIAL PRIMARY KEY,
	numero_expediente INT NOT NULL,
	fecha_inicio DATE,
	fecha_final DATE,
	estado ESTADO2,
	
	CONSTRAINT validacion_fecha CHECK (fecha_inicio <= fecha_final)
);

CREATE TABLE casos_clientes(
	dpi_cliente VARCHAR(13),
	id_caso INT UNIQUE,
	
	CONSTRAINT fk_dpi FOREIGN KEY (dpi_cliente) REFERENCES clientes(dpi),
	CONSTRAINT fk_idCaso FOREIGN KEY (id_caso) REFERENCES casos(id_caso)
);
CREATE TABLE abogado(
	colegiado VARCHAR(30) PRIMARY KEY UNIQUE,
	nombre VARCHAR(15),
	apellido VARCHAR(15)
);
CREATE TABLE casos_abogados(
	id_caso INT,
	colegiado_abogado VARCHAR(20),
	pago FLOAT NOT NULL,
	
	CONSTRAINT index_casos PRIMARY KEY(id_caso, colegiado_abogado),
	CONSTRAINT validacion_pago CHECK (pago >= 0),
	CONSTRAINT fk_id FOREIGN KEY (id_caso) REFERENCES casos(id_caso),
	CONSTRAINT fk_colegiado FOREIGN KEY (colegiado_abogado) REFERENCES abogado(colegiado)
);
/*INSERTS, SELECT, ETC*/
INSERT INTO clientes(dpi, nombre, apellido, direccion, telefono, email, lugar_trabajo, direccion_trabajo)
VALUES('123456789123', 'Andres', 'Gonzalez', '4ta Avenida 5-01, Z8 de mixco', '12345678', 'androsogt@gmail.com', 'Ufinet', 'Direccion de prueba');
INSERT INTO casos(numero_expediente, fecha_inicio, fecha_final, estado) VALUES (5, '2021-01-01', '2022-01-01', 'archivado');
INSERT INTO abogado VALUES('123456789987654321', 'Leonel', 'Ramirez');
INSERT INTO casos_clientes VALUES('123456789123', 1);
INSERT INTO casos_abogados VALUES (1, '123456789987654321', 3500 );

SELECT * FROM casos;
SELECT * FROM clientes;
SELECT * FROM abogado;
SELECT * FROM casos_abogados;
SELECT * FROM casos_clientes;

DROP TABLE casos;
DROP TABLE clientes;
DROP TABLE abogado;
DROP TABLE casos_abogados;
DROP TABLE casos_clientes;
