CREATE DATABASE IF NOT EXISTS `Autores`;

USE `Autores`;

DROP TABLE IF EXISTS `Autor`;
DROP TABLE IF EXISTS `Libro`;
DROP TABLE IF EXISTS `Escribe`;

CREATE TABLE `Autor`( 	
	`id_autor`	INT				NOT NULL	AUTO_INCREMENT,
	`nombre`	VARCHAR(20)		NOT NULL,
	`apellido`	VARCHAR(20)		NOT NULL,
	`nacionalidad`	VARCHAR(20)		NOT NULL,
	`residencia`	VARCHAR(20)		NOT NULL,
  PRIMARY KEY (`id_autor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Libro`( 	
	`isbn`		INT				NOT NULL	UNIQUE,
	`titulo`	VARCHAR(20)		NOT NULL,
	`editorial`	VARCHAR(20)		NOT NULL,
	`precio`	FLOAT			NOT NULL,
  PRIMARY KEY (`isbn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Escribe`( 	
	`id_autor`	INT			NOT NULL	REFERENCES `Autor`(`id_autor`) ON DELETE CASCADE ON UPDATE CASCADE,
	`isbn`		INT			NOT NULL	REFERENCES `Libro`(`isbn`)     ON DELETE CASCADE ON UPDATE CASCADE,
	`año`		DATE		NOT NULL,
  PRIMARY KEY (`id_autor`, `isbn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE INDEX indice_autor_apellido ON `Autor`(`apellido`);
CREATE INDEX indice_libro_titulo ON `Libro`(`titulo`);

INSERT INTO `Libro` VALUES(1, '100 años de soledad', 'Minotauro', 150.75);
INSERT INTO `Libro` VALUES(3, 'Harry Potter 1', 'Salamandra', 700.75);

INSERT INTO `Autor` VALUES(NULL, 'Gabriel', 'García Marquez', 'Colombia', 'Bogotá');
INSERT INTO `Autor` VALUES(NULL, 'JK', 'Rowling', 'Gales', 'Londres');
INSERT INTO `Autor` VALUES(NULL, 'Abelardo', 'Castillo', 'Argentina', 'Rosario');

INSERT INTO `Escribe` VALUES(1, 1, CURDATE());
INSERT INTO `Escribe` VALUES(2, 3, CURDATE());

UPDATE `Autor` SET `residencia` = 'Buenos Aires' WHERE nombre='Abelardo' AND apellido='Castillo';

UPDATE `Libro` SET `precio` = 1.10*precio WHERE editorial='UNR';

SELECT id_autor FROM `Autor` WHERE nacionalidad<>'Argentina';

UPDATE `Libro` SET `precio` = CASE 
	WHEN precio <= 200 THEN 1.20 * precio
	ELSE 1.10 * precio
   END
 WHERE isbn in (SELECT `Escribe`.isbn FROM `Autor`, `Escribe` WHERE nacionalidad<>'Argentina');


DELETE FROM Libro WHERE isbn in (SELECT isbn FROM Escribe where YEAR(`año`) = 1998);



