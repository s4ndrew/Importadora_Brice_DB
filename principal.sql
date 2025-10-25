
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
    Img varchar(200) default '',
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
('Juego de Ollas 5 piezas acero inoxidable', 'Set completo de ollas de acero inoxidable de primera calidad', 129.90, 12, 1, 'https://media.falabella.com/falabellaPE/142001182_01/w=1500,h=1500,fit=pad'),
('Sartén antiadherente 24cm Tefal', 'Sartén profesional con recubrimiento antiadherente duradero', 45.50, 18, 1, 'https://media.falabella.com/falabellaPE/126654526_01/w=1500,h=1500,fit=pad'),
('Set de tapers herméticos (6 piezas)', 'Contenedores herméticos para almacenar alimentos', 32.90, 25, 1, 'https://media.falabella.com/falabellaPE/883158602_01/w=1500,h=1500,fit=pad'),
('Juego de cubiertos 42 piezas acero', 'Elegante juego de cubiertos de acero inoxidable', 68.00, 10, 1, 'https://media.falabella.com/tottusPE/43064036_1/w=1500,h=1500,fit=pad'),
('Olla arrocera 2L digital', 'Olla arrocera digital con capacidad para 2 litros', 89.00, 15, 1, 'https://media.falabella.com/tottusPE/43542286_1/w=1500,h=1500,fit=pad'),
('Batidora de mano 5 velocidades', 'Batidora manual con 5 velocidades y accesorios', 55.90, 20, 1, 'https://media.falabella.com/falabellaPE/139240896_01/w=1500,h=1500,fit=pad'),
('Juego de vajilla 16 piezas', 'Vajilla completa para 4 personas, 16 piezas', 75.00, 8, 1, 'https://media.falabella.com/falabellaPE/882301039_1/w=1500,h=1500,fit=pad'),
('Tabla de picar bambú (pack x3)', 'Set de 3 tablas de picar de bambú ecológico', 25.00, 30, 1, 'https://media.falabella.com/falabellaPE/770628085_1/w=1500,h=1500,fit=pad'),
('Extractor de jugos 500W', 'Extractor de jugos profesional de 500 watts', 120.00, 12, 1, 'https://media.falabella.com/falabellaPE/880201394_005/w=1500,h=1500,fit=pad'),
('Cafetera eléctrica 12 tazas', 'Cafetera automática con capacidad para 12 tazas', 65.00, 15, 1, 'https://media.falabella.com/falabellaPE/143252685_01/w=1500,h=1500,fit=pad');
GO

-- Insertar productos para Viaje y Camping
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, IdCategoria, ImagenURL) VALUES
('Mochila trekking 50L impermeable', 'Mochila de trekking impermeable, capacidad 50 litros', 95.00, 18, 2, 'https://media.falabella.com/falabellaPE/129458761_01/w=1500,h=1500,fit=pad'),
('Tienda de campaña 4 personas', 'Tienda de campaña para 4 personas, fácil armado', 180.00, 8, 2, 'https://media.falabella.com/sodimacPE/1679805_01/w=1500,h=1500,fit=pad'),
('Saco de dormir -5°C comfort', 'Saco de dormir para temperaturas hasta -5°C', 89.90, 15, 2, 'https://media.falabella.com/falabellaPE/16048643_1/w=1500,h=1500,fit=pad'),
('Linterna frontal recargable', 'Linterna frontal LED recargable via USB', 35.00, 25, 2, 'https://media.falabella.com/falabellaPE/140769448_01/w=1500,h=1500,fit=pad'),
('Colchón inflable automático', 'Colchón inflable con bomba automática integrada', 75.00, 12, 2, 'https://media.falabella.com/falabellaPE/126187768_06/w=1500,h=1500,fit=pad'),
('Kit de cocina camping (ollas + hornillo)', 'Kit completo de cocina para camping', 110.00, 10, 2, 'https://media.falabella.com/falabellaPE/130154031_02/w=1500,h=1500,fit=pad'),
('Cantimplora acero inoxidable 1L', 'Cantimplora de acero inoxidable, capacidad 1 litro', 28.50, 30, 2, 'https://media.falabella.com/falabellaPE/130705370_01/w=1500,h=1500,fit=pad'),
('Silla plegable camping', 'Silla plegable para camping, fácil transporte', 45.00, 20, 2, 'https://media.falabella.com/tottusPE/41733660_4/w=1500,h=1500,fit=pad'),
('Navaja multiusos profesional', 'Navaja multiusos con 12 funciones diferentes', 52.00, 25, 2, 'https://media.falabella.com/falabellaPE/132523350_01/w=1500,h=1500,fit=pad'),
('Botiquín primeros auxilios viaje', 'Botiquín compacto para viajes y camping', 38.00, 15, 2, 'https://media.falabella.com/falabellaPE/123184226_01/w=1500,h=1500,fit=pad');
GO

-- Insertar productos para Limpieza y Cuidado del Hogar
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, IdCategoria, ImagenURL) VALUES
('Aspiradora inalámbrica 20V', 'Aspiradora inalámbrica de 20V, ligera y potente', 189.00, 10, 3, 'https://media.falabella.com/falabellaPE/140644436_01/w=1500,h=1500,fit=pad'),
('Kit de limpieza premium 8 piezas', 'Kit completo de limpieza con 8 accesorios', 49.90, 22, 3, 'https://media.falabella.com/falabellaPE/126610732_01/w=1500,h=1500,fit=pad'),
('Desinfectante multiusos 2L', 'Desinfectante multiusos, botella de 2 litros', 18.50, 40, 3, 'https://media.falabella.com/sodimacPE/2083663_01/w=1500,h=1500,fit=pad'),
('Guantes de limpieza largos', 'Guantes de limpieza largos, material resistente', 12.90, 35, 3, 'https://www.falabella.com.pe/falabella-pe/product/147110768/Guante-de-latex-para-limpieza-uso-domestico-amarillo-talla-mediana/147110769'),
('Escobillón giratorio 360°', 'Escobillón con cabeza giratoria 360 grados', 25.00, 28, 3, 'https://media.falabella.com/falabellaPE/140980089_01/w=1500,h=1500,fit=pad'),
('Trapos de microfibra (pack x10)', 'Pack de 10 trapos de microfibra para limpieza', 22.00, 50, 3, 'https://media.falabella.com/sodimacPE/3719383_00/w=800,h=800,fit=pad'),
('Limpiador de vidrios 500ml', 'Limpiador especializado para vidrios y superficies', 15.00, 45, 3, 'https://media.falabella.com/falabellaPE/118973154_01/w=1500,h=1500,fit=pad'),
('Ambientador automático', 'Ambientador automático con sensor de movimiento', 32.00, 20, 3, 'https://media.falabella.com/falabellaPE/116001599_01/w=1500,h=1500,fit=pad'),
('Cubo de basura con pedal 30L', 'Cubo de basura con pedal, capacidad 30 litros', 45.00, 18, 3, 'https://media.falabella.com/falabellaPE/140392789_01/w=1500,h=1500,fit=pad'),
('Organizador de productos limpieza', 'Organizador para productos de limpieza', 28.00, 25, 3, 'https://http2.mlstatic.com/D_NQ_NP_2X_605105-MLU70326870686_072023-F.webp');
GO

-- Insertar productos para Electrónica y Tecnología
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, IdCategoria, ImagenURL) VALUES
('Power bank 20000mAh rápido', 'Power bank de alta capacidad con carga rápida', 79.90, 20, 4, 'https://media.falabella.com/falabellaPE/148361372_01/w=1500,h=1500,fit=pad'),
('Audífonos inalámbricos noise canceling', 'Audífonos con cancelación de ruido y Bluetooth', 129.00, 15, 4, 'https://media.falabella.com/falabellaPE/19818035_01/w=1500,h=1500,fit=pad'),
('Cargador rápido 4 puertos USB', 'Cargador con 4 puertos USB para múltiples dispositivos', 45.00, 25, 4, 'https://media.falabella.com/falabellaPE/116374477_01/w=1500,h=1500,fit=pad'),
('Mouse inalámbrico gaming', 'Mouse gaming inalámbrico con RGB', 65.00, 18, 4, 'https://media.falabella.com/falabellaPE/120544237_01/w=1500,h=1500,fit=pad'),
('Teclado mecánico RGB', 'Teclado mecánico con iluminación RGB personalizable', 120.00, 12, 4, 'https://media.falabella.com/falabellaPE/142547175_01/w=1500,h=1500,fit=pad'),
('Altavoz Bluetooth portátil', 'Altavoz portátil Bluetooth con sonido estéreo', 89.00, 20, 4, 'https://media.falabella.com/falabellaPE/118529486_01/w=1500,h=1500,fit=pad'),
('Tablet stand ajustable', 'Soporte ajustable para tablets y smartphones', 35.00, 30, 4, 'https://media.falabella.com/falabellaPE/128906342_01/w=1500,h=1500,fit=pad'),
('Hub USB-C 7 en 1', 'Hub USB-C con 7 puertos diferentes', 55.00, 22, 4, 'https://media.falabella.com/falabellaPE/142842769_01/w=1500,h=1500,fit=pad'),
('Smartwatch deportivo', 'Smartwatch con funciones deportivas y monitor cardiaco', 150.00, 15, 4, 'https://media.falabella.com/falabellaPE/146608360_01/w=1500,h=1500,fit=pad'),
('Webcam 1080p', 'Cámara web Full HD 1080p para streaming', 95.00, 18, 4, 'https://media.falabella.com/falabellaPE/115261383_01/w=1500,h=1500,fit=pad');
GO

-- Insertar productos para Deportes y Fitness
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, IdCategoria, ImagenURL) VALUES
('Mat de yoga premium', 'Mat de yoga antideslizante, material premium', 55.00, 20, 5, 'https://media.falabella.com/falabellaPE/142683692_01/w=1500,h=1500,fit=pad'),
('Mancuernas ajustables 10kg', 'Mancuernas ajustables hasta 10kg por pieza', 89.00, 12, 5, 'https://media.falabella.com/falabellaPE/139613084_01/w=1500,h=1500,fit=pad'),
('Botella deportiva 1L térmica', 'Botella térmica para deportes, capacidad 1 litro', 22.90, 30, 5, 'https://media.falabella.com/falabellaPE/148092573_01/w=1500,h=1500,fit=pad'),
('Cuerda para saltar profesional', 'Cuerda para saltar profesional, ajustable', 18.00, 25, 5, 'https://media.falabella.com/tottusPE/42207094_1/w=1500,h=1500,fit=pad'),
('Bandas de resistencia (set x5)', 'Set de 5 bandas de resistencia diferentes', 35.00, 28, 5, 'https://media.falabella.com/falabellaPE/140764890_01/w=1500,h=1500,fit=pad'),
('Rodillo de masaje muscular', 'Rodillo para masaje muscular y recuperación', 28.00, 22, 5, 'https://www.jmsportperu.com/wp-content/uploads/2022/05/masajeador-lead.jpg'),
('Pesas para tobillos 2kg c/u', 'Pesas para tobillos, 2kg cada una', 45.00, 15, 5, 'https://plazavea.vteximg.com.br/arquivos/ids/1602998-1000-1000/WhatsApp-Image-2021-05-13-at-1.34.59-PM--1-.jpg?v=637565317665100000'),
('Balón de ejercicio 65cm', 'Balón de ejercicio para fitness, 65cm', 42.00, 20, 5, 'https://media.falabella.com/falabellaPE/137825366_01/w=1500,h=1500,fit=pad'),
('Step para ejercicios', 'Step profesional para ejercicios aeróbicos', 65.00, 18, 5, 'https://plazavea.vteximg.com.br/arquivos/ids/25878499-1000-1000/image-affc9ba7aa874ca2aab7c759606f4f13.jpg'),
('Mochila deportiva', 'Mochila deportiva con compartimentos especiales', 75.00, 25, 5, 'https://media.falabella.com/falabellaPE/882586355_1/w=1500,h=1500,fit=pad');
GO

-- Insertar productos para Oficina y Escolar
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, IdCategoria, ImagenURL) VALUES
('Set de útiles escolares completo', 'Set completo con todos los útiles escolares básicos', 35.00, 25, 6, 'https://zetagas.com.pe/wp-content/uploads/2021/03/110965-1.jpg'),
('Mochila laptop 15.6" antirrobo', 'Mochila con compartimento antirrobo para laptop', 95.00, 10, 6, 'https://media.falabella.com/falabellaPE/121190927_01/w=1500,h=1500,fit=pad'),
('Organizador de escritorio 5 piezas', 'Set organizador de escritorio con 5 piezas', 28.90, 20, 6, 'https://media.falabella.com/falabellaPE/144397704_01/w=800,h=800,fit=pad'),
('Calculadora científica', 'Calculadora científica con 240 funciones', 45.00, 18, 6, 'https://home.ripley.com.pe/Attachment/WOP/2065135877741/2065135877741-1.jpg'),
('Silla ergonómica oficina', 'Silla ergonómica para oficina, ajustable', 220.00, 8, 6, 'https://i.cadi.pe/wp-content/uploads/2025/05/21153918/si-es-nueva-10.jpg'),
('Escritorio portátil para laptop', 'Escritorio portátil para usar con laptop en cualquier lugar', 65.00, 15, 6, 'https://media.falabella.com/falabellaPE/116332513_01/w=1500,h=1500,fit=pad'),
('Kit de papelería ejecutivo', 'Kit de papelería ejecutivo con artículos premium', 42.00, 22, 6, 'https://http2.mlstatic.com/D_NQ_NP_2X_786474-MLA93989515237_102025-F.webp'),
('Archivador de documentos', 'Archivador para documentos A4, capacidad 100 hojas', 38.00, 30, 6, 'https://http2.mlstatic.com/D_NQ_NP_2X_941400-MPE74313234307_012024-F-porta-documentos-magnetico-de-5-niveles-archivadores-.webp'),
('Pizarra magnética 60x90cm', 'Pizarra magnética blanca, tamaño 60x90cm', 85.00, 12, 6, 'https://http2.mlstatic.com/D_NQ_NP_2X_823163-MPE73931332553_012024-F-pizarra-blanca-magnetica-bandeja-y-marco-de-aluminio-.webp'),
('Luz LED para escritorio', 'Luz LED ajustable para escritorio, USB', 32.00, 25, 6, 'https://coolboxpe.vtexassets.com/arquivos/ids/414844-1200-1200?v=638733393186500000&width=1200&height=1200&aspect=true');
GO

-- Insertar productos para Jardinería
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, IdCategoria, ImagenURL) VALUES
('Kit de jardinería 8 piezas', 'Kit completo de jardinería con 8 herramientas', 55.00, 15, 7, 'https://http2.mlstatic.com/D_NQ_NP_2X_983253-MLU72864255043_112023-F.webp'),
('Macetero decorativo 30cm', 'Macetero decorativo para interior, 30cm diámetro', 35.00, 18, 7, 'https://cdnx.jumpseller.com/kautiva1/image/36688637/resize/640/640?1687455383'),
('Tierra de hojas 10kg', 'Tierra de hojas enriquecida, bolsa 10kg', 18.00, 25, 7, 'https://www.armony.cl/wp-content/uploads/2020/09/FICHA-TIERRA-DE-HOJAS.jpg'),
('Manguera 15m extensible', 'Manguera extensible hasta 15 metros', 45.00, 20, 7, 'https://http2.mlstatic.com/D_NQ_NP_2X_713611-MLA79408890379_092024-F.webp'),
('Tijeras de podar profesionales', 'Tijeras de podar profesionales, acero inoxidable', 28.00, 15, 7, 'https://cahema.pe/35262-large_default/tijera-de-podar-manual-25mm-p110-23-f-bahco.webp'),
('Regadera 5L plástico', 'Regadera de plástico resistente, capacidad 5L', 22.00, 30, 7, 'https://http2.mlstatic.com/D_NQ_NP_2X_864766-MLA80097133748_102024-F.webp'),
('Guantes de jardinería', 'Guantes resistentes para trabajos de jardinería', 15.00, 35, 7, 'https://m.media-amazon.com/images/I/71ZojcCl2ZL._AC_SX569_.jpg'),
('Fertilizante universal 1kg', 'Fertilizante universal para plantas, 1kg', 25.00, 28, 7, 'https://promart.vteximg.com.br/arquivos/ids/7430540-1000-1000/12766.jpg?v=638277401533570000'),
('Rastrillo de mano', 'Rastrillo de mano para jardinería', 19.00, 22, 7, 'https://m.media-amazon.com/images/I/51v1sDWKflL._AC_SL1500_.jpg'),
('Pulverizador 2L', 'Pulverizador para plantas, capacidad 2 litros', 32.00, 25, 7, 'https://www.agrobesser.com/10879-large_default/fumigador-manual-2l-bomba-piston-25-bar-solo-402.jpg');
GO

-- Insertar productos para Cuidado Personal
INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, IdCategoria, ImagenURL) VALUES
('Secador de cabello 2000W', 'Secador de cabello profesional 2000W', 65.00, 15, 8, 'https://media.falabella.com/falabellaPE/133754308_01/w=1500,h=1500,fit=pad'),
('Kit de afeitadora eléctrica recargable', 'Afeitadora eléctrica recargable con accesorios', 120.00, 8, 8, 'https://http2.mlstatic.com/D_NQ_NP_2X_886988-MLU78535608530_082024-F.webp'),
('Espejo cosmético con luz LED', 'Espejo cosmético con iluminación LED ajustable', 48.90, 12, 8, 'https://m.media-amazon.com/images/I/6126SBNVhdL._AC_SX679_.jpg'),
('Organizador de baño 3 niveles', 'Organizador de baño de 3 niveles, acero inoxidable', 38.00, 20, 8, 'https://www.enkasa.pe/cdn/shop/files/imagenes_de_deslizador_1_0f124df5-75b3-4db9-baa9-9fa547f4e05b.png?v=1751152489&width=823'),
('Cortadora de cabello profesional', 'Cortadora de cabello profesional, múltiples accesorios', 85.00, 10, 8, 'https://www.cosmeticaval.cl/wp-content/uploads/2023/04/CVL13404542202-600x600.jpg'),
('Balanza digital baño', 'Balanza digital para baño, máxima precisión', 42.00, 18, 8, 'https://www.electrogarline.com/6309-medium_default/balanza-digital-bano-de-vidrio-templado-180kg-henkel-vid3yk.webp'),
('Alisador de cabello cerámico', 'Alisador de cabello con placas de cerámica', 95.00, 12, 8, 'https://www.inche.com.pe/wp-content/uploads/2021/06/HS2198inche.jpg'),
('Kit de cuidado facial', 'Kit completo para cuidado facial diario', 75.00, 15, 8, 'https://plazavea.vteximg.com.br/arquivos/ids/28410922-465-465/imageUrl_1.jpg'),
('Cepillo dental eléctrico', 'Cepillo dental eléctrico recargable', 55.00, 20, 8, 'https://wongfood.vtexassets.com/arquivos/ids/779162-1200-auto?v=638883061595070000&width=1200&height=auto&aspect=true'),
('Reloj despertador digital', 'Reloj despertador digital con radio', 35.00, 25, 8, 'https://http2.mlstatic.com/D_NQ_NP_2X_689766-MPE75179640398_032024-F-reloj-despertador-digital-bateria-dormitorio-reloj-de.webp');
GO

select P.Precio, P.Nombre, P.Img, C.Nombre as 'Categoria'
from Productos P
INNER JOIN Categorias C on P.IdCategoria = C.IdCategoria
GO

UPDATE Productos
SET Img = ImagenURL
WHERE ImagenURL IS NOT NULL AND ImagenURL <> '';
GO

---VALIDACION DE LINKS
SELECT P.Precio, P.Nombre, P.Img, C.Nombre as 'Categoria'
FROM Productos P
INNER JOIN Categorias C ON P.IdCategoria = C.IdCategoria;
GO

