
-- =============================================
-- 1. CREACIÓN DE TABLAS
-- =============================================

CREATE TABLE TiposPropiedad (
    id_tipo SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    estado CHAR(1) DEFAULT 'I'
);

CREATE TABLE Zonas (
    id_zona SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    estado CHAR(1) DEFAULT 'I'
);

CREATE TABLE EstadosPropiedad (
    id_estado SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    estado CHAR(1) DEFAULT 'I'
);

CREATE TABLE Propietarios (
    id_propietario SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(100),
    estado CHAR(1) DEFAULT 'I'
);

CREATE TABLE Clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(100),
    estado CHAR(1) DEFAULT 'I'
);

CREATE TABLE Agentes (
    id_agente SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(100),
    estado CHAR(1) DEFAULT 'I'
);

CREATE TABLE Propiedades (
    id_propiedad SERIAL PRIMARY KEY,
    direccion VARCHAR(200) NOT NULL,
    precio NUMERIC(12, 2) NOT NULL,
    superficie NUMERIC(10, 2),
    habitaciones INT,
    banos INT,
    descripcion TEXT,
    id_tipo INT REFERENCES TiposPropiedad(id_tipo),
    id_zona INT REFERENCES Zonas(id_zona),
    id_estado INT REFERENCES EstadosPropiedad(id_estado),
    id_propietario INT REFERENCES Propietarios(id_propietario),
    estado CHAR(1) DEFAULT 'I'
);

CREATE TABLE Caracteristicas (
    id_caracteristica SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    estado CHAR(1) DEFAULT 'I'
);

CREATE TABLE PropiedadExtras (
    id_propiedad INT REFERENCES Propiedades(id_propiedad),
    id_caracteristica INT REFERENCES Caracteristicas(id_caracteristica),
    PRIMARY KEY(id_propiedad, id_caracteristica),
    estado CHAR(1) DEFAULT 'I'
);

CREATE TABLE ClientesInteresados (
    id_cliente INT REFERENCES Clientes(id_cliente),
    id_propiedad INT REFERENCES Propiedades(id_propiedad),
    PRIMARY KEY(id_cliente, id_propiedad),
    estado CHAR(1) DEFAULT 'I'
);

CREATE TABLE FotosPropiedad (
    id_foto SERIAL PRIMARY KEY,
    id_propiedad INT REFERENCES Propiedades(id_propiedad),
    url_foto TEXT,
    estado CHAR(1) DEFAULT 'I'
);

CREATE TABLE Visitas (
    id_visita SERIAL PRIMARY KEY,
    id_propiedad INT REFERENCES Propiedades(id_propiedad),
    id_cliente INT REFERENCES Clientes(id_cliente),
    id_agente INT REFERENCES Agentes(id_agente),
    fecha_visita DATE,
    comentario TEXT,
    estado CHAR(1) DEFAULT 'I'
);

CREATE TABLE Ofertas (
    id_oferta SERIAL PRIMARY KEY,
    id_propiedad INT REFERENCES Propiedades(id_propiedad),
    id_cliente INT REFERENCES Clientes(id_cliente),
    monto NUMERIC(12, 2),
    estado VARCHAR(20) DEFAULT 'pendiente',
    fecha_oferta DATE,
    estado_oferta CHAR(1) DEFAULT 'I'
);

CREATE TABLE Contratos (
    id_contrato SERIAL PRIMARY KEY,
    id_oferta INT REFERENCES Ofertas(id_oferta),
    id_agente INT REFERENCES Agentes(id_agente),
    fecha_inicio DATE,
    fecha_fin DATE,
    tipo_contrato VARCHAR(10), -- venta/alquiler
    comision NUMERIC(12, 2),
    estado CHAR(1) DEFAULT 'I'
);

-- =============================================
-- 2. INSERCIÓN DE DATOS EJEMPLO (mínimo 5 filas por tabla)
-- =============================================

INSERT INTO TiposPropiedad(nombre, estado) VALUES
('Casa', 'O'), ('Apartamento', 'O'), ('Local', 'O'), ('Oficina', 'O'), ('Terreno', 'O');

INSERT INTO Zonas(nombre, estado) VALUES
('Centro', 'O'), ('Norte', 'O'), ('Sur', 'O'), ('Este', 'O'), ('Oeste', 'O');

INSERT INTO EstadosPropiedad(nombre, estado) VALUES
('Disponible', 'O'), ('Reservada', 'O'), ('Vendida', 'O'), ('Alquilada', 'O');

INSERT INTO Propietarios(nombre, telefono, email, estado) VALUES
('Juan Pérez', '3001234567', 'juan@email.com', 'O'),
('Ana López', '3011234567', 'ana@email.com', 'O'),
('Carlos Ruiz', '3021234567', 'carlos@email.com', 'O'),
('Marta Díaz', '3031234567', 'marta@email.com', 'O'),
('Luis Gómez', '3041234567', 'luis@email.com', 'O');

INSERT INTO Clientes(nombre, telefono, email, estado) VALUES
('Pedro Martínez', '3101234567', 'pedro@email.com', 'O'),
('Lucía Herrera', '3111234567', 'lucia@email.com', 'O'),
('Jorge Núñez', '3121234567', 'jorge@email.com', 'O'),
('Sofía Vega', '3131234567', 'sofia@email.com', 'O'),
('Miguel Castro', '3141234567', 'miguel@email.com', 'O');

INSERT INTO Agentes(nombre, telefono, email, estado) VALUES
('Carlos Bravo', '3201234567', 'carlosb@email.com', 'O'),
('Daniela Ríos', '3211234567', 'daniela@email.com', 'O'),
('Oscar León', '3221234567', 'oscar@email.com', 'O'),
('Julia Méndez', '3231234567', 'julia@email.com', 'O'),
('Esteban Rico', '3241234567', 'esteban@email.com', 'O');

INSERT INTO Caracteristicas(nombre, estado) VALUES
('Balcón', 'O'), ('Parqueadero', 'O'), ('Piscina', 'O'), ('Jardín', 'O'), ('Terraza', 'O');

INSERT INTO Propiedades(direccion, precio, superficie, habitaciones, banos, descripcion, id_tipo, id_zona, id_estado, id_propietario, estado) VALUES
('Calle 123 #45-67', 250000000, 120.5, 3, 2, 'Casa amplia con patio', 1, 1, 1, 1, 'O'),
('Carrera 10 #20-30', 180000000, 85.0, 2, 1, 'Apartamento céntrico', 2, 1, 1, 2, 'O'),
('Av. Siempre Viva 123', 300000000, 140.0, 4, 3, 'Casa familiar grande', 1, 2, 1, 3, 'O'),
('Cra 5 #10-12', 130000000, 60.0, 1, 1, 'Local comercial', 3, 1, 1, 4, 'O'),
('Calle 99 #20-45', 220000000, 100.0, 3, 2, 'Apartamento con vista', 2, 5, 1, 5, 'O');

INSERT INTO PropiedadExtras VALUES
(1, 1, 'O'), (1, 2, 'O'), (2, 1, 'O'), (3, 3, 'O'), (4, 4, 'O');

INSERT INTO ClientesInteresados VALUES
(1, 1, 'O'), (2, 2, 'O'), (3, 3, 'O'), (4, 4, 'O'), (5, 5, 'O');

INSERT INTO FotosPropiedad(id_propiedad, url_foto, estado) VALUES
(1, 'foto1.jpg', 'O'), (2, 'foto2.jpg', 'O'), (3, 'foto3.jpg', 'O'), (4, 'foto4.jpg', 'O'), (5, 'foto5.jpg', 'O');

INSERT INTO Visitas(id_propiedad, id_cliente, id_agente, fecha_visita, comentario, estado) VALUES
(1, 1, 1, '2024-04-01', 'Cliente interesado', 'O'),
(2, 2, 2, '2024-04-02', 'Quiere segunda cita', 'O'),
(3, 3, 3, '2024-04-03', 'Indeciso', 'O'),
(4, 4, 4, '2024-04-04', 'Revisará con pareja', 'O'),
(5, 5, 5, '2024-04-05', 'Muy interesado', 'O');

INSERT INTO Ofertas(id_propiedad, id_cliente, monto, estado, fecha_oferta, estado_oferta) VALUES
(1, 1, 255000000, 'aceptada', '2024-04-10', 'O'),
(2, 2, 170000000, 'rechazada', '2024-04-12', 'O'),
(3, 3, 310000000, 'pendiente', '2024-04-15', 'O'),
(4, 4, 135000000, 'pendiente', '2024-04-17', 'O'),
(5, 5, 225000000, 'pendiente', '2024-04-18', 'O');

INSERT INTO Contratos(id_oferta, id_agente, fecha_inicio, fecha_fin, tipo_contrato, comision, estado) VALUES
(1, 1, '2024-04-20', '2025-04-20', 'venta', 5000000, 'O'),
(2, 2, '2024-04-22', '2025-04-22', 'alquiler', 3000000, 'O'),
(3, 3, '2024-04-25', '2025-04-25', 'venta', 6000000, 'O'),
(4, 4, '2024-04-27', '2025-04-27', 'alquiler', 4000000, 'O'),
(5, 5, '2024-04-29', '2025-04-29', 'venta', 4500000, 'O');



INDEXACIÓN

-- 1. Índices en la tabla Propiedades
CREATE INDEX idx_propiedades_tipo ON Propiedades(id_tipo);
CREATE INDEX idx_propiedades_zona ON Propiedades(id_zona);
CREATE INDEX idx_propiedades_precio ON Propiedades(precio);
CREATE INDEX idx_propiedades_estado ON Propiedades(estado);
CREATE INDEX idx_propiedades_tipo_zona ON Propiedades(id_tipo, id_zona);
CREATE INDEX idx_propiedades_estado_precio ON Propiedades(estado, precio);

-- 2. Índices en la tabla Clientes
CREATE INDEX idx_clientes_nombre ON Clientes(nombre);
CREATE INDEX idx_clientes_email ON Clientes(email);

-- 3. Índices en la tabla Agentes
CREATE INDEX idx_agentes_nombre ON Agentes(nombre);
CREATE INDEX idx_agentes_email ON Agentes(email);

-- 4. Índices en la tabla Visitas
CREATE INDEX idx_visitas_agente ON Visitas(id_agente);
CREATE INDEX idx_visitas_cliente ON Visitas(id_cliente);
CREATE INDEX idx_visitas_propiedad ON Visitas(id_propiedad);
CREATE INDEX idx_visitas_fecha ON Visitas(fecha_visita);

-- 5. Índices en la tabla Ofertas
CREATE INDEX idx_ofertas_propiedad ON Ofertas(id_propiedad);
CREATE INDEX idx_ofertas_cliente ON Ofertas(id_cliente);
CREATE INDEX idx_ofertas_estado ON Ofertas(estado_oferta);
CREATE INDEX idx_ofertas_fecha ON Ofertas(fecha_oferta);

-- 6. Índices en la tabla Contratos
CREATE INDEX idx_contratos_oferta ON Contratos(id_oferta);
CREATE INDEX idx_contratos_agente ON Contratos(id_agente);
CREATE INDEX idx_contratos_fecha_inicio ON Contratos(fecha_inicio);
CREATE INDEX idx_contratos_estado ON Contratos(estado);

-- 7. Índices en la tabla Caracteristicas
CREATE INDEX idx_caracteristicas_nombre ON Caracteristicas(nombre);

-- 8. Índices en la tabla PropiedadExtras
CREATE INDEX idx_propiedad_extras_propiedad ON PropiedadExtras(id_propiedad);
CREATE INDEX idx_propiedad_extras_caracteristica ON PropiedadExtras(id_caracteristica);

-- 9. Índices en la tabla ClientesInteresados
CREATE INDEX idx_clientes_interesados_cliente ON ClientesInteresados(id_cliente);
CREATE INDEX idx_clientes_interesados_propiedad ON ClientesInteresados(id_propiedad);

-- 10. Índices en la tabla FotosPropiedad
CREATE INDEX idx_fotos_propiedad ON FotosPropiedad(id_propiedad);

-- 11. Índices en la tabla Zonas
CREATE INDEX idx_zonas_nombre ON Zonas(nombre);

-- 12. Índices en la tabla EstadosPropiedad
CREATE INDEX idx_estados_propiedad_nombre ON EstadosPropiedad(nombre);



-- Índices compuestos
CREATE INDEX idx_propiedades_tipo_zona_precio ON Propiedades(id_tipo, id_zona, precio);
CREATE INDEX idx_ofertas_estado_cliente ON Ofertas(estado_oferta, id_cliente);
CREATE INDEX idx_visitas_agente_cliente ON Visitas(id_agente, id_cliente);





CREATE VIEW vista_propiedades_disponibles AS
SELECT 
    p.id_propiedad, 
    p.direccion, 
    p.precio, 
    tp.nombre AS tipo, 
    z.nombre AS zona
FROM 
    Propiedades p
JOIN TiposPropiedad tp ON tp.id_tipo = p.id_tipo
JOIN Zonas z ON z.id_zona = p.id_zona
JOIN EstadosPropiedad ep ON ep.id_estado = p.id_estado
WHERE 
    ep.nombre = 'Disponible' 
    AND p.estado = 'O';



CREATE VIEW vista_historial_visitas_cliente AS
SELECT 
    v.id_visita, 
    v.fecha_visita, 
    p.direccion, 
    a.nombre AS agente
FROM 
    Visitas v
JOIN Propiedades p ON p.id_propiedad = v.id_propiedad
JOIN Agentes a ON a.id_agente = v.id_agente
WHERE 
    v.estado = 'O';



CREATE VIEW vista_ofertas_por_propiedad AS
SELECT 
    o.id_oferta, 
    o.monto, 
    o.fecha_oferta, 
    o.estado, 
    c.nombre AS cliente, 
    p.direccion
FROM 
    Ofertas o
JOIN Clientes c ON c.id_cliente = o.id_cliente
JOIN Propiedades p ON p.id_propiedad = o.id_propiedad
WHERE 
    o.estado_oferta = 'O';


CREATE VIEW vista_agentes_con_contratos AS
SELECT 
    ag.id_agente, 
    ag.nombre, 
    COUNT(c.id_contrato) AS total_contratos
FROM 
    Agentes ag
LEFT JOIN Contratos c ON c.id_agente = ag.id_agente
WHERE 
    ag.estado = 'O'
GROUP BY 
    ag.id_agente;




CREATE VIEW vista_propiedades_detalle AS
SELECT
    p.id_propiedad,
    p.direccion,
    p.precio,
    p.superficie,
    p.habitaciones,
    p.banos,
    p.descripcion,
    tp.nombre AS tipo_propiedad,
    z.nombre AS zona,
    ep.nombre AS estado_propiedad,
    pr.nombre AS nombre_propietario,
    pr.telefono AS telefono_propietario,
    pr.email AS email_propietario
FROM 
    Propiedades p
JOIN TiposPropiedad tp ON p.id_tipo = tp.id_tipo
JOIN Zonas z ON p.id_zona = z.id_zona
JOIN EstadosPropiedad ep ON p.id_estado = ep.id_estado
JOIN Propietarios pr ON p.id_propietario = pr.id_propietario
WHERE 
    p.estado = 'O' 
    AND tp.estado = 'O' 
    AND z.estado = 'O' 
    AND ep.estado = 'O' 
    AND pr.estado = 'O';




-- Crear propiedad
CREATE OR REPLACE FUNCTION crear_propiedad(
    _direccion VARCHAR, _precio NUMERIC, _superficie NUMERIC,
    _habitaciones INT, _banos INT, _descripcion TEXT,
    _id_tipo INT, _id_zona INT, _id_estado INT, _id_propietario INT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO Propiedades (direccion, precio, superficie, habitaciones, banos, descripcion, id_tipo, id_zona, id_estado, id_propietario, estado)
    VALUES (_direccion, _precio, _superficie, _habitaciones, _banos, _descripcion, _id_tipo, _id_zona, _id_estado, _id_propietario, 'O');
END;
$$ LANGUAGE plpgsql;

-- Actualizar propiedad
CREATE OR REPLACE FUNCTION actualizar_propiedad(
    _id_propiedad INT, _direccion VARCHAR, _precio NUMERIC, _superficie NUMERIC,
    _habitaciones INT, _banos INT, _descripcion TEXT,
    _id_tipo INT, _id_zona INT, _id_estado INT, _id_propietario INT
) RETURNS VOID AS $$
BEGIN
    UPDATE Propiedades
    SET direccion = _direccion, precio = _precio, superficie = _superficie,
        habitaciones = _habitaciones, banos = _banos, descripcion = _descripcion,
        id_tipo = _id_tipo, id_zona = _id_zona, id_estado = _id_estado, id_propietario = _id_propietario
    WHERE id_propiedad = _id_propiedad;
END;
$$ LANGUAGE plpgsql;

-- Eliminar (lógico) propiedad
CREATE OR REPLACE FUNCTION eliminar_propiedad(_id_propiedad INT) RETURNS VOID AS $$
BEGIN
    UPDATE Propiedades SET estado = 'I' WHERE id_propiedad = _id_propiedad;
END;
$$ LANGUAGE plpgsql;





CREATE OR REPLACE FUNCTION crear_cliente(_nombre VARCHAR, _telefono VARCHAR, _email VARCHAR) RETURNS VOID AS $$
BEGIN
    INSERT INTO Clientes(nombre, telefono, email, estado) VALUES (_nombre, _telefono, _email, 'O');
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_cliente(_id_cliente INT, _nombre VARCHAR, _telefono VARCHAR, _email VARCHAR) RETURNS VOID AS $$
BEGIN
    UPDATE Clientes SET nombre = _nombre, telefono = _telefono, email = _email WHERE id_cliente = _id_cliente;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_cliente(_id_cliente INT) RETURNS VOID AS $$
BEGIN
    UPDATE Clientes SET estado = 'I' WHERE id_cliente = _id_cliente;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION crear_agente(_nombre VARCHAR, _telefono VARCHAR, _email VARCHAR) RETURNS VOID AS $$
BEGIN
    INSERT INTO Agentes(nombre, telefono, email, estado) VALUES (_nombre, _telefono, _email, 'O');
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_agente(_id_agente INT, _nombre VARCHAR, _telefono VARCHAR, _email VARCHAR) RETURNS VOID AS $$
BEGIN
    UPDATE Agentes SET nombre = _nombre, telefono = _telefono, email = _email WHERE id_agente = _id_agente;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_agente(_id_agente INT) RETURNS VOID AS $$
BEGIN
    UPDATE Agentes SET estado = 'I' WHERE id_agente = _id_agente;
END;
$$ LANGUAGE plpgsql;





CREATE OR REPLACE FUNCTION crear_visita(_id_propiedad INT, _id_cliente INT, _id_agente INT, _fecha DATE, _comentario TEXT) RETURNS VOID AS $$
BEGIN
    INSERT INTO Visitas(id_propiedad, id_cliente, id_agente, fecha_visita, comentario, estado)
    VALUES (_id_propiedad, _id_cliente, _id_agente, _fecha, _comentario, 'O');
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_visita(_id_visita INT, _comentario TEXT) RETURNS VOID AS $$
BEGIN
    UPDATE Visitas SET comentario = _comentario WHERE id_visita = _id_visita;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_visita(_id_visita INT) RETURNS VOID AS $$
BEGIN
    UPDATE Visitas SET estado = 'I' WHERE id_visita = _id_visita;
END;
$$ LANGUAGE plpgsql;





CREATE OR REPLACE FUNCTION crear_oferta(_id_propiedad INT, _id_cliente INT, _monto NUMERIC, _fecha DATE) RETURNS VOID AS $$
BEGIN
    INSERT INTO Ofertas(id_propiedad, id_cliente, monto, estado, fecha_oferta, estado_oferta)
    VALUES (_id_propiedad, _id_cliente, _monto, 'pendiente', _fecha, 'O');
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION actualizar_oferta(_id_oferta INT, _estado VARCHAR) RETURNS VOID AS $$
BEGIN
    UPDATE Ofertas SET estado = _estado WHERE id_oferta = _id_oferta;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION eliminar_oferta(_id_oferta INT) RETURNS VOID AS $$
BEGIN
    UPDATE Ofertas SET estado_oferta = 'I' WHERE id_oferta = _id_oferta;
END;
$$ LANGUAGE plpgsql;







CREATE OR REPLACE FUNCTION registrar_nueva_visita() 
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Auditoria (tabla, accion, id_registro, fecha) 
    VALUES ('Visitas', 'INSERT', NEW.id_visita, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_registrar_nueva_visita
AFTER INSERT ON Visitas
FOR EACH ROW
EXECUTE FUNCTION registrar_nueva_visita();



CREATE OR REPLACE FUNCTION cambiar_estado_propiedad() 
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Auditoria (tabla, accion, id_registro, fecha) 
    VALUES ('Propiedades', 'UPDATE', NEW.id_propiedad, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_cambiar_estado_propiedad
AFTER UPDATE ON Propiedades
FOR EACH ROW
WHEN (OLD.id_estado IS DISTINCT FROM NEW.id_estado)
EXECUTE FUNCTION cambiar_estado_propiedad();



CREATE OR REPLACE FUNCTION registrar_aceptacion_oferta() 
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Auditoria (tabla, accion, id_registro, fecha) 
    VALUES ('Ofertas', 'UPDATE', NEW.id_oferta, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_registrar_aceptacion_oferta
AFTER UPDATE ON Ofertas
FOR EACH ROW
WHEN (OLD.estado_oferta IS DISTINCT FROM NEW.estado_oferta AND NEW.estado_oferta = 'aceptada')
EXECUTE FUNCTION registrar_aceptacion_oferta();



WITH propiedades_disponibles AS (
    SELECT p.id_propiedad, p.direccion, p.precio, tp.nombre AS tipo, z.nombre AS zona
    FROM Propiedades p
    JOIN TiposPropiedad tp ON tp.id_tipo = p.id_tipo
    JOIN Zonas z ON z.id_zona = p.id_zona
    JOIN EstadosPropiedad ep ON ep.id_estado = p.id_estado
    WHERE ep.nombre = 'Disponible' AND p.estado = 'O'
)
SELECT pd.id_propiedad, pd.direccion, pd.precio, pd.tipo, pd.zona, c.nombre AS caracteristica
FROM propiedades_disponibles pd
JOIN PropiedadExtras pe ON pe.id_propiedad = pd.id_propiedad
JOIN Caracteristicas c ON c.id_caracteristica = pe.id_caracteristica
WHERE c.estado = 'O';




WITH clientes_interesados AS (
    SELECT ci.id_cliente, ci.id_propiedad
    FROM ClientesInteresados ci
    WHERE ci.estado = 'O'
)
SELECT 
    ci.id_cliente, 
    c.nombre AS cliente, 
    p.direccion, 
    v.fecha_visita, 
    v.comentario
FROM clientes_interesados ci
JOIN Clientes c ON c.id_cliente = ci.id_cliente
JOIN Propiedades p ON p.id_propiedad = ci.id_propiedad
JOIN Visitas v ON v.id_propiedad = ci.id_propiedad
WHERE v.estado = 'O';











-- CONSULTAS Y SUBCONSULTAS POR TABLA

-- ========================
-- Tabla: Propiedades
-- ========================

-- 1. INNER JOIN: Propiedades con tipo, zona y estado
SELECT p.direccion, tp.nombre AS tipo, z.nombre AS zona, ep.nombre AS estado
FROM propiedades p
INNER JOIN tipospropiedad tp ON p.id_tipo = tp.id_tipo
INNER JOIN zonas z ON p.id_zona = z.id_zona
INNER JOIN estadospropiedad ep ON p.id_estado = ep.id_estado;

-- 2. LEFT JOIN: Propiedades con o sin propietarios
SELECT p.direccion, pr.nombre AS propietario
FROM propiedades p
LEFT JOIN propietarios pr ON p.id_propietario = pr.id_propietario;

-- 3. Subconsulta: Propiedades más caras que el promedio
SELECT direccion, precio
FROM propiedades
WHERE precio > (SELECT AVG(precio) FROM propiedades);

-- 4. Subconsulta: Propiedades con más de 2 características
SELECT p.direccion
FROM propiedades p
WHERE (SELECT COUNT(*) FROM propiedadextras pe WHERE pe.id_propiedad = p.id_propiedad) > 2;

-- ========================
-- Tabla: Clientes
-- ========================

-- 1. LEFT JOIN: Clientes interesados en alguna propiedad
SELECT c.nombre, cp.id_propiedad
FROM clientes c
LEFT JOIN clientesinteresados cp ON c.id_cliente = cp.id_cliente;

-- 2. RIGHT JOIN: Todas las propiedades con o sin clientes interesados
SELECT cp.id_cliente, p.direccion
FROM propiedades p
RIGHT JOIN clientesinteresados cp ON p.id_propiedad = cp.id_propiedad;

-- 3. Subconsulta: Clientes con más de 1 propiedad de interés
SELECT nombre
FROM clientes
WHERE id_cliente IN (
    SELECT id_cliente
    FROM clientesinteresados
    GROUP BY id_cliente
    HAVING COUNT(*) > 1
);

-- 4. Subconsulta: Clientes que no han hecho visitas
SELECT nombre
FROM clientes
WHERE id_cliente NOT IN (
    SELECT DISTINCT id_cliente FROM visitas
);

-- ========================
-- Tabla: Agentes
-- ========================

-- 1. INNER JOIN: Agentes y visitas realizadas
SELECT a.nombre, v.fecha_visita, v.id_propiedad
FROM agentes a
INNER JOIN visitas v ON a.id_agente = v.id_agente;

-- 2. LEFT JOIN: Todos los agentes con o sin visitas
SELECT a.nombre, v.fecha_visita
FROM agentes a
LEFT JOIN visitas v ON a.id_agente = v.id_agente;

-- 3. Subconsulta: Agentes que han gestionado más de 2 visitas
SELECT nombre
FROM agentes
WHERE id_agente IN (
    SELECT id_agente
    FROM visitas
    GROUP BY id_agente
    HAVING COUNT(*) > 2
);

-- 4. Subconsulta: Agente más activo (más visitas)
SELECT *
FROM agentes
WHERE id_agente = (
    SELECT id_agente
    FROM visitas
    GROUP BY id_agente
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- ========================
-- Tabla: Visitas
-- ========================

-- 1. INNER JOIN: Visitas con cliente y propiedad
SELECT v.fecha_visita, c.nombre AS cliente, p.direccion
FROM visitas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN propiedades p ON v.id_propiedad = p.id_propiedad;

-- 2. RIGHT JOIN: Todas las propiedades con o sin visitas
SELECT v.id_visita, p.direccion
FROM propiedades p
RIGHT JOIN visitas v ON p.id_propiedad = v.id_propiedad;

-- 3. Subconsulta: Visitas en el mes actual
SELECT *
FROM visitas
WHERE fecha_visita >= (SELECT DATE_TRUNC('month', CURRENT_DATE));

-- 4. Subconsulta: Propiedades más visitadas
SELECT direccion
FROM propiedades
WHERE id_propiedad IN (
    SELECT id_propiedad
    FROM visitas
    GROUP BY id_propiedad
    ORDER BY COUNT(*) DESC
    LIMIT 3
);


