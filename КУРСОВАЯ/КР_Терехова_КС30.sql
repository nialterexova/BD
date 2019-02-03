-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Дек 23 2018 г., 22:11
-- Версия сервера: 5.7.23
-- Версия PHP: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `auto`
--
CREATE DATABASE IF NOT EXISTS `auto` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `auto`;

DELIMITER $$
--
-- Процедуры
--
DROP PROCEDURE IF EXISTS `Client_Info`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Client_Info` (IN `n` BIGINT(10))  BEGIN
SELECT clients.name_cl, cars.brand, cars.model,orders.summa, orders.dataOpen, orders.dataClose, orders.statusClosed, clients.phone, clients.address 
FROM clients, cars, orders
WHERE clients.passport=orders.client AND cars.id=orders.auto AND clients.passport = n;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `cars`
--

DROP TABLE IF EXISTS `cars`;
CREATE TABLE IF NOT EXISTS `cars` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company` int(10) UNSIGNED NOT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `power` int(5) DEFAULT NULL,
  `year_out` int(4) DEFAULT NULL,
  `manufacturer` varchar(100) DEFAULT NULL,
  `price` float UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `cars`
--

INSERT INTO `cars` (`id`, `company`, `brand`, `model`, `power`, `year_out`, `manufacturer`, `price`) VALUES
(1, 1, 'BMW', 'X7', 280, 2016, 'BMW official', 15000),
(2, 1, 'Лада', 'Калина', 100, 2007, 'Лада', 1500),
(3, 1, 'Лимузин', 'Золотой в блестках', 200, 2018, 'Королевская гавань', 1000000),
(4, 2, 'Сани', 'NewYear', 800, 1258, 'Cristmas New', 65000),
(5, 3, 'Лошадь', 'Плотва', 1, 2010, 'Мама и Папа', 500),
(6, 1, 'Chevrolet Camaro', 'Bibi', 500, 2013, 'Кибертрон', 34000),
(7, 1, 'Audi', 'A8', 300, 2016, 'Audi official', 14000);

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `cars_all`
-- (См. Ниже фактическое представление)
--
DROP VIEW IF EXISTS `cars_all`;
CREATE TABLE IF NOT EXISTS `cars_all` (
`id` int(10) unsigned
,`name_com` varchar(100)
,`brand` varchar(100)
,`model` varchar(100)
,`power` int(5)
,`year_out` int(4)
,`manufacturer` varchar(100)
,`price` float unsigned
,`num_place` int(10) unsigned
,`total` int(10) unsigned
,`issued_now` bigint(11) unsigned
);

-- --------------------------------------------------------

--
-- Структура таблицы `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `name_cl` varchar(100) NOT NULL,
  `passport` bigint(10) NOT NULL,
  `address` varchar(100) NOT NULL,
  `phone` varchar(10) NOT NULL,
  PRIMARY KEY (`passport`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `clients`
--

INSERT INTO `clients` (`name_cl`, `passport`, `address`, `phone`) VALUES
('Иванов Вася', 4516928454, 'Москва, ул Панфилова, 12, 122', '9256139767'),
('Киркоров', 2348693576, 'Москва, Звездный переулок, 69, 696', '9666666666'),
('Дед Мороз', 1234567890, 'Полюс, город Великий Устюг, дом Деда Мороза', '9123456789'),
('Геральд Ведьмак', 4565438864, 'Долина Каэр Морхен, замок', '9252050505'),
('Сэм Уитвики', 5657465536, 'Tranquillity, 76', '9257657687'),
('Пол Уокер', 4564767876, 'Калифорния, 869', '9547658791');

-- --------------------------------------------------------

--
-- Структура таблицы `companies`
--

DROP TABLE IF EXISTS `companies`;
CREATE TABLE IF NOT EXISTS `companies` (
  `num_com` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name_com` varchar(100) NOT NULL,
  PRIMARY KEY (`num_com`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `companies`
--

INSERT INTO `companies` (`num_com`, `name_com`) VALUES
(1, 'Автоцентр на перекрестке дорог'),
(2, 'Подделки из палок'),
(3, 'Конюшня \"Три коня и Вася\"');

-- --------------------------------------------------------

--
-- Структура таблицы `garage`
--

DROP TABLE IF EXISTS `garage`;
CREATE TABLE IF NOT EXISTS `garage` (
  `num_place` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id` int(10) UNSIGNED NOT NULL,
  `total` int(10) UNSIGNED DEFAULT NULL,
  `ingarage` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`num_place`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `garage`
--

INSERT INTO `garage` (`num_place`, `id`, `total`, `ingarage`) VALUES
(1, 1, 10, 9),
(2, 7, 10, 10),
(3, 2, 30, 30),
(4, 6, 1, 1),
(5, 3, 3, 2),
(6, 4, 2, 2),
(7, 5, 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `numOrder` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `client` bigint(10) UNSIGNED NOT NULL,
  `auto` int(10) UNSIGNED NOT NULL,
  `dataOpen` date NOT NULL,
  `dataClose` date NOT NULL,
  `statusClosed` bit(1) DEFAULT b'0',
  `summa` float DEFAULT NULL,
  PRIMARY KEY (`numOrder`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`numOrder`, `client`, `auto`, `dataOpen`, `dataClose`, `statusClosed`, `summa`) VALUES
(1, 1234567890, 4, '2018-12-31', '2019-01-02', b'1', 130000),
(3, 4565438864, 5, '2018-05-01', '2018-05-11', b'1', 5000),
(4, 4516928454, 2, '2018-12-04', '2018-12-06', b'1', 3000),
(5, 4564767876, 7, '2018-12-03', '2018-12-12', b'1', 250555),
(7, 4564767876, 1, '2018-12-10', '2018-12-18', b'1', 250555),
(8, 4564767876, 1, '2018-12-10', '2018-12-20', b'0', 150000),
(9, 2348693576, 3, '2018-12-18', '2018-12-24', b'0', 6000000),
(22, 5657465536, 6, '2018-12-11', '2018-12-22', b'1', 374000);

--
-- Триггеры `orders`
--
DROP TRIGGER IF EXISTS `After_Insert_Order`;
DELIMITER $$
CREATE TRIGGER `After_Insert_Order` AFTER INSERT ON `orders` FOR EACH ROW IF NEW.statusClosed=0 THEN 
UPDATE garage 
  SET ingarage=ingarage-1
  WHERE garage.id = NEW.auto;
END if
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `After_Update_Order`;
DELIMITER $$
CREATE TRIGGER `After_Update_Order` AFTER UPDATE ON `orders` FOR EACH ROW IF NEW.statusClosed=0 THEN 
UPDATE garage 
SET ingarage=ingarage-1
WHERE garage.id = NEW.auto;
ELSE
UPDATE garage 
SET ingarage=ingarage+1
WHERE garage.id = NEW.auto;
END if
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `Before_Delete_Order`;
DELIMITER $$
CREATE TRIGGER `Before_Delete_Order` BEFORE DELETE ON `orders` FOR EACH ROW IF OLD.statusClosed=0 THEN 
UPDATE garage 
SET ingarage=ingarage+1
WHERE garage.id = OLD.auto;
END if
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `Before_Insert_Order`;
DELIMITER $$
CREATE TRIGGER `Before_Insert_Order` BEFORE INSERT ON `orders` FOR EACH ROW IF NEW.summa IS NULL THEN
SET NEW.summa = -1 * DATEDIFF(NEW.dataOpen,NEW.dataClose)*(SELECT price FROM cars WHERE NEW.auto=cars.id);
END if
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `orders_all`
-- (См. Ниже фактическое представление)
--
DROP VIEW IF EXISTS `orders_all`;
CREATE TABLE IF NOT EXISTS `orders_all` (
`numOrder` int(10) unsigned
,`name_cl` varchar(100)
,`brand` varchar(100)
,`model` varchar(100)
,`dataOpen` date
,`dataClose` date
,`statusClosed` bit(1)
,`summa` float
);

-- --------------------------------------------------------

--
-- Структура для представления `cars_all`
--
DROP TABLE IF EXISTS `cars_all`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cars_all`  AS  select `cars`.`id` AS `id`,`companies`.`name_com` AS `name_com`,`cars`.`brand` AS `brand`,`cars`.`model` AS `model`,`cars`.`power` AS `power`,`cars`.`year_out` AS `year_out`,`cars`.`manufacturer` AS `manufacturer`,`cars`.`price` AS `price`,`garage`.`num_place` AS `num_place`,`garage`.`total` AS `total`,(`garage`.`total` - `garage`.`ingarage`) AS `issued_now` from ((`cars` join `companies`) join `garage`) where ((`garage`.`id` = `cars`.`id`) and (`companies`.`num_com` = `cars`.`company`)) ;

-- --------------------------------------------------------

--
-- Структура для представления `orders_all`
--
DROP TABLE IF EXISTS `orders_all`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `orders_all`  AS  select `orders`.`numOrder` AS `numOrder`,`clients`.`name_cl` AS `name_cl`,`cars`.`brand` AS `brand`,`cars`.`model` AS `model`,`orders`.`dataOpen` AS `dataOpen`,`orders`.`dataClose` AS `dataClose`,`orders`.`statusClosed` AS `statusClosed`,`orders`.`summa` AS `summa` from ((`orders` join `clients`) join `cars`) where ((`orders`.`client` = `clients`.`passport`) and (`orders`.`auto` = `cars`.`id`)) ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
