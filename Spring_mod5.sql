CREATE DATABASE soporte_tecnico;

USE soporte_tecnico;
CREATE USER 'admin' WITH PASSWORD 'password123';
GRANT ALL PRIVILEGES ON soporte_tecnico.* TO 'admin' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON soporte_tecnico.* TO 'admin' WITH GRANT OPTION;CREATE TABLE usuarios (
  id_usuario INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  correo_electronico VARCHAR(100) NOT NULL,
  fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  tipo_usuario ENUM('cliente', 'operador', 'soporte') NOT NULL
);

CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL,
    tipo_usuario ENUM('cliente', 'operador', 'soporte') NOT NULL
);

CREATE TABLE operadores (
  id_operador INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  correo_electronico VARCHAR(100) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  tipo_usuario ENUM('operador') NOT NULL
);

CREATE TABLE operaciones_soporte (
  id_operacion INT PRIMARY KEY AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  id_operador INT NOT NULL,
  fecha_operacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  descripcion TEXT,
  evaluacion INT NOT NULL,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
  FOREIGN KEY (id_operador) REFERENCES operadores(id_operador)
);

-- Usuarios
INSERT INTO usuarios (nombre, apellido, correo_electronico, tipo_usuario) VALUES
('Juan', 'Perez', 'juan.perez@email.com', 'cliente'),
('Maria', 'Garcia', 'maria.garcia@email.com', 'cliente'),
('Pedro', 'Lopez', 'pedro.lopez@email.com', 'operador'),
('Ana', 'Gomez', 'ana.gomez@email.com', 'operador'),
('Carlos', 'Sanchez', 'carlos.sanchez@email.com', 'soporte');

-- Operadores
INSERT INTO operadores (nombre, apellido, correo_electronico, fecha_nacimiento, tipo_usuario) VALUES
('Diego', 'Rojas', 'diego.rojas@email.com', '1990-01-01', 'operador'),
('Sofia', 'Martinez', 'sofia.martinez@email.com', '1995-07-05', 'operador'),
('David', 'Ramirez', 'david.ramirez@email.com', '1985-12-24', 'operador'),
('Patricia', 'Flores', 'patricia.flores@email.com', '1993-03-10', 'operador'),
('Miguel', 'Arias', 'miguel.arias@email.com', '1988-06-18', 'operador');

-- Operaciones de soporte
INSERT INTO operaciones_soporte (id_usuario, id_operador, descripcion, evaluacion) VALUES
(1, 2, 'Problema con la instalación del software', 5),
(2, 3, 'Error al iniciar sesión', 4),
(3, 4, 'Dificultad para usar una herramienta', 3),
(1, 2, 'Solicitud de información', 5),
(2, 5, 'Reporte de un bug', 2),
(3, 1, 'Consulta sobre un producto', 5),
(4, 3, 'Problema de rendimiento', 4),
(5, 2, 'Sugerencia para mejorar la aplicación', 5),
(1, 4, 'Ayuda con una configuración', 3),
(2, 5, 'Solicitud de soporte técnico', 5);

-- Consultas:

-- 1. Seleccionar las 3 operaciones con mejor evaluación:

SELECT descripcion, evaluacion
FROM operaciones_soporte
ORDER BY evaluacion DESC
LIMIT 3;

-- 2. Seleccionar las 3 operaciones con menos evaluación:

SELECT descripcion, evaluacion
FROM operaciones_soporte
ORDER BY evaluacion ASC
LIMIT 3;

-- 3. Seleccionar al operario que más soportes ha realizado:

SELECT o.nombre, o.apellido, COUNT(*) AS cantidad_soportes
FROM operadores o
INNER JOIN operaciones_soporte os ON o.id_operador = os.id_operador
GROUP BY o.id_operador, o.nombre, o.apellido
ORDER BY cantidad_soportes DESC
LIMIT 1;



-- 4. Cliente que menos ha utilizado la aplicación:

SELECT u.nombre, u.apellido, COUNT(o.id_operacion) AS cantidad_operaciones
FROM usuarios AS u
LEFT JOIN operaciones_soporte AS o ON u.id_usuario = o.id_usuario
GROUP BY u.id_usuario
ORDER BY cantidad_operaciones ASC
LIMIT 1;

-- 5. Agregar 10 años a los 3 primeros usuarios registrados:

UPDATE operadores o
INNER JOIN (
  SELECT id_operador
  FROM operadores
  ORDER BY id_operador
  LIMIT 3
) AS first_three ON o.id_operador = first_three.id_operador
SET o.fecha_nacimiento = DATE_ADD(o.fecha_nacimiento, INTERVAL 10 YEAR);

-- 6. Renombrar las columnas 'correo electrónico':

ALTER TABLE usuarios RENAME COLUMN correo_electronico TO email;
ALTER TABLE operadores RENAME COLUMN correo_electronico TO email;

SELECT o.nombre, o.apellido, o.fecha_nacimiento
FROM operadores o
WHERE DATEDIFF(CURDATE(), o.fecha_nacimiento) / 365.25 > 20;