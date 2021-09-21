CREATE DATABASE club_nautico;
CREATE TABLE socios(
	id_socio SERIAL PRIMARY KEY,
	nombre VARCHAR(15),
	apellido VARCHAR(15),
	correo VARCHAR(25),
	telefono int
);
/*REGEX*/
CREATE TABLE barcos(
	numero_matricula VARCHAR(10) PRIMARY KEY UNIQUE,
	id_propietario SERIAL,
	nombre VARCHAR(15),
	numero_muelle int,
	cuota float,
	CONSTRAINT fk_socio FOREIGN KEY (id_propietario) REFERENCES socios(id_socio)
);
CREATE TABLE salidas(
	numero_matricula VARCHAR(10),
	nombre_capitan VARCHAR(15),
	apellido_capitan VARCHAR(15),
	socio_club BOOLEAN,
	destino VARCHAR(15),
	fecha_salida DATE,
	fecha_llegada DATE,
	CONSTRAINT fk_matricula FOREIGN KEY(numero_matricula) REFERENCES barcos(numero_matricula)
);
DROP TABLE barcos;
DROP TABLE socios;
DROP TABLE salidas;

INSERT INTO barcos(numero_matricula,id_propietario,nombre,numero_muelle,cuota) VALUES('ABCD456',1, 'Santa Maria', 15,1000);
INSERT INTO barcos(numero_matricula,id_propietario,nombre,numero_muelle,cuota) VALUES('FGSD78', 2,'Titanic', 7,1500);
INSERT INTO barcos(numero_matricula,id_propietario,nombre,numero_muelle,cuota) VALUES('POI789', 3,'Nautilus', 1,1250.5);

INSERT INTO socios(nombre, apellido,correo,telefono) VALUES('Andres', 'Gonzalez', 'prueba', 123456);
INSERT INTO socios(nombre, apellido,correo,telefono) VALUES('Pedro', 'Gonzalez', 'pedro@gmail.com', 98765432);
INSERT INTO socios(nombre, apellido,correo,telefono) VALUES('Yuhana', 'Melgar', 'melgar.keyla@saber.com', 65478912);

INSERT INTO salidas VALUES ('ABCD456', 'Juan', 'Lopez', FALSE, 'Uruguay', '2021/04/08', '2021/04/12');
INSERT INTO salidas VALUES ('FGSD78', 'Andres', 'Gonzalez', TRUE, 'Espania', '2021/03/01', '2021/03/12');
INSERT INTO salidas VALUES ('POI789', 'Preng', 'Biba', FALSE, 'Chile', '2021/03/01', '2021/03/12');


SELECT * FROM socios;
SELECT * FROM barcos;
SELECT * FROM salidas;