USE test;

DROP TABLE IF EXISTS book;
CREATE TABLE `book`
(
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`title` VARCHAR(100) NOT NULL,
	`description` VARCHAR(255),
  `author` VARCHAR(100),
  `isbn` VARCHAR(20),
  `printYear` INT(4) NOT NULL,
	`readAlready` BIT(1) NOT NULL DEFAULT b'0',
	PRIMARY KEY (`id`))

ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

INSERT INTO `book` (`id`,`title`,`description`,`author`,`isbn`,`printYear`) VALUES
  (1,"Стационарные газотурбинные установки","Инженерный справочник","Л.В. Арсеньев","5-217-000420-7","1989"),
  (2,"Теплообмен излучением","Инженерный справочник","А.Г. Блох","5-283-000118-0","1991"),
  (3,"Ветроэнергетика","Учебник","А.Г. Блох","5-466-000311-2","1982"),
  (4,"Жаропрочные стали и сплавы","Инженерный справочник","С.Ю. Масленков","5-669-000018-9","1983"),
  (5,"Солнечные космические энергостанции","Учебник","В.А. Грихилес","5-621-000472-8","1983"),
  (6,"Источники и приемники излучения","Учебник","Г.Г. Ишанин","5-7325-0164-9","1991"),
  (7,"Использование энергии ветра","Учебник","Я.И. Шефтер","5-7621-2548-8","1983"),
  (8,"Проектирование и расчет станочных приспособлений","Инженерный справочник","В.А. Горохов","5-7621-0524-3","1983"),
  (9,"Накопители энергии","Учебник","Д.А. Бут","5-283-00609-3","1991"),
  (10,"Advanced bataries","Учебник","Robert A. Huggis","978-0-387-76423-5","2009"),
  (11,"Carbons for Electrochemical Energy Storage","Учебник","Robert A. Huggis","978-1-4200-5307-4","2009"),
  (12,"Comprehensive Treatise of Electrochemistry","Учебник","Brian E. Conway","978-1-4615-6689-2","2010"),
  (13,"Electrochemical Technologies for Energy Storage and Conversion","Учебник","Jurgen O. Besenhard","978-3-527-32869-7","2011"),
  (14,"Биотехнология топлива","Учебное пособие","А.В. Виноградова","978-5-398-00077-1","2008"),
  (15,"Advanced Biofuels and Bioproducts","Учебник","James Weifu Lee","978-1-4614-3347-7","2008"),
  (16,"Biogas Energy","Учебник","James Weifu Lee","978-1-4614-1039-3","2012"),
  (17,"Marine Sources of Energy","Учебник","Cappon","0-08-023897-1","1994"),
  (18,"Microturbines","Учебник","Claire Soares","978-0-7506-8469-9","2009"),
  (19,"Modelling and Controlling Hydropower Plant","Учебник","Ardul Munoz","978-1-4471-2290-6","2013"),
  (20,"THERMOELECTRIC POWER OF METALS","Учебник","I. Blatt, Frank J.","978-1-4613-4270-0","1976"),
  (21,"Advances in Energy Harvesting Methods","Учебник","Niell Elvin","978-1-4614-5704-6","2013"),
  (22,"Thermal Energy Harvesting for Application at MEMS Scale","Статья","Steven Percy","978-1-4614-9214-6","2014");