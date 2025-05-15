DROP DATABASE vertel;
CREATE DATABASE IF NOT EXISTS vertel ;
USE vertel ;

CREATE TABLE IF NOT EXISTS proveedores (
	id_proveedores INT NOT NULL,
	nombre VARCHAR(40),
	PRIMARY KEY (id_proveedores)
);

CREATE TABLE IF NOT EXISTS inventario (
	id_inventario INT NOT NULL,
	nombre VARCHAR(40),
	existencia INT,
	PRIMARY KEY (id_inventario)
);

CREATE TABLE IF NOT EXISTS articulos (
	id_articulo INT NOT NULL,
	id_inventario INT,
	id_proveedor INT,
	descripcion VARCHAR(250),
	monto DOUBLE,
	PRIMARY KEY (id_articulo),
	FOREIGN KEY (id_proveedor) REFERENCES proveedores (id_proveedores),
	FOREIGN KEY (id_inventario) REFERENCES inventario (id_inventario)
);

CREATE TABLE IF NOT EXISTS clientes (
	id_cliente INT NOT NULL,
	nombre VARCHAR(40),
	categoria VARCHAR(40),
	PRIMARY KEY (id_cliente)
);

CREATE TABLE IF NOT EXISTS empleados (
	id_empleado INT NOT NULL,
	nombre VARCHAR(40),
	telefono DECIMAL(10,0),
	correo VARCHAR(40),
    salario double,
	PRIMARY KEY (id_empleado)
);

CREATE TABLE IF NOT EXISTS metodoproveedores (
	id_metodo INT PRIMARY KEY,
	monto DOUBLE,
    id_proveedores INT,
	FOREIGN KEY (id_proveedores) REFERENCES proveedores (id_proveedores)
);


CREATE TABLE IF NOT EXISTS ventas (
	id_venta INT NOT NULL,
	v_id_cliente INT,
	v_id_articulo INT,
	monto DOUBLE,
	nombre_cliente VARCHAR(40),
	fecha DATE,
	metodo VARCHAR(40),
	PRIMARY KEY (id_venta),
    FOREIGN KEY (v_id_cliente)REFERENCES clientes (id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (v_id_articulo) REFERENCES articulos (id_articulo) ON DELETE CASCADE
);

INSERT INTO proveedores (id_proveedores, nombre) VALUES
	(1, 'Lenovo'),
	(2, 'ASUS'),
	(3, 'Corsair');
INSERT INTO inventario (id_inventario, nombre, existencia) VALUES
	(1, 'Laptop',200),
	(2, 'Mouse',100),
	(3, 'Teclado',100),
	(4, 'Monitor',50);
INSERT INTO articulos (id_articulo, id_inventario, id_proveedor, descripcion, monto) VALUES
	(1, 1, 1, 'Laptop HP i5', 750.00),
	(2, 2, 2, 'Mouse inalambrico', 20.00),
	(3, 3, 1, 'Teclado mecanico', 45.00),
	(4, 4, 3, 'Monitor 24 pulgadas', 150.00);
INSERT INTO clientes (id_cliente, nombre, categoria) VALUES
	(101, 'Juan Perez', 'Premium'),
	(102, 'Ana Torres', 'Regular'),
	(103, 'Carlos Mendez', 'Premium'),
	(104, 'Lucia Gomez', 'Nuevo');
INSERT INTO empleados (id_empleado, nombre, telefono, correo, salario) VALUES
	(201, 'Maria Lopez', 78945612, 'mlopez@gmail.com', 1200.00),
	(202, 'Pedro Hernandez', 98765432, 'phernandez@hotmail.com', 1300.00);
INSERT INTO ventas (id_venta, v_id_cliente, v_id_articulo, monto, nombre_cliente, fecha, metodo) VALUES
	(301, 101, 1, 750.00, 'Juan Perez', '2025-05-01', 'Tarjeta'),
	(302, 102, 2, 20.00, 'Ana Torres', '2025-05-03', 'Efectivo'),
	(303, 103, 3, 45.00, 'Carlos Mendez', '2025-05-05', 'Transferencia'),
	(304, 104, 4, 150.00, 'Lucia Gomez', '2025-05-06', 'Tarjeta');
INSERT INTO metodoproveedores (id_metodo, monto, id_proveedores) VALUES
	(1, 1500.00,1),
	(2, 400.00,2),
	(3, 300.00,3);

-- A
SELECT i.id_inventario AS 'Codigo', i.nombre AS 'Nombre', i.existencia AS 'Cantidad' FROM inventario i;
-- B
SELECT * FROM ventas WHERE fecha BETWEEN '2025-01-01' AND '2025-04-31';
SELECT * FROM ventas WHERE v_id_cliente = 101;
SELECT * FROM ventas WHERE metodo = 'Tarjeta';
-- C
SELECT categoria, nombre AS clientes FROM clientes
GROUP BY categoria;
-- D
SELECT p.id_proveedores, p.nombre AS proveedor, a.descripcion, a.monto, a.id_articulo FROM articulos a
INNER JOIN proveedores p ON a.id_proveedor = p.id_proveedores;
-- E
SELECT a.id_articulo, a.descripcion, a.monto, p.nombre AS proveedor
FROM articulos a
JOIN proveedores p ON a.id_proveedor = p.id_proveedores;
-- F
SELECT mp.id_proveedores, p.nombre, mp.monto FROM metodoproveedores mp
JOIN proveedores p ON mp.id_proveedores = p.id_proveedores;
-- G
SELECT * FROM empleados;


