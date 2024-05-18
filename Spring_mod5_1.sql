CREATE DATABASE En_que_puedo_ayudarte;
USE En_que_puedo_ayudarte;


CREATE TABLE usuarios (
  id_usuario INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  correo_electronico VARCHAR(100) NOT NULL,
  fecha_registro DATE NOT NULL,
  edad INT NOT NULL
);

CREATE TABLE operadores (
  id_operador INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  correo_electronico VARCHAR(100) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  experiencia_anios INT NOT NULL
);

CREATE TABLE operaciones_soporte (
  id_operacion INT PRIMARY KEY AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  id_operador INT NOT NULL,
  fecha_hora_inicio DATETIME NOT NULL,
  fecha_hora_fin DATETIME NOT NULL,
  descripcion VARCHAR(255) NOT NULL,
  evaluacion INT NOT NULL
);

-- Relaciones entre tablas
ALTER TABLE operaciones_soporte
  ADD FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
  ADD FOREIGN KEY (id_operador) REFERENCES operadores(id_operador);
  
  INSERT INTO usuarios (nombre, apellido, correo_electronico, fecha_registro, edad)
VALUES
  ('Juan', 'Pérez', 'juan.perez@email.com', '2024-05-16', 30),
  ('María', 'García', 'maria.garcia@email.com', '2024-05-15', 25),
  ('Pedro', 'López', 'pedro.lopez@email.com', '2024-05-14', 42),
  ('Ana', 'Román', 'ana.roman@email.com', '2024-05-13', 28),
  ('Carlos', 'Sánchez', 'carlos.sanchez@email.com', '2024-05-12', 18);
  
  INSERT INTO operadores (nombre, apellido, correo_electronico, fecha_nacimiento, experiencia_anios)
VALUES
  ('Diego', 'Torres', 'diego.torres@email.com', '1998-01-01', 5),
  ('Andrea', 'Gutiérrez', 'andrea.gutierrez@email.com', '2000-07-15', 3),
  ('Francisco', 'González', 'francisco.gonzalez@email.com', '1995-12-24', 8),
  ('Sofia', 'Muñoz', 'sofia.munoz@email.com', '2002-03-08', 1),
  ('David', 'Ramírez', 'david.ramirez@email.com', '1997-11-10', 6);
  INSERT INTO operaciones_soporte (id_usuario, id_operador, fecha_hora_inicio, fecha_hora_fin, descripcion, evaluacion)
VALUES
  (1, 1, '2024-05-16 10:00:00', '2024-05-16 10:30:00', 'Problema al iniciar sesión', 5),
  (2, 2, '2024-05-15 14:00:00', '2024-05-15 14:30:00', 'Duda sobre el uso de una herramienta', 4),
  (3, 3, '2024-05-17 11:00:00', '2024-05-17 11:30:00', 'Lentitud en el sistema', 2),
  (4, 4, '2024-05-16 15:00:00', '2024-05-16 15:30:00', 'Error al imprimir un documento', 3),
  (5, 5, '2024-05-15 10:00:00', '2024-05-15 10:30:00', 'Solicitud de cambio de contraseña', 4),
  (6, 6, '2024-05-14 12:00:00', '2024-05-14 12:30:00', 'Problema con la conexión a internet', 1),
  (7, 7, '2024-05-13 16:00:00', '2024-05-13 16:30:00', 'Consulta sobre un proceso', 5),
  (8, 8, '2024-05-12 11:00:00', '2024-05-12 11:30:00', 'Instalación de software', 3),
  (9, 9, '2024-05-11 15:00:00', '2024-05-11 15:30:00', 'Configuración de correo electrónico', 4),
  (10, 10, '2024-05-10 10:00:00', '2024-05-10 10:30:00', 'Capacitación sobre el uso de una aplicación', 5);
