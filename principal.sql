
USE master
GO
-- Universidad Privada Nueva Esperanza (UPNE) --
IF DB_ID('BRICE') IS NOT NULL 
BEGIN
ALTER DATABASE BRICE SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE BRICE;
END
GO

CREATE DATABASE BRICE
GO

USE BRICE
GO

CREATE TABLE Usuarios (
    IdUsuario INT IDENTITY PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Direccion VARCHAR(200),
    Telefono VARCHAR(20),
    Adm Char(1) not null default 'F' ,
    FechaRegistro DATETIME DEFAULT GETDATE()
)
GO

CREATE TABLE Categorias (
    IdCategoria INT IDENTITY PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(200)
)
GO

CREATE TABLE Productos (
    IdProducto INT IDENTITY PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(300),
    Precio DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL,
    Img varchar(200) default 'https://w7.pngwing.com/pngs/61/877/png-transparent-virus-theat-found-illustration-thumbnail.png',
    IdCategoria INT FOREIGN KEY REFERENCES Categorias(IdCategoria),
    ImagenURL VARCHAR(255)
)
GO

CREATE TABLE MetodosPago (
    IdMetodoPago INT IDENTITY PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Descripcion VARCHAR(100)
)
GO

CREATE TABLE Pedidos (
    IdPedido INT IDENTITY PRIMARY KEY,
    IdUsuario INT FOREIGN KEY REFERENCES Usuarios(IdUsuario),
    FechaPedido DATETIME DEFAULT GETDATE(),
    Total DECIMAL(10,2) NOT NULL,
    Estado VARCHAR(50) DEFAULT 'Pendiente',
    IdMetodoPago INT FOREIGN KEY REFERENCES MetodosPago(IdMetodoPago)
)
GO

CREATE TABLE DetallesPedido (
    IdDetalle INT IDENTITY PRIMARY KEY,
    IdPedido INT FOREIGN KEY REFERENCES Pedidos(IdPedido),
    IdProducto INT FOREIGN KEY REFERENCES Productos(IdProducto),
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    Subtotal AS (Cantidad * PrecioUnitario) PERSISTED
)
GO

-- Insertar categorías
INSERT INTO Categorias (Nombre, Descripcion) VALUES
('Hogar y Cocina', 'Productos para el hogar y utensilios de cocina'),
('Viaje y Camping', 'Artículos para viajes y actividades al aire libre'),
('Limpieza y Cuidado del Hogar', 'Productos de limpieza y organización del hogar'),
('Electrónica y Tecnología', 'Dispositivos electrónicos y accesorios tecnológicos'),
('Deportes y Fitness', 'Equipos y accesorios para deportes y ejercicio'),
('Oficina y Escolar', 'Materiales de oficina y útiles escolares'),
('Jardinería', 'Herramientas y productos para jardinería'),
('Cuidado Personal', 'Artículos para higiene y cuidado personal');
GO

-- Insertar productos para Hogar y Cocina
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, IdCategoria, ImagenURL) VALUES
('Juego de Ollas 5 piezas acero inoxidable', 'Set completo de ollas de acero inoxidable de primera calidad', 129.90, 12, 1, 'https://example.com/ollas.jpg'),
('Sartén antiadherente 24cm Tefal', 'Sartén profesional con recubrimiento antiadherente duradero', 45.50, 18, 1, 'https://example.com/sarten.jpg'),
('Set de tapers herméticos (6 piezas)', 'Contenedores herméticos para almacenar alimentos', 32.90, 25, 1, 'https://example.com/tapers.jpg'),
('Juego de cubiertos 42 piezas acero', 'Elegante juego de cubiertos de acero inoxidable', 68.00, 10, 1, 'https://example.com/cubiertos.jpg'),
('Olla arrocera 2L digital', 'Olla arrocera digital con capacidad para 2 litros', 89.00, 15, 1, 'https://example.com/arrocera.jpg'),
('Batidora de mano 5 velocidades', 'Batidora manual con 5 velocidades y accesorios', 55.90, 20, 1, 'https://example.com/batidora.jpg'),
('Juego de vajilla 16 piezas', 'Vajilla completa para 4 personas, 16 piezas', 75.00, 8, 1, 'https://example.com/vajilla.jpg'),
('Tabla de picar bambú (pack x3)', 'Set de 3 tablas de picar de bambú ecológico', 25.00, 30, 1, 'https://example.com/tablas.jpg'),
('Extractor de jugos 500W', 'Extractor de jugos profesional de 500 watts', 120.00, 12, 1, 'https://example.com/extractor.jpg'),
('Cafetera eléctrica 12 tazas', 'Cafetera automática con capacidad para 12 tazas', 65.00, 15, 1, 'https://example.com/cafetera.jpg');
GO

-- Insertar productos para Viaje y Camping
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, IdCategoria, ImagenURL) VALUES
('Mochila trekking 50L impermeable', 'Mochila de trekking impermeable, capacidad 50 litros', 95.00, 18, 2, 'https://example.com/mochila.jpg'),
('Tienda de campaña 4 personas', 'Tienda de campaña para 4 personas, fácil armado', 180.00, 8, 2, 'https://example.com/tienda.jpg'),
('Saco de dormir -5°C comfort', 'Saco de dormir para temperaturas hasta -5°C', 89.90, 15, 2, 'https://example.com/saco.jpg'),
('Linterna frontal recargable', 'Linterna frontal LED recargable via USB', 35.00, 25, 2, 'https://example.com/linterna.jpg'),
('Colchón inflable automático', 'Colchón inflable con bomba automática integrada', 75.00, 12, 2, 'https://example.com/colchon.jpg'),
('Kit de cocina camping (ollas + hornillo)', 'Kit completo de cocina para camping', 110.00, 10, 2, 'https://example.com/kitcamping.jpg'),
('Cantimplora acero inoxidable 1L', 'Cantimplora de acero inoxidable, capacidad 1 litro', 28.50, 30, 2, 'https://example.com/cantimplora.jpg'),
('Silla plegable camping', 'Silla plegable para camping, fácil transporte', 45.00, 20, 2, 'https://example.com/silla.jpg'),
('Navaja multiusos profesional', 'Navaja multiusos con 12 funciones diferentes', 52.00, 25, 2, 'https://example.com/navaja.jpg'),
('Botiquín primeros auxilios viaje', 'Botiquín compacto para viajes y camping', 38.00, 15, 2, 'https://example.com/botiquin.jpg');
GO

-- Insertar productos para Limpieza y Cuidado del Hogar
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, IdCategoria, ImagenURL) VALUES
('Aspiradora inalámbrica 20V', 'Aspiradora inalámbrica de 20V, ligera y potente', 189.00, 10, 3, 'https://example.com/aspiradora.jpg'),
('Kit de limpieza premium 8 piezas', 'Kit completo de limpieza con 8 accesorios', 49.90, 22, 3, 'https://example.com/kitlimpieza.jpg'),
('Desinfectante multiusos 2L', 'Desinfectante multiusos, botella de 2 litros', 18.50, 40, 3, 'https://example.com/desinfectante.jpg'),
('Guantes de limpieza largos', 'Guantes de limpieza largos, material resistente', 12.90, 35, 3, 'https://example.com/guantes.jpg'),
('Escobillón giratorio 360°', 'Escobillón con cabeza giratoria 360 grados', 25.00, 28, 3, 'https://example.com/escobillon.jpg'),
('Trapos de microfibra (pack x10)', 'Pack de 10 trapos de microfibra para limpieza', 22.00, 50, 3, 'https://example.com/trapos.jpg'),
('Limpiador de vidrios 500ml', 'Limpiador especializado para vidrios y superficies', 15.00, 45, 3, 'https://example.com/limpiador.jpg'),
('Ambientador automático', 'Ambientador automático con sensor de movimiento', 32.00, 20, 3, 'https://example.com/ambientador.jpg'),
('Cubo de basura con pedal 30L', 'Cubo de basura con pedal, capacidad 30 litros', 45.00, 18, 3, 'https://example.com/cubobasura.jpg'),
('Organizador de productos limpieza', 'Organizador para productos de limpieza', 28.00, 25, 3, 'https://example.com/organizador.jpg');
GO

-- Insertar productos para Electrónica y Tecnología
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, IdCategoria, ImagenURL) VALUES
('Power bank 20000mAh rápido', 'Power bank de alta capacidad con carga rápida', 79.90, 20, 4, 'https://example.com/powerbank.jpg'),
('Audífonos inalámbricos noise canceling', 'Audífonos con cancelación de ruido y Bluetooth', 129.00, 15, 4, 'https://example.com/audifonos.jpg'),
('Cargador rápido 4 puertos USB', 'Cargador con 4 puertos USB para múltiples dispositivos', 45.00, 25, 4, 'https://example.com/cargador.jpg'),
('Mouse inalámbrico gaming', 'Mouse gaming inalámbrico con RGB', 65.00, 18, 4, 'https://example.com/mouse.jpg'),
('Teclado mecánico RGB', 'Teclado mecánico con iluminación RGB personalizable', 120.00, 12, 4, 'https://example.com/teclado.jpg'),
('Altavoz Bluetooth portátil', 'Altavoz portátil Bluetooth con sonido estéreo', 89.00, 20, 4, 'https://example.com/altavoz.jpg'),
('Tablet stand ajustable', 'Soporte ajustable para tablets y smartphones', 35.00, 30, 4, 'https://example.com/stand.jpg'),
('Hub USB-C 7 en 1', 'Hub USB-C con 7 puertos diferentes', 55.00, 22, 4, 'https://example.com/hub.jpg'),
('Smartwatch deportivo', 'Smartwatch con funciones deportivas y monitor cardiaco', 150.00, 15, 4, 'https://example.com/smartwatch.jpg'),
('Webcam 1080p', 'Cámara web Full HD 1080p para streaming', 95.00, 18, 4, 'https://example.com/webcam.jpg');
GO

-- Insertar productos para Deportes y Fitness
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, IdCategoria, ImagenURL) VALUES
('Mat de yoga premium', 'Mat de yoga antideslizante, material premium', 55.00, 20, 5, 'https://example.com/matyoga.jpg'),
('Mancuernas ajustables 10kg', 'Mancuernas ajustables hasta 10kg por pieza', 89.00, 12, 5, 'https://example.com/mancuernas.jpg'),
('Botella deportiva 1L térmica', 'Botella térmica para deportes, capacidad 1 litro', 22.90, 30, 5, 'https://example.com/botella.jpg'),
('Cuerda para saltar profesional', 'Cuerda para saltar profesional, ajustable', 18.00, 25, 5, 'https://example.com/cuerda.jpg'),
('Bandas de resistencia (set x5)', 'Set de 5 bandas de resistencia diferentes', 35.00, 28, 5, 'https://example.com/bandas.jpg'),
('Rodillo de masaje muscular', 'Rodillo para masaje muscular y recuperación', 28.00, 22, 5, 'https://example.com/rodillo.jpg'),
('Pesas para tobillos 2kg c/u', 'Pesas para tobillos, 2kg cada una', 45.00, 15, 5, 'https://example.com/pesas.jpg'),
('Balón de ejercicio 65cm', 'Balón de ejercicio para fitness, 65cm', 42.00, 20, 5, 'https://example.com/balon.jpg'),
('Step para ejercicios', 'Step profesional para ejercicios aeróbicos', 65.00, 18, 5, 'https://example.com/step.jpg'),
('Mochila deportiva', 'Mochila deportiva con compartimentos especiales', 75.00, 25, 5, 'https://example.com/mochiladeporte.jpg');
GO

-- Insertar productos para Oficina y Escolar
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, IdCategoria, ImagenURL) VALUES
('Set de útiles escolares completo', 'Set completo con todos los útiles escolares básicos', 35.00, 25, 6, 'https://example.com/utiles.jpg'),
('Mochila laptop 15.6" antirrobo', 'Mochila con compartimento antirrobo para laptop', 95.00, 10, 6, 'https://example.com/mochilaoficina.jpg'),
('Organizador de escritorio 5 piezas', 'Set organizador de escritorio con 5 piezas', 28.90, 20, 6, 'https://example.com/organizadoroficina.jpg'),
('Calculadora científica', 'Calculadora científica con 240 funciones', 45.00, 18, 6, 'https://example.com/calculadora.jpg'),
('Silla ergonómica oficina', 'Silla ergonómica para oficina, ajustable', 220.00, 8, 6, 'https://example.com/sillaoficina.jpg'),
('Escritorio portátil para laptop', 'Escritorio portátil para usar con laptop en cualquier lugar', 65.00, 15, 6, 'https://example.com/escritorio.jpg'),
('Kit de papelería ejecutivo', 'Kit de papelería ejecutivo con artículos premium', 42.00, 22, 6, 'https://example.com/papeleria.jpg'),
('Archivador de documentos', 'Archivador para documentos A4, capacidad 100 hojas', 38.00, 30, 6, 'https://example.com/archivador.jpg'),
('Pizarra magnética 60x90cm', 'Pizarra magnética blanca, tamaño 60x90cm', 85.00, 12, 6, 'https://example.com/pizarra.jpg'),
('Luz LED para escritorio', 'Luz LED ajustable para escritorio, USB', 32.00, 25, 6, 'https://example.com/luzled.jpg');
GO

-- Insertar productos para Jardinería
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, IdCategoria, ImagenURL) VALUES
('Kit de jardinería 8 piezas', 'Kit completo de jardinería con 8 herramientas', 55.00, 15, 7, 'https://example.com/kitjardin.jpg'),
('Macetero decorativo 30cm', 'Macetero decorativo para interior, 30cm diámetro', 35.00, 18, 7, 'https://example.com/macetero.jpg'),
('Tierra de hojas 10kg', 'Tierra de hojas enriquecida, bolsa 10kg', 18.00, 25, 7, 'https://example.com/tierra.jpg'),
('Manguera 15m extensible', 'Manguera extensible hasta 15 metros', 45.00, 20, 7, 'https://example.com/manguera.jpg'),
('Tijeras de podar profesionales', 'Tijeras de podar profesionales, acero inoxidable', 28.00, 15, 7, 'https://example.com/tijeras.jpg'),
('Regadera 5L plástico', 'Regadera de plástico resistente, capacidad 5L', 22.00, 30, 7, 'https://example.com/regadera.jpg'),
('Guantes de jardinería', 'Guantes resistentes para trabajos de jardinería', 15.00, 35, 7, 'https://example.com/guantesjardin.jpg'),
('Fertilizante universal 1kg', 'Fertilizante universal para plantas, 1kg', 25.00, 28, 7, 'https://example.com/fertilizante.jpg'),
('Rastrillo de mano', 'Rastrillo de mano para jardinería', 19.00, 22, 7, 'https://example.com/rastrillo.jpg'),
('Pulverizador 2L', 'Pulverizador para plantas, capacidad 2 litros', 32.00, 25, 7, 'https://example.com/pulverizador.jpg');
GO

-- Insertar productos para Cuidado Personal
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, IdCategoria, ImagenURL) VALUES
('Secador de cabello 2000W', 'Secador de cabello profesional 2000W', 65.00, 15, 8, 'https://example.com/secador.jpg'),
('Kit de afeitadora eléctrica recargable', 'Afeitadora eléctrica recargable con accesorios', 120.00, 8, 8, 'https://example.com/afeitadora.jpg'),
('Espejo cosmético con luz LED', 'Espejo cosmético con iluminación LED ajustable', 48.90, 12, 8, 'https://example.com/espejo.jpg'),
('Organizador de baño 3 niveles', 'Organizador de baño de 3 niveles, acero inoxidable', 38.00, 20, 8, 'https://example.com/organizadorbano.jpg'),
('Cortadora de cabello profesional', 'Cortadora de cabello profesional, múltiples accesorios', 85.00, 10, 8, 'https://example.com/cortadora.jpg'),
('Balanza digital baño', 'Balanza digital para baño, máxima precisión', 42.00, 18, 8, 'https://example.com/balanza.jpg'),
('Alisador de cabello cerámico', 'Alisador de cabello con placas de cerámica', 95.00, 12, 8, 'https://example.com/alisador.jpg'),
('Kit de cuidado facial', 'Kit completo para cuidado facial diario', 75.00, 15, 8, 'https://example.com/facial.jpg'),
('Cepillo dental eléctrico', 'Cepillo dental eléctrico recargable', 55.00, 20, 8, 'https://example.com/cepillo.jpg'),
('Reloj despertador digital', 'Reloj despertador digital con radio', 35.00, 25, 8, 'https://example.com/reloj.jpg');
GO

select P.Precio, P.Nombre, P.Img, C.Nombre as 'Categoria'
from Productos P
INNER JOIN Categorias C on P.IdCategoria = C.IdCategoria
GO