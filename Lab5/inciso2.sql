CREATE TABLE peliculas(
    id_pelicula SERIAL PRIMARY KEY,
    titulo_distribucion VARCHAR(25),
    titulo_original VARCHAR(25),
    genero VARCHAR(25),
    idioma VARCHAR(25),
    subtitulos BOOLEAN,
    fecha_estreno DATE,
    pais VARCHAR(25),
    url_web VARCHAR(25),
    clasificacion_edad CLASIFICACION,
    duracion_minutos INT,
    sinopsis VARCHAR(100)
);
CREATE TYPE CLASIFICACION as ENUM ('A', 'B12', 'C15', 'C18');
CREATE TYPE CALIFICACION as ENUM ('Obra maestra', 'Muy buena', 'Buena', 'Regular', 'Mala');

CREATE TABLE criticas(
    id_critica SERIAL,
    id_pelicula INT,
    nombre_critico VARCHAR(25),
    edad int,
    fecha DATE,
    comentario varchar(100),
    calificacion CLASIFICACION,

    CONSTRAINT fk_idpelicula FOREIGN KEY (id_pelicula) REFERENCES peliculas(id_pelicula)
);
CREATE TABLE funciones(
    numero_funcion SERIAL PRIMARY KEY,
    id_cine INT,
    numero_sala INT,
    id_pelicula INT,
    dia_semana DATE,
    hora_inicio DATE,

    CONSTRAINT fk_idcine FOREIGN KEY (id_cine) REFERENCES cines(id_cine),
    CONSTRAINT fk_idsala FOREIGN KEY (numero_sala) REFERENCES salas(numero_sala)
);

CREATE TABLE cines(
    id_cine SERIAL PRIMARY KEY,
    nombre VARCHAR(30),
    direccion VARCHAR(30),
    telefono VARCHAR(8)
);

CREATE TABLE salas(
    numero_sala SERIAL PRIMARY KEY,
    id_cine INT,
    capacidad INT,

    CONSTRAINT fk_ubicacionsala FOREIGN KEY (id_cine) REFERENCES cines(id_cine)
);

CREATE TABLE participantes(
    id_participante SERIAL PRIMARY KEY,
    nacionalidad VARCHAR(15)
);

CREATE TABLE reparto(
    id_reparto SERIAL PRIMARY KEY ,
    id_pelicula INT,
    id_participante INT,
    rol ROL,
    personaje VARCHAR(15),  /*PODRIA  SER NULO EN CASO QUE SEA DIRECTOR */

    CONSTRAINT fk_idpelicula FOREIGN KEY (id_pelicula) REFERENCES peliculas(id_pelicula)
);

CREATE TYPE ROL as ENUM ('director', 'actor');
