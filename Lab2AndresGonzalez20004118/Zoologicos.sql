CREATE DATABASE zoologicos_mundiales;

CREATE TABLE zoologicos(
	id_Zoologico SERIAL PRIMARY KEY,
	nombre VARCHAR(15),
	pais VARCHAR(15),
	ciudad VARCHAR(15),
	tamanio FLOAT,
	presupuesto FLOAT,
	
	CONSTRAINT validacion_presupuesto CHECK (presupuesto >= 0)
);
CREATE TABLE especie(
	nombre_cientifico VARCHAR(30) PRIMARY KEY,
	nombre_coloquial VARCHAR(30),
	familiar VARCHAR(30),
	peligro_extincion BOOLEAN
);

CREATE TYPE SEXO AS ENUM('Macho', 'Hembra');

CREATE TABLE animales(
	numero_identificacion SERIAL PRIMARY KEY,
	id_zoologico SERIAL,
	nombre VARCHAR(15),
	especie VARCHAR(30),
	sexo_animal SEXO, /*PONER LISTADO, VERIFICAR APUNTES PRENG*/
	anio_nacimiento INT,
	pais VARCHAR(15),
	CONSTRAINT fk_especie FOREIGN KEY(especie) REFERENCES especie(nombre_cientifico),
	CONSTRAINT fk_id FOREIGN KEY(id_zoologico) REFERENCES zoologicos(id_Zoologico)
);

/*INSERT Y DROPS*/

INSERT INTO especie VALUES('Spheniscus humboldti', 'Pinguinos Humboldt', 'Spheniscidae', FALSE);
INSERT INTO especie VALUES ('Vulpes vulpes', 'Zorros rojos', 'Cánidos', FALSE);
INSERT INTO especie VALUES('Canis lupus', 'Lobos grises', 'Canidae', FALSE);

INSERT INTO zoologicos(nombre, pais,ciudad,tamanio,presupuesto) VALUES ('Aurora', 'Guatemala', 'Guatemala', 1500, 150000);
INSERT INTO zoologicos(nombre, pais,ciudad,tamanio,presupuesto) VALUES ('Central Park', 'Estados Unidos', 'NYC', 10000, 1000000);
INSERT INTO zoologicos(nombre, pais,ciudad,tamanio,presupuesto) VALUES ('Zoo London', 'Inglaterra', 'Londres', 10000, 1000000);

INSERT INTO animales (id_zoologico, nombre, especie, sexo_animal, anio_nacimiento,pais) VALUES(1, 'Kowalsky', 'Spheniscus humboldti', 'Macho', 123, 'Chile');
INSERT INTO animales (id_zoologico, nombre, especie, sexo_animal, anio_nacimiento,pais) VALUES(1, 'Cabo', 'Spheniscus humboldti', 'Hembra', 2002, 'Chile');
INSERT INTO animales (id_zoologico, nombre, especie, sexo_animal, anio_nacimiento,pais) VALUES(2, 'Mr Fox', 'Vulpes vulpes', 'Macho', 456, 'USA');
INSERT INTO animales (id_zoologico, nombre, especie, sexo_animal, anio_nacimiento,pais) VALUES(2, 'Ms. Fox', 'Vulpes vulpes', 'Hembra', 987, 'England');
INSERT INTO animales (id_zoologico, nombre, especie, sexo_animal, anio_nacimiento,pais) VALUES(3, 'Hanzel', 'Canis lupus', 'Macho', 2006, 'Belgium');
INSERT INTO animales (id_zoologico, nombre, especie, sexo_animal, anio_nacimiento,pais) VALUES(3, 'Gretel', 'Canis lupus', 'Hembra', 2006, 'Belgium');


DROP TABLE animales;
DROP TABLE Zoologicos;
DROP TABLE especie;

SELECT * FROM animales WHERE animales.id_zoologico = 4;

SELECT * FROM especie;
SELECT * FROM animales;
SELECT * FROM zoologicos;