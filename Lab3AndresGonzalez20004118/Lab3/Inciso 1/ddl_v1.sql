CREATE DATABASE laboratorio3;

DROP TABLE reservas, clientes, aviones, vuelos;

--#Tabla de clientes
CREATE TABLE clientes(
	id INT PRIMARY KEY,
    noPasaporte VARCHAR(12) UNIQUE,

    nombre VARCHAR(15),
    apellido VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE aviones(
	id INT PRIMARY KEY,
    matricula VARCHAR(6) UNIQUE,
    linea VARCHAR(20),
    modelo VARCHAR(20),
    capacidad INT,
    fabricante VARCHAR(100)
);


--Tabla de vuelos.
CREATE TABLE vuelos (
	id INT PRIMARY KEY,
    numVuelo VARCHAR(7) UNIQUE,
    paisOrigen VARCHAR(100),
    paisDestino VARCHAR(100),
    fechaSalida DATE,
    horaSalida TIME,
    fechaLlegada DATE,
    horaLlegada TIME,
    avionRef VARCHAR(6),
    vacantes INT,
    
    CONSTRAINT fk_vuelos_aviones 
		FOREIGN KEY (avionRef) REFERENCES aviones(matricula)
);

CREATE TABLE reservas(
	id INT PRIMARY KEY,
    cliente_noPasaporte VARCHAR(12),
    vuelos_numVuelo VARCHAR(7),
    
    --llave foranea para pasaporte.
    CONSTRAINT fk_reservas_clientes 
		FOREIGN KEY (cliente_noPasaporte) REFERENCES clientes(noPasaporte),
        
	--#llave foranea para vuelos.
    CONSTRAINT fk_reservas_vuelos
		FOREIGN KEY (vuelos_numVuelo) REFERENCES vuelos(numVuelo)
);



