CREATE DATABASE centro_computo;
USE centro_computo;

-- Crear la tabla inventario
CREATE TABLE IF NOT EXISTS inventario (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único
    tipo_equipo VARCHAR(50) NOT NULL,    -- Categoría del equipo (ej. laptop, desktop, cables)
    equipo VARCHAR(100) NOT NULL,      -- Nombre del equipo
    cantidad INT NOT NULL DEFAULT 0    -- Cantidad disponible del equipo
);

INSERT INTO inventario (id, tipo_equipo, equipo, cantidad) 
VALUES
    (1, 'laptop', 'Laptop HP', 10),
    (2, 'laptop', 'Laptop Dell', 8),
    (3, 'desktop', 'Desktop Lenovo', 5),
    (4, 'desktop', 'Desktop Acer', 6),
    (5, 'cables', 'HDMI', 20),
    (6, 'cables', 'VGA', 15),
    (7, 'microfonos', 'Microfono Steren', 12),
    (8, 'microfonos', 'Microfono Tripode', 10),
    (9, 'bocinas', 'Bocinas PC', 7),
    (10, 'bocinas', 'Bocina Tripode', 5),
    (11, 'proyectores', 'Proyector Epson', 3),
    (12, 'proyectores', 'Proyector Epson Negro', 2);

-- Crear la tabla historial_prestamos
DROP TABLE IF EXISTS historial_prestamos;
CREATE TABLE historial_prestamos (
    id INT AUTO_INCREMENT PRIMARY KEY,              -- Identificador único del registro
    fecha_prestamo DATE NOT NULL,                   -- Fecha del préstamo
    tipo_equipo VARCHAR(255) NOT NULL,              -- Tipo de equipo prestado (por ejemplo, laptop, desktop)
    equipo VARCHAR(255) NOT NULL,                   -- Nombre del equipo prestado (por ejemplo, Laptop HP)
    identificador_usuario VARCHAR(255) NOT NULL,    -- Identificador del usuario (matrícula o número de empleado)
    tipo_usuario ENUM('estudiante', 'profesor') NOT NULL, -- Tipo de usuario (estudiante o profesor)
    estado_devolucion ENUM('pendiente', 'devuelto') DEFAULT 'pendiente', -- Estado de la devolución
    fecha_devolucion DATE DEFAULT NULL,             -- Fecha de devolución (opcional, se llena al devolver el equipo)
    hora_devolucion TIME DEFAULT NULL               -- Hora de devolución (opcional, se llena al devolver el equipo)
);

-- Agregar un ejemplo para verificar la estructura de la tabla
INSERT INTO historial_prestamos (fecha_prestamo, tipo_equipo, equipo, identificador_usuario, tipo_usuario, estado_devolucion)
VALUES
    ('2024-11-28', 'laptop', 'Laptop HP', 'zS22016112', 'estudiante', 'pendiente'),
    ('2024-11-27', 'desktop', 'Desktop Lenovo', '12345', 'profesor', 'devuelto');

-- Modificar la tabla solicitudes_e
DROP TABLE IF EXISTS solicitudes_e;
CREATE TABLE solicitudes_e (
    matricula VARCHAR(255) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    apellidos VARCHAR(255) NOT NULL,
    carrera VARCHAR(255) NOT NULL,
    semestre INT NOT NULL,
    motivo_uso TEXT NOT NULL,
    fecha DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    tipo_equipo VARCHAR(255) NOT NULL,
    equipo_disponible VARCHAR(255) NOT NULL,
    ubicacion_uso VARCHAR(255) NOT NULL,
    estado VARCHAR(50) NOT NULL DEFAULT 'pendiente'
);

-- Modificar la tabla solicitudes_p
DROP TABLE IF EXISTS solicitudes_p;
CREATE TABLE solicitudes_p (
    numero_empleado VARCHAR(255) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    apellidos VARCHAR(255) NOT NULL,
    correo VARCHAR(255) NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    motivo_uso TEXT NOT NULL,
    fecha DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    tipo_equipo VARCHAR(255) NOT NULL,
    equipo_disponible VARCHAR(255) NOT NULL,
    ubicacion_uso VARCHAR(255) NOT NULL,
    estado VARCHAR(50) NOT NULL DEFAULT 'pendiente'
);

CREATE OR REPLACE VIEW vista_solicitudes_combinadas AS
SELECT
    matricula AS identificador,
    CONCAT(nombre, ' ', apellidos) AS nombre_completo,
    carrera AS carrera_departamento,
    motivo_uso,
    fecha,
    hora_inicio,
    hora_fin,
    tipo_equipo,
    estado
FROM solicitudes_e
UNION ALL
SELECT
    numero_empleado AS identificador,
    CONCAT(nombre, ' ', apellidos) AS nombre_completo,
    correo AS carrera_departamento,
    motivo_uso,
    fecha,
    hora_inicio,
    hora_fin,
    tipo_equipo,
    estado
FROM solicitudes_p;

CREATE TABLE administradores (
    id INT AUTO_INCREMENT PRIMARY KEY,    -- Identificador único para cada usuario
    username VARCHAR(50) NOT NULL,        -- Nombre de usuario (único)
    password VARCHAR(255) NOT NULL       -- Contraseña del usuario
);
