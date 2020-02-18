-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-02-2020 a las 09:31:59
-- Versión del servidor: 10.4.6-MariaDB
-- Versión de PHP: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `supermercado`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `annadir_registro_historico` (IN `categoria` INT(10), IN `t_busqueda` VARCHAR(100))  NO SQL
Begin
	 DECLARE yaexiste INT DEFAULT 0;
     DECLARE idanterior INT DEFAULT 0;
     SELECT Count(id_historico_de_busquedas) into yaexiste  FROM historico_de_busquedas where id_categoria = categoria AND busqueda = t_busqueda;
     SELECT id_historico_de_busquedas into idanterior  FROM historico_de_busquedas where id_categoria = categoria AND busqueda = t_busqueda;
     if yaexiste = 1 THEN
    	UPDATE historico_de_busquedas SET numbusquedas = numbusquedas + 1 where id_historico_de_busquedas = idanterior;
     ELSE
        INSERT INTO historico_de_busquedas (id_categoria,busqueda,numbusquedas) VALUES (categoria, t_busqueda, 1);
     END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias_productos`
--

CREATE TABLE `categorias_productos` (
  `id_categoria` int(11) NOT NULL,
  `nombre_categoria` varchar(45) DEFAULT NULL,
  `imagen_categoria` varchar(50) NOT NULL,
  `descripcion_categoria` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `categorias_productos`
--

INSERT INTO `categorias_productos` (`id_categoria`, `nombre_categoria`, `imagen_categoria`, `descripcion_categoria`) VALUES
(1, 'Frutas y Verduras Frescas', '1.jpg', 'Frutas y Verduras Frescas'),
(2, 'Carnes y Pescados', '2.jpg', 'Carnes y Pescados'),
(3, 'Lacteos y Huevos', '3.jpg', 'Lacteos y Huevos'),
(4, 'Aperitivos', '4.jpg', ''),
(5, 'Desayuno, dulces y pan', '5.jpg', ''),
(6, 'Congelados', '6.jpg', ''),
(7, 'Despensa', '7.jpg', ''),
(8, 'Platos preparados', '8.jpg', ''),
(9, 'Bebidas', '9.jpg', ''),
(10, 'Cuidado y Limpieza del Hogar', '10.jpg', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre_producto` varchar(80) DEFAULT NULL,
  `descripcion` varchar(1000) DEFAULT NULL,
  `foto` varchar(100) NOT NULL,
  `coste` float(4,2) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `categorias_productos_id_categoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre_producto`, `descripcion`, `foto`, `coste`, `stock`, `categorias_productos_id_categoria`) VALUES
(1, 'Zanahoria Bio - 700 g (BIO)', 'Bandeja de zanahoria de agricultura ecológica. Producto de agricultura ecológica. Apto para todos los consumidores', 'zanahoria.jpg', 1.69, 50, 1),
(2, 'Plátano de canarias Bio - 800 gr (BIO)', 'Plátano de canarias Bio - 800 gr. Producto fresco y envasado.', 'platano.jpg', 2.77, 50, 1),
(3, 'Patata Bio - 2 Kg (BIO)', 'Patata Bio - 2 Kg. Producto fresco y envasado.', 'patata.jpg', 3.99, 50, 1),
(4, 'Tomate ensalada Bio - 600 gr (BIO)', 'La agricultura de productos ecológicos se basa por su uso en materiales orgánicos, naturales y reciclados, dejando a un lado pesticidas, abonos químicos y otras toxicidades. El tomate posee grandes propiedades antioxidantes naturales. Baja en sodio, por lo que, es muy recomendada en hipertensos. Ayuda a hacer bien la digestión', 'tomate.jpg', 3.85, 50, 1),
(5, 'Calabacín Bio - 600 g (BIO)', 'Caja de ajo negro de agricultura ecológica. Producto de agricultura ecológica. Apto para todos los consumidores', 'calabacin.jpg', 2.70, 50, 1),
(6, 'Manzana Royal Gala Bio - 600 gr (BIO)', 'La agricultura de productos ecológicos se basa por su uso en materiales orgánicos, naturales y reciclados, dejando a un lado pesticidas, abonos químicos y otras toxicidades. Las manzanas están especialmente recomendadas en dietas de prevención de riesgo cardiovascular, enfermedades degenerativas y cáncer. Sus propiedades antioxidantes le otorgan valores anticancerígenos. Consumida cruda y con piel es útil para tratar el estreñimiento. Consumida pelada, rallada y oscurecida tiene un efecto astringente en nuestro organismo. Favorece la eliminación de líquidos corporales', 'manzana.jpg', 3.45, 50, 1),
(7, 'Limón Bio - 500 gr (BIO)', 'Bandeja de limon agricultura ecológica. Producto de agricultura ecológica. Apto para todos los consumidores', 'limon.jpg', 1.69, 50, 1),
(8, 'Seta shiitake Bio - 200 gr (BIO)', 'Seta shiitake Bio - 200 gr. Producto fresco y envasado.', 'seta.jpg', 3.41, 50, 1),
(9, 'Tomate rama Bio - 600 gr (BIO)', 'Bandeja mixta de fruta de agricultura ecológica. Producto de agricultura ecológica. Apto para todos los consumidores', 'tomaterama.jpg', 3.18, 50, 1),
(10, 'Ajo Bio - 250 gr (BIO)', 'Ajo Bio - 250 gr. Producto fresco y envasado', 'ajo.jpg', 2.23, 50, 1),
(11, 'Jengibre Bio - 300 gr (BIO)', 'Jengibre Bio - 300 gr. Producto fresco y envasado.', 'jengibre.jpg', 3.58, 50, 1),
(12, 'Agroorigen Bio, Preparado de Puré Ecológico, 1 Kg', 'Preparado puré Bio - 1 Kg. Producto fresco y envasado', 'preparado.jpg', 3.26, 50, 1),
(13, 'Aguacate Hass Bio - 400 g', 'Bandeja de aguacate de agricultura ecológica. Producto de agricultura ecológica. Apto para todos los consumidores', 'aguacate.jpg', 4.93, 50, 1),
(14, 'Puerro Bio - 600 gr (BIO)', 'Puerro Bio - 600 gr. Producto fresco y envasado.', 'puerro.jpg', 3.99, 50, 1),
(15, 'Champiñón blanco Bio - 300 gr', 'Champiñón blanco Bio - 300 gr. Producto fresco y envasado.', 'champi.jpg', 3.85, 50, 1),
(16, 'Kiwi Verde Zespri Bio - 600 g (BIO)', 'Bandeja de kiwi agricultura ecológica. Producto de agricultura ecológica. Apto para todos los consumidores', 'kiwi.jpg', 3.72, 50, 1),
(17, 'Calabaza Troceada Bio - 400 gr', 'Calabaza Pelada', 'calabaza.jpg', 6.42, 50, 1),
(18, 'Pimiento Rojo Ecológico - 600 gr (BIO)', 'Pimiento rojo de producción ecológica. Variedad California. Origen España. Bandeja de peso aproximado de 400 gramos.', 'pimientorojo.jpg', 3.24, 50, 1),
(19, 'Tomate cherry Bio - 250 gr (BIO)', 'Tomate cherry Bio - 250 gr. Producto fresco y envasado.', 'tcherry.jpg', 2.16, 50, 1),
(20, 'Naranja Bio - 2 Kg (BIO)', 'Naranja Bio', 'naranjabio.jpg', 3.72, 50, 1),
(21, 'Pepino Bio - 600 gr (BIO)', 'Pepino Bio - 600 gr. Producto fresco y envasado.', 'pepinobio.jpg', 2.64, 50, 1),
(22, 'Berenjena Ecológica - 600 gr (BIO)', 'Berenjena de producción ecológica. Origen España. Bandeja de peso aproximado 600 gramos. Categoría I. Pulpa verde o blanquecina y de sabor jugoso.', 'berenjenabio.jpg', 2.50, 50, 1),
(23, 'Felixia, Coco fresco bio - 900 gr. (BIO)', 'Coco fresco orgánico con pajita incorporada. Sabor ligeramente dulce. Agua transparente y carne blanca de sabor agradable. Peso aproximado por unidad 900 gramos', 'coco.jpg', 2.54, 50, 1),
(24, 'Manzana Golden Bio - 600 g (BIO)', 'Bandeja de Manzana Golden Bio de agricultura ecológica. Producto de agricultura ecológica. Apto para todos los consumidores', 'manzanabio.jpg', 2.91, 50, 1),
(25, 'Pimiento verde Bio - 600 gr (BIO)', 'Pimiento verde de producción ecológica. Variedad California. Origen España. Bandeja de peso aproximado de 400 gramos.', 'pvverde.jpg', 3.18, 50, 1),
(26, 'Nuez Bio - 400 gr (BIO)', 'La nuez es el fruto del nogal, de forma redondeada u ovoide, con una cáscara dura y rugosa de color pardo rojiza. La parte comestible de su interior tiene un sabor dulce particular.', 'nuezbio.jpg', 2.70, 50, 1),
(27, 'Ajo Negro Bio - 70 g (BIO)', 'Bandeja de calabacín de agricultura ecológica. Producto de agricultura ecológica. Apto para todos los consumidores', 'ajonegro.jpg', 5.21, 50, 1),
(28, 'Cebolla buti 1 Kg', 'Cebolla Buti, categoría I', 'cebollabuti.jpg', 1.30, 50, 1),
(29, 'Fresón tarrina 500 gr', 'Fresón, categoría I', 'freson.jpg', 1.99, 50, 1),
(30, 'Mandarina malla - 1 Kg', 'Mandarina malla', 'mandarina.jpg', 1.83, 50, 1),
(31, 'Brócoli pieza 500 gr', 'Brócoli, categoría I', 'brocoli.jpg', 3.28, 50, 1),
(32, 'Uva blanca sin semilla bandeja 500 gr', 'Uva blanca sin semilla, categoría I', 'uvablanca.jpg', 2.49, 50, 1),
(33, 'Uva roja racimo (920 gr aprox.)', 'Uva roja racimo', 'uvaroja.jpg', 2.99, 50, 1),
(34, 'Pera conferencia cesta 1 Kg', 'Pera, categoría I', 'pera.jpg', 1.35, 50, 1),
(35, 'Frambuesas tarrina 125 gr', 'Frambuesas tarrina, categoría I', 'frambuesa.jpg', 1.65, 50, 1),
(36, 'Arándano Tarrina - 125 gr', 'Frutos rojos: Arándano envasado en tarrina 125 gr. Frutos rojos. Antioxidantes naturales. España/Portugal/Perú/Chile', 'arandanos.jpg', 1.75, 50, 1),
(37, 'Mango unidad (600 gr aprox.)', 'Mango fresco importado', 'mango.jpg', 1.71, 50, 1),
(38, 'Judía Verde - 500 g', 'Judía Verde - 500 g', 'judia.jpg', 2.68, 50, 1),
(39, 'Coliflor pieza 1 ud', 'Coliflor, categoría I', 'coliflor.jpg', 1.89, 50, 1),
(40, 'Corazones de cogollos 6 uds', 'Corazones de cogollos, categoría I', 'cogollos.jpg', 1.79, 50, 1),
(41, 'Espárrago Triguero - 250 g', 'Espárrago Triguero - 250 g', 'esparrago.jpg', 2.65, 50, 1),
(42, 'Boniato unidad (600 gr aprox.)', 'Boniato', 'boniato.jpg', 1.13, 50, 1),
(43, 'FUENTES cebolla dulce unidad (600 gr aprox.)', 'Cebolla Dulce', 'cebolladulce.jpg', 1.19, 50, 1),
(44, 'Cebolleta - 560 gr', 'Manojo de cebolleta en bandeja. Peso aproximado 560 gramos. Origen España. Carne blanca, jugosa y de sabor más suave que la cebolla convencional.', 'cebolleta.jpg', 1.72, 50, 1),
(45, 'Perejil manojo 50 gr', 'Perejil', 'perejil.jpg', 0.69, 50, 1),
(46, 'Batata - 600 gr.', 'Boniato (bandeja 600 gr). Bandeja de verdura fresca. European Citrus Partners. Mantener en lugar fresco y seco.', 'batata.jpg', 2.23, 50, 1),
(47, 'Mora Tarrina - 125 gr', 'Frutos rojos: Mora fresca envasada en tarrina de 125 gramos. Antioxidante natural. Rica en vitamina C, antocianinas y carotenoides', 'mora.jpg', 2.15, 50, 1),
(48, 'Maíz cocido mazorcas bolsa 400 gr', 'Maíz cocido mazorcas, categoría I', 'maiz.jpg', 5.85, 50, 1),
(49, 'Melón Sapo Mitades - 1.4 kg', 'Melón Sapo Mitades - 1.4 kg', 'melon.jpg', 2.36, 50, 1),
(50, 'Pomelo unidad (300 gr aprox.)', 'Pomelo importado de Francia', 'pomelo.jpg', 0.57, 50, 1),
(51, 'Coren - Pechuga Fileteada Pollo Corral Bandeja, 450 gramos', 'Pechuga Fileteada Pollo Corral', 'pechugacorral.jpg', 5.29, 50, 2),
(52, 'Elpozo Picada de Vacuno - 500 gr', 'Preparado de carne picada de vacuno. Carne procedente de nuestras granjas. Producción controlada. Sin gluten', 'picadavacuno.jpg', 2.75, 50, 2),
(53, 'Hamburguesa Ternera Gallega - 240 gramos', 'Hamburguesas de ternera gallega', 'hamburguesaterneragallega.jpg', 3.05, 50, 2),
(54, 'Elpozo Escalopin de Lomo Adobado Extratierno - 600 gr', 'Filetes finos de lomo de cerdo adobado. Carne procedente de nuestras granjas. Producción controlada. Sin gluten', 'escalopinlomoadobado.jpg', 5.33, 50, 2),
(55, 'Coren - Fileteada de Pavo Bandeja, 450 gramos', 'Pechuga Fileteada de pavo en bandeja termosellada en atmósfera protectora.', 'fileteadadepavo.jpg', 3.78, 50, 2),
(56, 'Filetes de Ternera 1ªA - 500 g', '4 filetes de 125 gr aproximadamente de tiernos filetes de ternera, de cadera, babilla o tapa, ideales para hacer a la plancha. Elaborado en España por Grupo Embajadores 105330/M. Nacido en España. Cebado en España. Sacrificado en España.', 'filete1ra.jpg', 6.79, 50, 2),
(57, 'Coren - Solomillos Pollo Corral Bandeja, 350 gramos', 'Solomillos de Pollo de Corral en bandeja termosellada en atmósfera protectora.', 'solomillopollo.jpg', 4.11, 50, 2),
(58, 'Ragout de Ternera - 500 g', '500 gr aproximadamente, ideal para guisos. Elaborado en España por Grupo Embajadores 105330/M. Nacido en España. Cebado en España. Sacrificado en España.', 'ragaoutternera.jpg', 4.26, 50, 2),
(59, 'Cinta de Lomo Fresca - 500 g', 'Bandeja de 500 gr con aproximadamente 10 filetes, ideales para la plancha o para empanar. Elaborado en España por Grupo Embajadores 105330/M. Nacido en España. Cebado en España. Sacrificado en España.', 'cintalomo.jpg', 3.72, 50, 2),
(60, 'Elpozo Longaniza Blanca - 325 gr', 'Longaniza sin tripa especial barbacoa. Carne procedente de nuestras granjas. Producción controlada. Sin gluten', 'longaniza .jpg', 1.99, 50, 2),
(61, 'Coren - Pechuga de Pollo Bandeja, 805 gramos', 'Pechuga de pollo en bandeja termosellada en atmósfera protectora.', 'pechugadepollo.jpg', 5.57, 50, 2),
(62, 'Coren - Muslos Pollo Corral Bandeja, 520 gramos', 'Dos Muslos de Pollo de Corral en bandeja termosellada en atmósfera protectora.', 'muslosdepollo.jpg', 3.60, 50, 2),
(63, 'Solomillo de Cerdo - 700 g', '2 solomillos de 350 gr aproximadamente. Elaborado en España por Grupo Embajadores 105330/M. Nacido en España. Cebado en España. Sacrificado en España.', 'solomillo .jpg', 7.91, 50, 2),
(64, 'Coren - Salchicha de Pollo de Corral, 250 gr', 'Salchicha de Pollo de Corral, 250 gr', 'salchichapollo.jpg', 3.51, 50, 2),
(65, 'Coren - Hamburguesa pollo corral con espinacas 250 gr', 'Preparado de carne elaborado a base de carne picada de pollo corral, especias y aditivos autorizados.', 'hamburguesespinaca.jpg', 2.85, 50, 2),
(66, 'Elpozo Solomillo de Pollo Empanado Extratierno - 415 gr', 'Solomillo de pollo empanado sin gluten ideal niños. Carne procedente de nuestras granjas. Producción controlada. Sin gluten', 'solomillopolloempanado.jpg', 3.78, 50, 2),
(67, 'Coren - Pinchos de Pollo Adobado, 400 gr', 'Pinchos de Pollo Adobado', 'pinchosdepolloadobado.jpg', 3.37, 50, 2),
(68, 'Elpozo Pechuga de Pavo Adobada Bienstar - 330 gr', 'Pechuga de pavo baja en grasa bienstar. Carne procedente de nuestras granjas. Producción controlada. Sin gluten', 'pechugadepavo.jpg', 3.15, 50, 2),
(69, 'Coren - Jamones de Pollo Bandeja, 645 gramos', 'Jamoncitos de pollo en bandeja termosellada en atmósfera protectora.', 'jamoncitosdepollo.jpg', 3.02, 50, 2),
(70, 'Coren - Alas de Pollo Bandeja, 635 gramos', 'Alas de pollo en bandeja termosellada en atmósfera protectora.', 'alitas.jpg', 3.02, 50, 2),
(71, 'Chuletas de Aguja de Cerdo - 495 g', '3 chuletas de 165 gr aproximadamente, la parte más jugosa del cerdo. Elaborado en España por Grupo Embajadores 105330/M. Nacido en España. Cebado en España. Sacrificado en España.', 'chuletas.jpg', 2.65, 50, 2),
(72, 'Elpozo Burger de Cerdo Ibérico - 320 gr', 'Burger meat cerdo ibérico. Carne procedente de nuestras granjas. Producción controlada. Sin gluten. Sin lactosa.', 'burgerdecerdo.jpg', 2.69, 50, 2),
(73, 'Entrecot de Ternera - 500 g', '2 piezas de 250 gr aproximadamente de lomo bajo de ternera rosada. Elaborado en España por Grupo Embajadores 105330/M. Nacido en España. Cebado en España. Sacrificado en España.', 'entrecot.jpg', 9.16, 50, 2),
(74, 'Coren - Contramuslo de Pollo Bandeja, 575 gramos', 'Contramuslos de pollo en bandeja termosellada en atmósfera protectora.', 'contramuslo.jpg', 2.68, 50, 2),
(75, 'Noel Pollo Asado - 950 gr', 'La paciencia empleada en alcanzar el punto óptimo de cocción, hace posible que el pollo asado de la Gama Asados sea una opción sabrosa y práctica para cualquier ocasión.', 'polloasado.jpg', 6.65, 50, 2),
(76, 'ElPozo Chistorra Oreada, 250 gr', 'Chistorra oreada lista para freír en sartén o freidora. Deliciosas para tapear solas o con pan.', 'chistorra.jpg', 1.69, 50, 2),
(77, 'Tira de costilla de cerdo fresca (peso aprox. 935 gr)', 'Tira de costilla', 'tiradecostilla.jpg', 4.79, 50, 2),
(78, 'Churrasco de Ternera - 500 g', '2 piezas de 250 gr aproximadamente, también conocido como tira de asado . Elaborado en España por Grupo Embajadores 105330/M. Nacido en España. Cebado en España. Sacrificado en España.', 'churrasco.jpg', 4.29, 50, 2),
(79, 'Coren - Pechuga de Pavo Entera Bandeja, 820 gramos', 'Pechuga entera atada en malla de pavo en bandeja termosellada en atmósfera protectora.', 'pechugadepavomallada.jpg', 7.42, 50, 2),
(80, 'ROLER carpaccio ternera bandeja 110 g', 'Preparado de carne', 'carpaccio.jpg', 2.75, 50, 2),
(81, 'Pollo limpio entero unidad (peso aprox. 2.1 Kg)', 'Pollo Limpio Entero', 'pollolimpio.jpg', 5.23, 50, 2),
(82, 'Chuleta Vaca Gallega - 400 gramos', 'Chuleta de vaca', 'chuletadevaca.jpg', 8.10, 50, 2),
(83, 'Albóndigas de pollo bandeja 328 gr', 'Albóndigas de pollo', 'albondigaspollo.jpg', 3.19, 50, 2),
(84, 'Coren - Troceado Ajillo Pollo Corral (Delicias) Bandeja, 625 gramos', 'Piezas de Pollo de corral troceadas con piel y hueso envasadas en bandeja termosellada de atmósfera', 'ajillotroceado.jpg', 4.93, 50, 2),
(85, 'Filetes de pollo empanados bandeja 400 gr', 'Filete de Pollo Empanado', 'polloempanado.jpg', 2.40, 50, 2),
(86, 'Chorizo oreado (peso aprox. 500 gr)', 'CHORIZO CASERO', 'chorizooreado.jpg', 3.20, 50, 2),
(87, 'Morcilla de burgos pieza 320 gr', 'Morcilla burgos', 'morcilla.jpg', 1.24, 50, 2),
(88, 'ElPozo nuggets de pollo sin gluten, 320 gr', 'Deliciosos Nuggets de pechuga de pollo, para sartén o freidora.', 'nuggets.jpg', 2.69, 50, 2),
(89, 'Morcillo de añojo (peso aprox. 600 gr)', 'Morcillo de añojo', 'morcillo.jpg', 4.73, 50, 2),
(90, 'Costilla ibérica adobada (peso aprox. 1.3 Kg)', 'Costilla ibérica adobada', 'costillaIberica.jpg', 5.07, 50, 2),
(91, 'Coren - Magret Pato skin, 350 gramos', 'Pechuga de pato con piel envasada al vacío y con fajín de cartón.', 'magret.jpg', 6.46, 50, 2),
(92, 'Alas de pollo barbacoa bandeja 450 gr', 'Alas de pollo barbacoa', 'alasbbq.jpg', 2.19, 50, 2),
(93, 'Lomo de vaca madurado (peso aprox. 350 gr)', 'Lomo de vaca madurado', 'lomodevacamadurado.jpg', 5.79, 50, 2),
(94, 'ELPOZO codillo de jamón curado pieza 850 gr', 'Codillo de jamón', 'codillo.jpg', 1.69, 50, 2),
(95, 'Oreja de cerdo adobada y cocida envase 500 gr', 'Oreja en Adobo', 'orejadeadobo.jpg', 2.99, 50, 2),
(96, 'Guanciale - papada de cerdo para hacer Carbonara, 200 gramos', 'Papada de cerdo con pimienta para hacer carbonara', 'Guanciale.jpg', 6.00, 50, 2),
(97, 'Panceta ibérica salada - envase al vacío, 220 gramos', 'Panceta ibérica salada', 'panceta.jpg', 3.45, 50, 2),
(98, 'Paletilla Cordero lechal de Segovia - asar, 525-600 gramos', 'Carne tierna y suave. La carne es rica en proteínas de buena calidad, con proteínas de alto valor biológico. El color de la carne es un rosado pálido y posee muy poca gras', 'paletilla.jpg', 20.99, 50, 2),
(99, 'Callos de ternera bandeja 500 g', 'Callo Guisado de Ternera', 'callo.jpg', 2.75, 50, 2),
(100, 'Paleta asada al horno sin hueso (peso aprox. 900 gr)', 'Paleta asada al horno sin hueso', 'paleta.jpg', 7.19, 50, 2),
(101, 'Actimel - Danone Multipack Fresa 14 x 100 g Actikids', 'Leche fermentada con L.Casei Danone y Vitaminas, con una fórmula adaptada para tus hijos. La fresa intensa gustará a toda la familia.', '101.jpg', 5.70, 50, 3),
(102, 'Puleva Batido de Chocolate Sin Lactosa - Pack de 6 x 200 ml - Total: 1200 ml', 'PULEVA BATIDO CHOCOLATE SIN LACTOSA 6X200ML.', '102.jpg', 2.10, 50, 3),
(103, 'Central Lechera Asturiana - Leche Semidesnatada Brik 1L (Pack 6)', 'Leche Tradicional Brik 1L Semidesnatada. Con un sabor único y conservando todos los valores nutricionales necesarios. Perfecta para todos aquellos que no quieren renunciar a la leche más natural con todo su valor energético y proteínico. Se presenta también en pack de seis unidades para adaptarse a las necesidades del consumidor.', '103.jpg', 4.74, 50, 3),
(104, 'Leche Pascual - Clásica Leche Entera - 1 L (Paquete de 6)', 'Leche Pascual - Clásica Leche Entera - 1 L (Paquete de 6)', '104.jpg', 5.10, 50, 3),
(105, 'Leche Pascual - Clásica Leche Desnatada - 1 L (Paquete de 6)', 'Leche desnatada 0% Pascual. Caja 6 x 1 L.', '105.jpg', 5.10, 50, 3),
(106, 'Central Lechera Asturiana - Leche Entera Brik 1L (Pack 6)', 'Contiene leche o derivados de la leche (lactosa). Indicaciones: Una vez abierto conservar en el frigorífico. Gran calidad.', '106.jpg', 4.56, 50, 3),
(107, 'Puleva Vita Calcio Leche con Calcio Desnatada - Pack de 6 x 1 L - Total: 6 L', 'PULEVA VITA CALCIO DESNATADA 6X1L', '107.jpg', 6.90, 50, 3),
(108, 'Cola Cao Original - 400gr', 'Ingredientes: Azúcar, cacao desgrasado en polvo, crema de cereal kola-malteado (harina de trigo, extracto de malta de cebada, aroma natural: extracto de nuez de cola), sales minerales (calcio y fósforo), aromas, sal. Puede contener leche.', '108.jpg', 2.85, 50, 3),
(109, 'NESTLÉ LA LECHERA - Dulce de leche - Leche condensada - Lata de leche condensada', 'La leche condensada La Lechera es un producto natural, elaborado a partir de leche fresca recogida a diario en Galicia. Nestlé La Lechera ofrece calidad y confianza desde hace más de 100 años y es una dulce solución culinaria para hacer postres con un sabor único y cremoso. Descubre el rápido bizcocho en 5 minutos y el clásico flan casero entre más de 300 recetas deliciosas en Nestlé Cocina. Recetas aptas para dietas Vegetarianas, sin gluten y Halal.', '109.jpg', 2.06, 50, 3),
(110, 'Pascual Yogur Liquido de Fresa - Paquete de 2 x 80 gr - Total: 160 gr', 'Yogur Pascual Yogikids de fresa con tapónn para llevar.', '110.jpg', 1.89, 50, 3),
(111, 'Bifrutas - Tropical Zero - Bebida Refrescante de Leche y Zumo de Frutas - 3 x 33', 'Alto contenido en vitaminas A, C y E', '111.jpg', 1.61, 50, 3),
(112, 'NESTLÉ Sveltesse - Leche desnatada en Polvo - Bote 400g', 'Elaborada con leche de vaca de excelente calidad, a la que se le ha quitado lagasa de la leche, sin perder ninguna de sus vitaminas, porque NESTLE repone todas las vitaminas liposolubles (A,D,E y K) que se pierden en el proceso de desnatado.', '112.jpg', 4.45, 50, 3),
(113, 'Central Lechera Asturiana - Leche Semidesnatada Brik 1L (Pack 6)', 'Leche Tradicional Brik 1L Semidesnatada. Con un sabor único y conservando todos los valores nutricionales necesarios. Perfecta para todos aquellos que no quieren renunciar a la leche más natural con todo su valor energético y proteínico. Se presenta también en pack de seis unidades para adaptarse a las necesidades del consumidor.', '113.jpg', 4.74, 50, 3),
(114, 'Central Lechera Asturiana - Leche Desnatada Brik 1L (Pack 6)', 'Leche Tradicional Brik 1L Desnatada. Para los que se cuidan sin obsesiones y sin renunciar al sabor, la desnatada de siempre, la del envase verde. Con muy poca cantidad de grasa (0,25 g por 100 ml) es la leche desnatada que mejor sabe, reconocida con el sello sabor del año 2016. Viene en un moderno envase de cartón que se presenta también en pack de seis unidades para adaptarse a las necesidades del consumidor.', '114.jpg', 4.74, 50, 3),
(115, 'Roig Naturelle - Huevos frescos L de gallinas criadas en suelo 10 unidades', 'Huevos frescos de gallinas criadas en suelo y con acceso al aire libre en parques protegidos. Huevos de 63 g a 73 g. Alimentación certificada.', '115.jpg', 1.83, 50, 3),
(116, 'Coren - Huevos Camperos - 10 unidades', 'Huevos Camperos', '116.jpg', 2.48, 50, 3),
(117, 'CLARA DE HUEVO FACIL', 'Clara de huevo', '117.jpg', 3.29, 50, 3),
(118, 'Roig - Huevos frescos L de gallinas criadas en suelo 8 unidades', 'Huevos frescos de gallinas criadas al suelo y con acceso al aire libre en parques protegidos. Huevos de +68 g.', '118.jpg', 1.98, 50, 3),
(119, 'CO`OK huevos de codorniz estuche 12 uds', 'Huevos de codorniz', '119.jpg', 0.99, 50, 3),
(120, 'Huevos de Lumagorri - 10 unidades, 560 gramos', 'Gallinas criadas al aire libre y alimentadas a base de maiz', '120.jpg', 5.00, 50, 3),
(121, 'Oikos Original - Yogur Griego Natural, 4 x 115 g', 'Es más cremoso, consistente y sabroso. Oikos encuentra el equilibrio óptimo entre sus ingredientes, manteniendo una cremosidad recomendada con sabor natural.', '121.jpg', 1.99, 50, 3),
(122, 'Danone Activia - Yogur Cremoso, Lima Limón, Pack 4 x 120 g', 'Activia Cremoso reúne lo mejor de la fruta y además no tiene trozos. Recomendado para aquellos que prefieren una textura más fina y sedosa. Intensamente cremoso y sin grasa.', '122.jpg', 1.89, 50, 3),
(123, 'Oikos Azucarado - Yogur Griego Natural, Azucarado, 4 x 115 g', 'Es cremoso, consistente y sabroso. Oikos encuentra el equilibrio óptimo entre sus ingredientes, manteniendo una cremosidad recomendada con sabor azucarado.', '123.jpg', 1.99, 50, 3),
(124, 'Danone Activia - Yogur Cremoso, 0%, Mango, Pack 4 x 120 g', 'Activia Cremoso reúne lo mejor de la fruta y además no tiene trozos. Recomendado para aquellos que prefieren una textura más fina y sedosa. Intensamente cremoso y sin grasa.', '124.jpg', 1.89, 50, 3),
(125, 'Danonino Fresa, Plátano - Paquete de 6 x 50 gr - Total: 300 gr', 'PetitDino es un queso fresco con leche, calcio y vitamina D, con un buen sabor fresa-plátano. Gracias a su textura, que no se cae de la cuchara, se lo pueden comer solitos sin ensuciarse demasiado. Además, aprenderán las letras con las bajotapas.', '125.jpg', 1.09, 50, 3),
(126, 'Oikos Sensaciones - Yogur Griego con Stracciatella, 2 x 115 g', 'Es más cremoso, consistente y sabroso que un yogur básico por la manera en la que se elabora. Oikos encuentra el equilibrio perfecto entre sus ingredientes, manteniendo una cremosidad recomendada con straciatella.', '126.jpg', 1.09, 50, 3),
(127, 'Danone Vitalinea Proteina - Leche fermentada Sabor Fresa con queso fresco, 4 x 1', 'Vitalinea Pro con 0% con el doble de proteínas, recomendado para tomar entre horas o para completar tus cenas suaves.', '127.jpg', 2.10, 50, 3),
(128, 'DIA yogur al estilo griego fresa pack 6 unidades 125 gr', 'Yogur al estilo griego fresa', '128.jpg', 1.39, 50, 3),
(129, 'Danone Yogur Cremoso Natural con Fermentos Naturales - Paquete de 4 unidades', 'Yogur cremoso natural que recupera toda la tradición de un tiempo en el que las cosas se hacían sin prisa, de forma sencilla y cuidadosa.', '129.jpg', 1.69, 50, 3),
(130, 'Danone YoPRO Arándanos - 2 x 160 g. Total 320 g', 'El yogur para deportistas YoPRO Arándanos contiene 15 gramos de proteína para recuperar naturalmente los músculos. Con 0 % materia grasa y 0 % azúcares añadidos.', '130.jpg', 1.99, 50, 3),
(131, 'CLESA crema bombón 0,7% M.G. pack 4 unidades 125 gr', 'Postre lácteo al cacao con azúcares y edulcorantes', '131.jpg', 1.15, 50, 3),
(132, 'CLESA yogur sabor galleta pack 4 unidades 125 gr', 'Yogur sabor a galleta', '132.jpg', 0.99, 50, 3),
(133, 'NESTLE NESQUIK petit chocolate pack 6 unidades 60 g', 'Postre lácteo con cacao', '133.jpg', 1.35, 50, 3),
(134, 'Central Lechera Asturiana - Mantequilla Tradicional, 250 g', 'La mantequilla tradicional en barqueta 250 g se elabora a partir de la mejor leche de Central Lechera Asturiana. Es la mantequilla más auténtica, por eso su sabor es único. Una mantequilla tradicional nutritiva y con ingredientes 100% naturales, sin aditivos, colorantes ni E-s artificiales. Porque lo natural, natural, te sabe mejor. La mantequilla tradicional en barqueta es un clásico de Central Lechera Asturiana con una textura cremosa para que disfrutes al máximo, y que se convierte en la perfecta aliada para tus desayunos y recetas. La encontrarás en tu supermercado de confianza, en la parte de refrigerados, en un cómodo recipiente en forma de barqueta, pensado para poder guardarla en la nevera de una manera más cómoda y que ayuda a mantenerla más tiempo perfecta en la nevera, gracias a su tapa de plástico. Además, el envase de la mantequilla tradicional en barqueta 250 g es reciclable en el contenedor amarillo.', '134.jpg', 2.29, 50, 3),
(135, 'DIA nata líquida para cocinar 18% M.G. pack 3 unidades 200 ml', 'Nata líquida para cocinar', '135.jpg', 1.35, 50, 3),
(136, 'OLDENBURGER mantequilla sin sal pastilla 250 gr', 'Mantequilla sin sal', '136.jpg', 1.65, 50, 3),
(137, 'Flora - Margarina Oliva - 250 g', 'Agua, (Aceites Vegetales (Girasol, Oliva, Linaza) (81%) Y Grasa Del Fruto De La Palma) (40%), Gelatina, Sal (0,3%), Emulgentes (Mono Y Diglicéridos De Ácidos Grasos, Lecitina De Girasol), Conservador (Sorbato Potásico), Acidulante (Ácido Cítrico), Vitaminas (Riboflavina, A, D, Tiamina), Aromas.', '137.jpg', 1.49, 50, 3),
(138, 'Central Lechera Asturiana - Mantequilla, Rulo, 250 g', 'La mantequilla tradicional en rulo 250 gramos Central Lechera Asturiana es un clásico dentro de los productos que se elaboran con la mejor leche. Con ella podrás disfrutar al máximo de tus desayunos y sorprender a todo el mundo con las más exquisitas recetas gracias a su sabor único. La mantequilla tradicional en rulo se diferencia por su textura suave y cremosa, que sorprende. Además, solo tiene un ingrediente: mantequilla de leche, ¡y nada más! Sin aditivos, conservantes ni E-s artificiales, un producto 100% natural. Porque lo natural, natural, te sabe mucho mejor. Puedes encontrarla en un formato en rulo de 250 gramos en tu tienda de alimentación de confianza, en la sección de productos de conservación en frío. La mantequilla tradicional en rulo se presenta envuelta en un papel metálico, que puedes reciclar tirando en el contenedor azul y que ayuda a protegerla y a almacenarla en la nevera.', '138.jpg', 2.25, 50, 3),
(139, 'DIA nata spray 250 ml', 'Nata Spray', '139.jpg', 1.05, 50, 3),
(140, 'Mantequilla fresca al corte - envase al vacío, 300 gramos', 'Mantequilla fresca al corte', '140.jpg', 8.34, 50, 3),
(141, 'Garcia Baquero Queso Fresco de Cabra - 500gr', 'Queso Fresco de Cabra Extramini 500gr de García Baquero. Con un sabor y frescura como recién hecho. Sin Colorantes ni conservantes. Sin Gluten', '141.jpg', 7.15, 50, 3),
(142, 'Président - Crema De Queso Semicurado fundido, 125 g', 'Queso crema de Semicurado con todo su sabor original con una textura muy cremosa. Queso ideal para untar', '142.jpg', 1.45, 50, 3),
(143, 'Gran Capitán Curado - Queso cortada de oveja y vaca, 210 g', 'Queso en cuña ya cortado con más de 5 meses de maduración. Una combinación perfecta de leche de oveja y vaca, que hace de éste un producto único por su textura y sabor. Queso de sabor intenso, textura firme, y un aroma a oveja.', '143.jpg', 4.09, 50, 3),
(144, 'Roncari-Blue - Capricho Español - Queso Azul de Leche de Oveja en Cuña - 100 g', 'Delicioso Queso azul puro de oveja Roncari-Blue para tablas y tapas de toda la familia. Disponible en formato cuña', '144.jpg', 1.85, 50, 3),
(145, 'President Queso Rallado Emmental - 150 gr', 'Queso rallado hecho mediante una selección de las ruedas más tiernas y afrutadas. El Emmental Président es naturalmente rico en calcio', '145.jpg', 1.95, 50, 3),
(146, 'Central Lechera Asturiana - Nata liquida uht para montar y decorar - 1l', 'Contiene Leche o derivados de la leche (lactosa)', '146.jpg', 3.56, 50, 3),
(147, 'Bechamel, 500 ml', 'Bechamel Reny Picot', '147.jpg', 3.70, 50, 3),
(148, 'Nata agria Rottaler, 200 gramos', 'Ingredientes: nata y proteinas de la leche', '148.jpg', 3.90, 50, 3),
(149, 'Arla Queso Havarti Lonchas - 150 gr', 'Arla Havarti Lonchas 150g', '149.jpg', 2.40, 50, 3),
(150, 'El Caserio - Queso Gratinar 4 Quesos, 140 g', 'Deliciosa mezcla de 4 quesos (Cheddar, Emmental, Gouda, Curado). Pruébala con tus pastas y tus pizzas para tener un sabor único', '150.jpg', 2.09, 50, 3),
(151, 'Lay´s - Gourmet - Patatas Fritas con Sal - 180 g', 'Ingredientes: patatas, aceite de girasol y sal.', '151.jpg', 2.15, 50, 4),
(152, 'Ruffles - Patatas Fritas con Sabor a Jamón - 170 g', 'Ingredientes: patatas, aceite de palma, aroma a jamón, lactosa, potenciadores del sabor (glutamato monosódico, inosinato y guanilato disódicos), preparaciones y sustancias aromatizantes, proteína de soja hidrolizada, queso en polvo (de leche), aroma de humo, sal.', '152.jpg', 1.35, 50, 4),
(153, 'Doritos Dippas Nachos de Maíz - 200 g', 'Doritos Dippas 200g, nachos de maíz.', '153.jpg', 1.83, 50, 4),
(154, 'Fritos - Producto de aperitivo de maiz frito con sabor a carne ahumada - 156 g', 'Ingredientes: maíz (78%), aceite de palma, aroma de carne ahumada, preparaciones y sustancias aromatizantes, potenciadores del sabor (glutamato monosódico, inosinato y guanilato disódicos), lactosa, proteínas de leche, aromas de humo, acidulante (ácido cítrico), sal.', '154.jpg', 1.19, 50, 4),
(155, 'Ruffles -Original - Patatas Fritas con Sal - 170 g', 'Ingredientes: patatas, aceite de palma y sal.', '155.jpg', 1.15, 50, 4),
(156, 'Lay´s Patatas Fritas - 300 gr', 'Ingredientes: patatas, aceite de maíz y sal.', '156.jpg', 1.85, 50, 4),
(157, 'Doritos - Tex-Mex - Producto de Aperitivo de Maíz Frito con Sabor Queso - 150 g', 'Ingredientes: maíz (80%), aceite de palma, condimento preparado con sabor a queso, derivados de leche (contienen lactosa), harina de trigo, queso en polvo (de leche), tomate en polvo, sustancias aromatizantes, aceite de girasol, cebolla en polvo, suero de mantequilla en polvo (de leche), cloruro potásico, potenciador del sabor (glutamato monosódico), ajo en polvo, dextrosa, reguladores de acidez (ácido cítrico), colorantes (extracto de pimentón, annatto, caramelo natural), especias, azúcar, sal.', '157.jpg', 1.30, 50, 4),
(158, 'DIA DELICIOUS chips de hortalizas bolsa 100 gr', 'DELICIOUS chips de hortalizas', '158.jpg', 1.99, 50, 4),
(159, 'Lay´s Vinagreta Patatas Fritas Sabor A Salsa Vinagreta - 170 gr', 'Ingredientes: Patatas. aceite de maíz. aroma de sal y vinagre reguladores de acidez acetato y diacetato de sodio. acidulante ácido cítrico. potenciadores del sabor glutamato monosódico. 5 ribonucleótido disódico. cloruro potásico. sal.', '159.jpg', 1.40, 50, 4),
(160, 'Lay´s Patatas Fritas Campesinas - 170 gr', 'Ingredientes: patatas, aceite de maíz, condimento preparado de vegetales y especias (lactosa, azúcar, potenciadores del sabor (glutamato monosódico, 5-ribonucleótido disódico), dextrosa, cebolla en polvo, pimentón molido, tomate en polvo, ajo en polvo, perejil, proteína hidrolizada de soja, sustancias aromatizantes, reguladores de acidez (ácido cítrico, ácido málico), colorante (extracto de pimentón), edulcorante (aspartamo), proteínas de leche, aromas de humo), sal. Contiene una fuente de fenilalanina.', '160.jpg', 1.35, 50, 4),
(161, 'Lay´s - Mediterráneas, Patatas Fritas, 100% Aceite de Oliva - 160 gr', 'Patatas fritas en aceite de oliva (31% sobre producto final). Patatas fritas en aceite de oliva (31% sobre producto final). Conservar en lugar fresco y seco.', '161.jpg', 1.75, 50, 4),
(162, 'DIA conos de maíz sabor queso y bacon bolsa 85 gr', 'Conos de maíz sabor queso y bacon', '162.jpg', 0.49, 50, 4),
(163, 'Bicentury - Tortitas Maíz Tomate Con Aceite De Oliva Nackis - 123.5 g', 'Puede contener leche. País de origen: España. Una vez abierto mantener en el frigorífico y consumir en el plazo de una semana, Bocadelia, Patés fresco - 180 gr.', '163.jpg', 1.53, 50, 4),
(164, 'Ruffles - Patatas Fritas con Sabor a Jamón y Queso - 170 gr', 'Ingredientes: patatas, aceite de palma, aroma a jamón y queso, suero de leche en polvo, potenciadores del sabor (glutamato monosódico, guanilato e inosinato disódicos), azúcar, preparaciones y sustancias aromatizantes, proteína de leche, lactosa, harina de soja, sal.', '164.jpg', 1.40, 50, 4),
(165, 'Sunbites, Snack ondulados multicereales al toque de sal - 95 gr', 'Sunbites sal marina, 95 g. Conservar en lugar fresco y seco. Proteger de la luz solar y de olores agresivos.', '165.jpg', 1.45, 50, 4),
(166, 'Doritos - Chilli - 150 g', 'Ingredientes: maíz (81%), aceite de palma, condimento preparado sabor a pimiento picante, fructosa, sustancias aromatizantes, potenciadores del sabor (glutamato monosódico, 5´-ribonucleótido disódico), correctores de acidez (diacetato sódico, ácido málico) , azúcar, maltodextrina, cebolla en polvo, proteína hidrolizada de soja, soja, ajo en polvo, trigo, colorantes (extracto de pimentón, rojo de remolacha), sal.', '166.jpg', 1.45, 50, 4),
(167, 'Bicentury - Tortitas De maíz con chocolate negro - 4 x 23.7 g', 'Tortitas de maíz con chocolate negro', '167.jpg', 1.89, 50, 4),
(168, 'DIA pipas de calabaza bolsa 200 gr', 'Pipas de calabaza', '168.jpg', 1.75, 50, 4),
(169, 'Doritos Bits Bbq 33G', 'Producto de aperitivo de maíz frito con sabor a barbacoa.', '169.jpg', 0.40, 50, 4),
(170, 'CHEETOS cheetos pelotazos bolsa 30GRS', 'Producto de aperitivo de maíz horneado con sabor a queso', '170.jpg', 0.40, 50, 4),
(171, 'Ortiz Pan Tostado Multicereales, 30 rebanadas, 324gr', 'Ortiz Pan Tostado Multicerelaes ahora con una rebanada más resistente y en cómodos packs individuales que permiten mantener su frescura por más tiempo. Elaborado a base de ingredientes seleccionados y con un lento y cuidadoso proceso de horneado, los maestros panaderos de Ortiz consiguen un pan tostado sabroso, ligero y extra crujiente.', '171.jpg', 1.89, 50, 4),
(172, 'Tuc - Galletas Saladas Crackers Original, 100 g', 'TUC es la inconfundible galleta salada perfecta para saciar tu apetito en cualquier lugar a cualquier hora del día. Una deliciosa galleta con toda la calidad de la marca Lu.', '172.jpg', 0.81, 50, 4),
(173, 'Gourmet - Mini crackers redondas - 350 g', 'Harina De Trigo, Grasa Vegetal De Palma (Con Antioxidante E-306), Jarabe De Glucosa Y Fructosa, Azúcar, Extracto De Malta De Cebada, Sal, Corrector De La Acidez (Fosfato Monocálcico), Gasificantes (Bicarbonato Sódico Y Amónico), Levadura Natura, Huevo, Agente De Tratamiento (Metabisulfito Sódico) Puede Contener Trazas De: Puede Contener Trazas De Sésamo Y Leche Por Contaminación Cruzada', '173.jpg', 1.09, 50, 4),
(174, 'Wasa, Pan crujiente, Original 275gr', 'Wasa Original es un pan crujiente ligeramente más delgado. Mucha gente dice que Wasa Original es un pan algo más crujiente. Este pan crujiente encaja bien con la mayoría de los ingredientes, ¡así que deja fluir tu creatividad!. Queso crema, tomate y ruccola...', '174.jpg', 2.30, 50, 4),
(175, 'Gourmet - Regañás ajonjolí - 1000 g', 'Contiene Granos de sésamo y/o productos a base de a base de granos de sésamo', '175.jpg', 2.59, 50, 4),
(176, 'Recondo - Picatostes Tostados, 80 g', 'Picatostes tostados redondos, receta natural, y textura crujiente. Tostados, no fritos. La bolsa contiene aproximadamente 120 rebanadas a granel (80g de producto en total).', '176.jpg', 1.21, 50, 4),
(177, 'RECONDO pan tostado chapata caja 167 gr', 'Chapata - Pan tostado', '177.jpg', 1.79, 50, 4),
(178, 'Bimbo Panecillo Tostado Tradicional, 20 uds, 225g', 'El Panecillo Tostado Tradicional de Bimbo está elaborado con una cuidada selección de ingredientes y un proceso de cocción y horneado lento que garantiza que esté siempre crujiente y en su punto justo. Es un desayuno adecuado que combina con dulce o salado y una alternativa deliciosa para comidas, cenas ligeras e incluso entre horas que además le aporta: Fuente de fibra · Bajo contenido de grasas saturadas', '178.jpg', 1.25, 50, 4),
(179, 'Dr. Schar Milly Gris & Ciocc - Palitos con chocolate SIN GLUTEN - 52 gr', 'Ingredientes: fécula de patata, harina de arroz, almidón de maíz modificado, levadura, harina de alforfón, aceite de palma, jarabe de glucosa-fructosa, azúcar, sal, espesante: E-464; emulgente: E-472e; gasificante: carbonato ácido de amonio; aroma natural. Crema de cacao 32 g: azúcar, aceite de palma, avellanas 10%, cacao en polvo 7,5%, emulgente: lecitina de girasole; aroma natural de vainilla. Puede contener trazas de soja, proteínas de leche, cacahuetes, almendras y nueces.', '179.jpg', 1.73, 50, 4),
(180, 'Galletas Club Social  - 9 paquetes, 234 gramos', 'Galletas saladas', '180.jpg', 4.40, 50, 4),
(181, 'La Española - Clásicas - Aceitunas Verdes Rellenas De Anchoa - 3 x 120 g', 'Aceitunas Manzanilla Fina Verdes Aderezadas, , Sal, Relleno De Anchoa 6%(Anchoa, Estabilizante: Alginato Sódico), Potenciador Del Sabor:Glutamato Monosódico, Acidulante: Ácido Cítrico, Antioxidante:Ácido Ascórbico', '181.jpg', 2.20, 50, 4),
(182, 'Rioverde - Pepinillos sabor anchoa - Muy pequeños - 345 g', 'Pepinillos sabor anchoa', '182.jpg', 1.53, 50, 4),
(183, 'DIA aceitunas negras sin hueso lata 150 gr', 'Aceitunas negras sin hueso', '183.jpg', 0.89, 50, 4),
(184, 'DIA pepinillos sabor anchoa frasco 180 gr', 'Pepinillos sabor anchoa', '184.jpg', 1.05, 50, 4),
(185, 'Serpis - Aceituna Negra, Sin hueso, 2 x 200g', 'Aceituna Cacereña Deshuesada, Sal, Acidulante: Ácido Láctico, Estabilizante: Lactato Ferroso Y Aromas Naturales. Esterilizado', '185.jpg', 2.10, 50, 4),
(186, 'Capperi sotto sale - alcaparras bajo en sal, 100 gramos', 'Capperi sotto sale - alcaparras bajo en sal', '186.jpg', 3.00, 50, 4),
(187, 'Rioverde - Cebollitas rojas - Agridulces extra - 180 g', 'Cebollitas rojas', '187.jpg', 1.16, 50, 4),
(188, 'Luengo Alubias Cocidas con Verduras - 570 gr', 'Alubias cocidas con verduras categoría extra.', '188.jpg', 1.25, 50, 4),
(189, 'DIA cebollitas en vinagre frasco 180 gr', 'Cebollitas en vinagre', '189.jpg', 0.99, 50, 4),
(190, 'DIA aceitunas verdes gazpacha con hueso frasco 500 gr', 'Aceitunas verdes gazpacha con hueso', '190.jpg', 2.09, 50, 4),
(191, 'DIA nuez mondada bolsa 200 gr', 'Nuez mondada bolsa 200 gr', '191.jpg', 2.79, 50, 4),
(192, 'DIA pistachos tostad.c/s bolsa 200GR', 'Pistachos', '192.jpg', 1.99, 50, 4),
(193, 'DIA anacardos bolsa 125G.', 'Anacardos', '193.jpg', 1.39, 50, 4),
(194, 'DIA DELICIOUS cocktail frutos secos bolsa 180 gr', 'Cocktail frutos secos', '194.jpg', 2.89, 50, 4),
(195, 'DIA cacahuete frito salado bolsa 250 gr', 'Cacahuete frito salado', '195.jpg', 0.79, 50, 4),
(196, 'Pipas G Grefusa - Pipas Tijuana, 165 g', 'Conservar en un lugar fresco, seco y protegido del sol', '196.jpg', 1.39, 50, 4),
(197, 'DIA maíz para palomitas bolsa 500 gr', 'Maíz para palomitas', '197.jpg', 1.35, 50, 4),
(198, 'Borges - Pistachos con cáscara tostados y salados - Bolsa de 130 g', 'Pistachos con cáscara Borges, tostados y salados en su perfecta medida, bolsa de 130 gramos. Seleccionados en origen bajo los cánones de calidad Borges. Perfectos como aperitivo.', '198.jpg', 3.51, 50, 4),
(199, 'Sunbites, Mezcla de frutos secos y pasas - 125 gr.', 'Snack perfecto para consumir entre horas. Extracrujiente y con un sabor natural. Sin colorantes ni conservantes. Con unos beneficios únicos y diferenciales: 0% sal añadida y fuente de fibra, vitaminas y minerales', '199.jpg', 2.42, 50, 4),
(200, 'Marca Amazon - Happy Belly Mezcla de frutos secos y pasas, 1000 g', 'Marca Amazon - Happy Belly Mezcla de frutos secos y pasas, 1000 g', '200.jpg', 15.40, 50, 4),
(201, 'Pan 8 cereales barra 210 gr', 'Pan 8 cereales', '201.jpg', 0.79, 50, 5),
(202, 'Croissants 6 uds 240 gr', 'Croissants', '202.jpg', 1.15, 50, 5),
(203, 'EMPANADA DE ATÚN', 'EMPANADA DE ATÚN', '203.jpg', 3.00, 50, 5),
(204, 'Empanada de carne 550 gr', 'Empanada de carne 550 gr', '204.jpg', 3.29, 50, 5),
(205, 'Empanada de bacalao 550 gr', 'Empanada de bacalao', '205.jpg', 3.39, 50, 5),
(206, 'Nutella - Gracias - Crema de Avellanas y Cacao - 350 g', 'La crema de avellanas más vendida en el mundo. Su inconfundible sabor la ha convertido en un mito para las nuevas generaciones que buscan en el desayuno, carga y optimismo para empezar bien el día. Un delicioso desayuno con Nutella', '206.jpg', 3.49, 50, 5),
(207, 'La vieja fábrica - Melocotón - Mermelada - 350 g', 'Indicaciones: Una Vez Abierto Conservar Refrigerado. Ingredientes: Melocotón, Azúcar, Gelificante (Pectina), Corrector De Acidez (Ácido Cítrico), Conservador (E-202), Antioxidante (Ácido Ascórbico).', '207.jpg', 1.75, 50, 5),
(208, 'Granja San Francisco - Miel de Milflores - 0% Goteo - 425 g', 'Miel de Milflores. Indicaciones: mantener a temperatura moderada, en lugar seco. No calentar.', '208.jpg', 5.19, 50, 5),
(209, 'Hero Diet, Mermelada (Fresas) - 280 gr.', 'Confitura Diet Fresas. 100% sabor y 0% azúcares añadidos, solo lleva fruta e ingredientes naturales: stevia, aronía y acerola y zumo de limón. Perfecta para todos aquellos que quieran disfrutar de todo el sabor de la mejor confitura sin dejar de cuidarse.', '209.jpg', 1.69, 50, 5),
(210, 'Capitán Maní - Crema de cacahuete - Suave - 340 g', 'Crema de cacahuete suave', '210.jpg', 3.25, 50, 5),
(211, 'Bimbo Sin Corteza Pan Blanco 450g, 16 rebanadas', 'En Bimbo nos preocupa tanto como a ti, tu alimentación y la de tu familia. Por eso día a día te ofrecemos productos tiernos, sabrosos, frescos y nutritivos. Creamos el Compromiso Bimbo para llevar a tu mesa los mejores productos y garantizar que disfrutes con los tuyos de los pequeños momentos de cada día. De nuestra familia a la tuya.', '211.jpg', 1.99, 50, 5),
(212, 'Bimbo - Familiar - Pan de molde para sandwich - 26 rebanadas - 700 g', 'Bimbo con corteza de toda la vida. Todo un clásico.', '212.jpg', 1.79, 50, 5),
(213, 'Oroweat 12 Cereales y Semillas, pan multicereales con corteza 680g, 16 rebanadas', 'Descubre Oroweat 12 Cereales, con una selección única decereales y semillas que notarás en cada bocado: semillas de girasol, avena, trigo, centeno, triticale, cebada, maíz, alforfón, arroz, mijo, espelta y semillas de lino. Una exquisita combinación con una rebanada gruesa y consistente que harán de tus sándwiches y tus tostadas algo extraordinario.', '213.jpg', 2.59, 50, 5),
(214, 'Bimbo Rebanada Estilo Artesano, Pan blanco con corteza 550g, 14 rebanadas', 'Descubre Bimbo Rebanada estilo Artesano con una rebanada extra gruesa y una textura doble tierna. Compártelo con tu familia y disfrútalo tanto en tostadas como en sándwiches. Pruébalo y te convencerás.', '214.jpg', 2.29, 50, 5),
(215, 'Bimbo Panecillo para Burgers, 300g, 4 unidades', 'Panecillo consistente, tierno y esponjoso y en tamaño Maxi para que disfrutes de las Burgers más deliciosas.', '215.jpg', 1.69, 50, 5),
(216, 'Pan de Leche La Bella Easo, 10 uds, 350 gr', 'El pan de leche de La Bella Easo tiene un sabor inigualable, es tierno y está elaborado sin conservantes y sin colorantes. La Bella Easo, la forma tierna de comer cereales.', '216.jpg', 2.10, 50, 5),
(217, 'Cuetara - Cereales infantiles inflado chocolateado, 550 g', 'Choco Flakes 550 gr. Galleta con cereal inflado chocolateado y chips de chocolate. Con hierro y calcio.', '217.jpg', 2.45, 50, 5),
(218, 'Chocapic Cereales de Trigo y Maíz Tostados con Chocolate - 500 gr', 'Un delicioso cereal hecho con cereales integrales con vitaminas y minerales, y con un rico sabor a chocolate que a los niños les encanta.', '218.jpg', 2.45, 50, 5),
(219, 'Kellogg´s Special K Chocolate Negro Cereales - 375 g', 'Contiene Leche o derivados de la leche (lactosa)', '219.jpg', 2.65, 50, 5),
(220, 'Special K - Classic 500 g', 'Contiene Gluten o presencia de cereales que contienen gluten', '220.jpg', 3.29, 50, 5),
(221, 'Kellogg´s Corn Flakes Cereales - 500 g', 'Contiene Gluten o presencia de cereales que contienen gluten', '221.jpg', 2.45, 50, 5),
(222, 'Kelloggs - Frosties - Cereales, 375 g', 'Contiene Gluten o presencia de cereales que contienen gluten', '222.jpg', 2.47, 50, 5),
(223, 'Artiach - Galletas Dinosaurus Superfamiliar 411 g', 'Dinosaurus Cereales 411 gr. Galletas de cereales con vitaminas. Con bolsitas para comer dentro o fuera de casa. Con formas de Dinosaurus.', '223.jpg', 2.09, 50, 5),
(224, 'Gullón - Digestive Avena Choc - Galleta integral con avena, trigo y gotas de cho', 'Copos De Avena 34%, Harina Integral De Trigo 22%, Gotas De Chocolate Negro 15% (Azúcar, Pasta De Cacao, Dextrosa, Manteca De Cacao, Emulgente: Lecitina De Soja, Aromas), Aceite Vegetal (Girasol Alto Oleico) 14,5 %, Azúcar, Jarabe De Glucosa Y Fructosa, Gasificantes (Bicarbonato Sódico Y Amónico), Sal. Puede Contener Trazas De Leche. Con Girasol Alto Oleico.', '224.jpg', 1.28, 50, 5),
(225, 'Tosta Rica - Galletas, 860 g', 'Tosta Rica 860 gr. Original. Galletas con dibujos de los personajes favoritos de los niños. Enriquecidas con 6 vitaminas, hierro, calcio y cereales.', '225.jpg', 2.76, 50, 5),
(226, 'Tosta Rica - Galletas Tosta Rica Oceanixm, 480 g', 'Trica Oceanix 480 gr. Galletas de cacao y chips de chocolate. Con los dibujos en relieve de los personajes del mar. Con cereales, vitaminas, hierro y calcio.', '226.jpg', 2.95, 50, 5),
(227, 'Dinosaurus - ChocoLeche - Galleta de cereales con chocolate con leche - 8 paquet', 'Dinosaurus Chocoleche 340 gr. Galletas de cereales con chocolate con leche. Con bolsitas para comer dentro o fuera de casa.', '227.jpg', 2.65, 50, 5),
(228, 'Artiach Chiquilín Ositos - Galletas de cereales sabor Chocolate, 450 g', 'Chiquilin Ositos Choco 450 gr. Mini galletas de cereales sabor chocolate. Con el tamaño ideal para consumir con cuchara.', '228.jpg', 3.29, 50, 5),
(229, 'Lu - Mikado - Palitos De Galleta Chocolate Con Leche - 75 g', 'Contiene gluten o presencia de cereales que contienen gluten', '229.jpg', 1.31, 50, 5),
(230, 'DIA galletas tipo Digestive con chocolate paquete 300 grs', 'Galletas tipo Digestive con chocolate', '230.jpg', 0.95, 50, 5),
(231, 'Kinder Chocolate - Barritas de Chocolate con Leche - 8 unidades x 12.5 g', 'Chocolate con leche extrafino relleno de crema rica en leche. Una mezcla armoniosa sabores texturas contrastantes. Se debe conservar en un lugar fresco y seco.', '231.jpg', 1.49, 50, 5),
(232, 'DIA galletas cookies con pepitas de chocolate 40% estuche 225 gr', 'Galletas cookies con pepitas de chocolate', '232.jpg', 0.85, 50, 5),
(233, 'Principe - Galletas sandwich con relleno de chocolate - 300 g', 'Galletas de cereales con leche rellenas (35%) con crema de chocolate.', '233.jpg', 1.66, 50, 5),
(234, 'Respiral - Caramelo mentol refrescante - 150 g', 'Bolsa de 150 gramos de caramelos refrescantes duros de color amarillo con sabor a menta. Caramelo clásico que nunca pasa de moda', '234.jpg', 0.94, 50, 5),
(235, 'Orbit Bote - Chicle Sin Azúcar Eucalipto 60 grágeas', 'Contiene Soja y/o productos a base de soja', '235.jpg', 2.85, 50, 5),
(236, 'Nestlé Extrafino Tableta de Chocolate con Leche - Pack de 3 x 125 g - Total: 375', 'Tableta de chocolate con leche Nestlé Extrafino. El chocolate con leche de las meriendas de toda la vida.', '236.jpg', 2.49, 50, 5),
(237, 'Mermelada extra fresa hero temporada 350 g', 'Disfruta de todo el sabor de la Mermelada de Fresa de Temporada en tus desayunos y postres favoritos. Está elaborada solo en el tiempo de cosecha y seleccionando las mejores fresas, en cantidad limitada y en función de la fruta disponible. Está envasada al baño maría para su perfecta conservación durante meses. Todo natural: sin conservantes ni colorantes, igual que lo harías tú en casa', '237.jpg', 1.79, 50, 5),
(238, 'Lindt Chocolate con leche - 125 g', 'Nuestros Maestros Chocolateros combinan pasión y talento, siguiendo la tradición del chocolate más puro para crear la tableta de chocolate con leche Lindt Receta Clásica 125 g. Elaborada con los mejores ingredientes, incluyendo habas de cacao puro de fuentes sostenibles, para darle un sabor incomparable. La tableta perfecta para disfrutar en cualquier momento, cuando quieras darte un capricho. Con la excelencia de Lindt en sus elaboraciones, puedes tener la seguridad de que estarás saboreando el mejor chocolate.', '238.jpg', 1.25, 50, 5),
(239, 'Mikado - King Choco, Palitos De Galleta y Chocolate - 51 g', 'Contiene gluten o presencia de cereales que contienen gluten', '239.jpg', 1.76, 50, 5),
(240, 'Milka Galletas con Chocolate - 150 g', 'Contiene gluten o presencia de cereales que contienen gluten.', '240.jpg', 1.90, 50, 5),
(241, 'NESTLÉ KITKAT Mini Chocolate con Leche - Barritas de chocolate con leche - Snack', 'Tómate un respiro y recarga pilas con KITKAT Mini, donde y cuando quieras. Deliciosas Mini barritas de crujiente galleta recubierta de suave chocolate con leche. En busca de la mejor calidad nuestros productos contienen 100% Cacao de cultivo sostenible seleccionado a través de NESTLE Cocoa Plan. Certificado UTZ y aromas naturales. ¡Tómate un respiro, toma un KITKAT!', '241.jpg', 1.99, 50, 5),
(242, 'NESCAFÉ Café Classic Soluble Natural | Bote de cristal | Paquete de 100g de Café', 'Con NESCAFÉ Classic Natural Soluble disfrutarás del aroma único a café recién molido, ya que hemos capturado los mejores aromas de nuestros granos de café después del tueste y la molienda. café hecho a base de una mezcla de granos de arábica y Robusta, es un café ideal para preparar con leche. NESCAFÉ es un café de cultivo sostenible. En NESCAFÉ, llevamos más de 75 años asegurando la mejor calidad de café en cada taza ¡Empieza tu día de la mejor manera con un delicioso desayuno con sabor a NESCAFÉ Classic!', '242.jpg', 3.41, 50, 5),
(243, 'NESCAFÉ Café Classic Soluble Crème | Bote de cristal | Paquete de 200g de Café', 'Con NESCAFÉ Classic Crème Soluble disfrutarás una deliciosa y suave capa de crema en tu café con leche de cada mañana, sin renunciar al aroma único a café recién molido. café hecho a base de una mezcla de granos de arábica y Robusta, es un café ideal para preparar con leche. NESCAFÉ es un café de cultivo sostenible. En NESCAFÉ, llevamos más de 75 años asegurando la mejor calidad de café en cada taza.', '243.jpg', 5.40, 50, 5);
INSERT INTO `productos` (`id_producto`, `nombre_producto`, `descripcion`, `foto`, `coste`, `stock`, `categorias_productos_id_categoria`) VALUES
(244, 'NESCAFÉ Café Vitalissimo Soluble Natural | Bote de cristal | Paquete de 200g de ', 'NESCAFÉ Vitalissimo es un café soluble con Magnesio que te ayuda a reducir el cansancio y la fatiga con solo una taza al día, sin renunciar al mejor sabor y aroma a café recién molido de NESCAFÉ Classic. café hecho a base de una mezcla de granos de arábica y Robusta, es un café ideal para preparar con leche semidesnatada. NESCAFÉ es un café de cultivo sostenible. En NESCAFÉ, llevamos más de 75 años asegurando la mejor calidad de café en cada taza. ¡Siéntete más vital con NESCAFÉ Vitalissimo con Magnesio, que te ayuda a reducir el cansancio y la fatiga con tan solo una sola taza al día y sin renunciar al mejor sabor!', '244.jpg', 5.63, 50, 5),
(245, 'NESCAFÉ Café Classic Soluble Natural | Bote de cristal 250g', 'Con NESCAFÉ Classic Natural Soluble disfrutarás del aroma único a café recién molido, ya que hemos capturado los mejores aromas de nuestros granos de café después del tueste y la molienda. café hecho a base de una mezcla de granos de arábica y Robusta, es un café ideal para preparar con leche. NESCAFÉ es un café de cultivo sostenible. En NESCAFÉ, llevamos más de 75 años asegurando la mejor calidad de café en cada taza ¡Empieza tu día de la mejor manera con un delicioso desayuno con sabor a NESCAFÉ Classic', '245.jpg', 3.49, 50, 5),
(246, 'Nescafé - Café Cappuccino Soluble - 144 g', 'NESCAFÉ Cappuccino es un café soluble con un ligero sabor a chocolate, su receta está hecha con granos de café cuidadosamente seleccionados y leche de calidad para que disfrutes de una deliciosa capa de crema. El secreto es una mezcla de café arábica cultivado en las montañas que le confiere riqueza de aromas y café robusta que la da profundidad al sabor.', '246.jpg', 2.60, 50, 5),
(247, 'NESCAFÉ Café Cappuccino Descafeinado | Caja de sobres |Paquete de 10x25g de Café', 'NESCAFÉ Cappuccino descafeinado es un café soluble sin cafeína, su receta está hecha con granos de café cuidadosamente seleccionados y leche de calidad para que disfrutes de una deliciosa capa de crema. El secreto es una mezcla de café arábica cultivado en las montañas que le confiere riqueza de aromas y café robusta que la da profundidad al sabor.', '247.jpg', 2.39, 50, 5),
(248, 'Nescafé Gold Cappuccino Vainilla Latte - 310 g', 'Es imposible resistirse a su suave crema que se derrite en tu boca y desprender un aroma a café con sabor a vainilla… Un regalo para tu paladar. Tu cappuccino de siempre con un toque delicioso a vainilla. Es imposible resistirse a su suave crema que se derrite en tu boca.', '248.jpg', 3.50, 50, 5),
(249, 'Nescafé Gold Cappuccino Chocolate Blanco 8 x 15 gr - Total: 120 g', 'Nescafé Gold Chocolate Blanco está creado para tus momentos de placer. Nescafé Cappuccino Chocolate Blanco, con toda la cremosidad de siempre. Es imposible resistirse a su suave crema que se derrite en tu boca.', '249.jpg', 2.25, 50, 5),
(250, 'Nescafé Gold Cappuccino Chocolate - 310 g', 'Nescafé Mocha es un café soluble con un ligero sabor a chocolate. Su receta está hecha con granos de café cuidadosamente seleccionados y leche de calidad para que disfrutes de una deliciosa capa de crema. El secreto es una mezcla de café arábica cultivado en las montañas que le confiere riqueza de aromas y café robusta que la da profundidad al sabor. Tu Nescafé Cappuccino de siempre con un toque delicioso a chocolate. Es imposible resistirse a su suave crema que se derrite en tu boca gracias a nuestra leche de alta calidad.', '250.jpg', 3.88, 50, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_vendidos`
--

CREATE TABLE `productos_vendidos` (
  `id_producto_vendido` int(11) NOT NULL,
  `cantidad_producto` int(11) DEFAULT NULL,
  `productos_id_producto` int(11) NOT NULL,
  `ventas_id_venta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_usuario`
--

CREATE TABLE `tipo_usuario` (
  `id` int(11) NOT NULL,
  `tipo` varchar(45) CHARACTER SET utf8mb4 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_usuario`
--

INSERT INTO `tipo_usuario` (`id`, `tipo`) VALUES
(1, 'Administrador'),
(2, 'Usuario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `usuario` varchar(45) NOT NULL,
  `password` varchar(130) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(80) NOT NULL,
  `last_session` datetime DEFAULT NULL,
  `activacion` int(11) NOT NULL DEFAULT 0,
  `token` varchar(45) NOT NULL,
  `token_password` varchar(100) DEFAULT NULL,
  `password_request` int(11) DEFAULT 0,
  `id_tipo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `password`, `nombre`, `correo`, `last_session`, `activacion`, `token`, `token_password`, `password_request`, `id_tipo`) VALUES
(7, 'sha', '$2y$10$IjQjBYczyMbNdR8sKYPCu.nvMtaOfdp9dYGg2F1cfFBdF.CDa79lK', 'sha', 'shajhoana@gmail.com', '2020-02-18 00:55:32', 1, 'b3066440f2f12a5be34c0b09f7160586', '', 0, 2),
(9, 'Yolanda', '$2y$10$tqBF5s70RWT8eXiMBHE2KOWvVm1YnDhHFqlhyPmcqct6tI0zZl/TC', 'Yolanda', 'jhonel.080594@gmail.com', '2020-02-18 00:53:05', 1, 'c3ec799dc0f6fefed4c62fface2cc1f4', '', 0, 2),
(10, 'david', '$2y$10$4UMP.GWxGWdcPWdH.uoIFeBxlEPCjfCkula3pBlmE6wW3RcgC4Ht.', 'David', 'daviddddddddddddddddddddddd@hotmail.com', '2020-02-18 08:07:55', 1, 'e75e4d95a8e91af1919975fb88414622', '', 0, 2),
(11, 'Nicolas', '$2y$10$2eDkmIZTk9eH8t8IQw0uBupYUho67i7op58dpaWhhriHkY/L8Ef4a', 'Nicolas', 'niiiiicolas@gmail.com', '2020-02-18 08:37:10', 1, '16b492129ef83ffff9ab2b4bdbafb94c', '', 0, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` int(11) NOT NULL,
  `coste_total` float(6,2) DEFAULT NULL,
  `numero_productos` int(11) DEFAULT NULL,
  `usuarios_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias_productos`
--
ALTER TABLE `categorias_productos`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `fk_productos_categorias_productos1_idx` (`categorias_productos_id_categoria`);

--
-- Indices de la tabla `productos_vendidos`
--
ALTER TABLE `productos_vendidos`
  ADD PRIMARY KEY (`id_producto_vendido`),
  ADD KEY `fk_productos_vendidos_productos1_idx` (`productos_id_producto`),
  ADD KEY `fk_productos_vendidos_ventas1_idx` (`ventas_id_venta`);

--
-- Indices de la tabla `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `fk_ventas_usuarios1_idx` (`usuarios_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_productos_categorias_productos1` FOREIGN KEY (`categorias_productos_id_categoria`) REFERENCES `categorias_productos` (`id_categoria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `productos_vendidos`
--
ALTER TABLE `productos_vendidos`
  ADD CONSTRAINT `fk_productos_vendidos_productos1` FOREIGN KEY (`productos_id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_productos_vendidos_ventas1` FOREIGN KEY (`ventas_id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `fk_ventas_usuarios1` FOREIGN KEY (`usuarios_id`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
