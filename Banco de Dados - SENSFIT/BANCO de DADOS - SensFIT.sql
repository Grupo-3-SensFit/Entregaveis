CREATE DATABASE SensorAcademia;
USE SensorAcademia;

-- CRIAÇÃO DA TABELA Cliente

CREATE TABLE Cliente (
idCliente INT AUTO_INCREMENT, 
Nome VARCHAR(50),
Telefone CHAR(11),
Email VARCHAR(50),

PRIMARY KEY PK_idCliente (idCliente) -- Fazendo a coluna idCliente se tornar uma PRIMARY KEY
);

INSERT INTO Cliente -- Coloco entre parentêses e por vírgula, todas as colunas menos a PrimaryKey da tabela, já que coloquei o AUTO_INCREMENT.
(Nome, Telefone, Email)
VALUES -- Inserindo dados para as colunas da tabela Cliente.
('Rafael', '1199872111', 'rafael.lee@gmail.com'),
('Kohatsu', '11947139850', 'gustavo.kohatsu@hotmail.com'),
('Giovana', '11978713311', 'giovana.beltrao@gmail.com'),
('Lucas', '11985188664', 'lucas.souza@sptech.com'),
('Bianca', '11933268514', 'bianca.souza@sptech.com');

SELECT * FROM Cliente;
-- =============================================================================
-- CRIAÇÃO DA TABELA Academia

CREATE TABLE Academia (
idAcademia INT AUTO_INCREMENT, -- PRIMARY KEY
Nome VARCHAR(80),
CEP CHAR(9),
Endereco VARCHAR(45),
Numero INT,
FK_idCliente INT NULL,

PRIMARY KEY PK_idAcademia (idAcademia),
FOREIGN KEY ForeignKey_idCliente (FK_idCliente) REFERENCES Cliente (idCliente)
);

INSERT INTO Academia
(Nome, CEP, Endereco, Numero, FK_idCliente)
VALUES
('Green Fit', '03142020', 'Avenida Conselheiro Carrão', 666, 1),
('Esperto Fit', '04543040', 'Rua Oscar Freire', 228, 2),
('Bu Fit', '06634080', 'Av. Mato Grosso', 3520, 3),
('Ledi Fit', '87830020', 'Avenida Paulista', 735, 4),
('Test Fit', '87833221', 'Avenida Dutra', 123, 5);

SELECT * FROM Academia;
-- =============================================================================
-- CRIAÇÃO DA TABELA Maquina

CREATE TABLE Maquina (
idMaquina 		INT AUTO_INCREMENT,
Nome 			VARCHAR(50),
tipo_maquina 	VARCHAR(50),
qtd_maquina 	INT,
dtVerificacao 	DATE,
FK_idAcademia 	INT NOT NULL, -- Foreign key da tabela Maquina, mas que também é a primary key da tabela Academia.

PRIMARY KEY PK_idMaquina (idMaquina), -- Fazendo a coluna idMaquina se tornar uma PRIMARY KEY
FOREIGN KEY ForeignKey_idAcademia (FK_idAcademia) REFERENCES Academia (idAcademia) -- Ao digitar "ForeignKey_id_Academia", estou dando um nome a chave estrangeira
																				   -- O que está em parentêses "(FK_idAcademia)", é a coluna da tabela DadosSensor, após isso...
																				   -- Usamos o "REFERENCES Academia (idAcademia)", para referenciar que "FK_idAcademia" é a chave estrangeira da coluna "idAcademia".
);

INSERT INTO Maquina -- Coloco entre parentêses e por vírgula, todas as colunas menos a PrimaryKey da tabela, já que coloquei o AUTO_INCREMENT.
(Nome, Tipo_Maquina, qtd_maquina, dtVerificacao, FK_idAcademia)
VALUES -- Inserindo os 5 valores para as 5 colunas que eu coloquei acima.
('Agachamento no smith'		  , 'Pernas', 5, '2018-12-23', 1),
('Leg press'				  , 'Pernas', 6, '1997-02-15', 2),
('Hack agachamento'			  , 'Pernas', 3, '2012-04-20', 3),
('Máquina agachamento livre'  , 'Pernas', 1, '2012-05-22', 4),
('Cadeira extensora'		  , 'Pernas', 4, '2012-06-20', 5),
('Cadeira flexora'			  , 'Pernas', 2, '2012-10-12', 1),
('Mesa flexora'				  , 'Pernas', 2, '2012-02-23', 2),
('Panturrilha'				  , 'Pernas', 3, '2004-07-24', 3),
('Cadeira de abdução'		  , 'Pernas', 2, '2021-04-20', 4),
('Cadeira de adução'		  , 'Pernas', 2, '2021-01-01', 5),
('Elevação pélvica na máquina', 'Pernas', 5, '2021-03-30', 1),
('Desenvolvimento na máquina' , 'Braços', 6, '2021-02-23', 2),
('Tríceps máquina'			  , 'Braços', 6, '2021-06-10', 3),
('Bíceps máquina'			  , 'Braços', 6, '2022-12-30', 4),
('Antebraço giratório'		  , 'Braços', 1, '2023-01-01', 5),
('Remada na máquina'		  , 'Tronco', 16, '2023-12-01', 1),
('Supino'					  , 'Tronco', 12, '2004-10-25', 2),
('Máquina abdominal'		  , 'Abdômen/Lombar', 8, '2002-04-20', 3),
('Cadeira romana'			  , 'Abdômen/Lombar', 3, '2017-10-22', 4),
('Polias'					  , 'Multiarticular', 10, '2019-12-16', 5),
('Esteiras'					  , 'Cardio', 14, '2009-09-12', 1),
('Escadas'				 	  , 'Cardio', 2, '2012-04-10', 2),
('Elíptico'					  , 'Cardio', 10, '2019-11-20', 3),
('Bike'						  , 'Cardio', 8, '2001-07-30', 4);

-- =============================================================================
/*
ALGUNS SELECTS ABAIXO, USANDO "CONCAT", "ALIAS", "ORDER BY", "LIKE", etc!!!
ALGUNS SELECTS ABAIXO, USANDO "CONCAT", "ALIAS", "ORDER BY", "LIKE", etc!!!
ALGUNS SELECTS ABAIXO, USANDO "CONCAT", "ALIAS", "ORDER BY", "LIKE", etc!!!

SELECT * FROM Maquina
ORDER BY Tipo_Maquina;

SELECT Nome,
	   Tipo_Maquina, 
       CONCAT(Nome, ' - ', Tipo_Maquina) AS 'Nome + Grupo muscular'
FROM Maquina
WHERE Tipo_Maquina LIKE 'Braços';

SELECT Nome,
	   Tipo_Maquina, 
       CONCAT(Nome, ' - ', Tipo_Maquina) AS 'Nome + Grupo muscular'
FROM Maquina
WHERE Tipo_Maquina LIKE '%Lombar%';

SELECT Nome,
	   Tipo_Maquina, 
       CONCAT(Nome, ' - ', Tipo_Maquina) AS 'Nome + Grupo muscular'
FROM Maquina
WHERE Tipo_Maquina LIKE 'Cardio';

SELECT Nome,
	   Tipo_Maquina, 
       CONCAT(Nome, ' - ', Tipo_Maquina) AS 'Nome + Grupo muscular'
FROM Maquina
WHERE Tipo_Maquina LIKE 'Multiarticular';

SELECT Nome,
	   Tipo_Maquina, 
       CONCAT(Nome, ' - ', Tipo_Maquina) AS 'Nome + Grupo muscular'
FROM Maquina
WHERE Tipo_Maquina LIKE 'Pernas';

SELECT Nome,
	   Tipo_Maquina, 
       CONCAT(Nome, ' - ', Tipo_Maquina) AS 'Nome + Grupo muscular'
FROM Maquina
WHERE Tipo_Maquina LIKE 'Tronco';

SELECT * FROM Maquina;
*/
-- =============================================================================
-- CRIAÇÃO DA TABELA DadosSensor

CREATE TABLE DadosSensor (
idDadosSensor 		INT AUTO_INCREMENT, -- os IDs das tabelas, na maioria das vezes são as Primary Key...
Tipo				VARCHAR(20),
dtVerificacao 		DATE, 
qtdUsos 			INT,
horasUtilizadasDia 	INT,
Atividade 				VARCHAR(7) -- DataType da coluna deve ser VARCHAR(7), já que entre as 2 palavras, a maior é "Inativa" e contém 7 caracteres e não necessita de mais caracteres.
						NOT NULL DEFAULT 'Inativo'
                        CHECK (Atividade IN ('Ativo', 'Inativo')), -- Restrinjo para que coluna Atividade aceite valores que estão dentro dos parentêses, nesse caso 'Ativo' ou 'Inativo'.
FK_idMaquina 		INT NOT NULL,

PRIMARY KEY PK_idDadosSensor (idDadosSensor), -- Fazendo a coluna idDadosSensor se tornar uma PRIMARY KEY
                                                                                     
FOREIGN KEY ForeignKey_id_Maquina (FK_idMaquina) REFERENCES Maquina (idMaquina) -- Ao digitar "ForeignKey_id_Maquina", estou dando um nome a chave estrangeira
																				-- O que está em parentêses "(FK_idMaquina)", é a coluna da tabela DadosSensor, após isso...
																				-- Usamos o "REFERENCES Maquina (idMaquina)", para referenciar que "FK_idMaquina" é a chave estrangeira da coluna "idMaquina".
);

INSERT INTO DadosSensor -- Coloco entre parentêses e por vírgula, todas as colunas menos a PrimaryKey da tabela, já que coloquei o AUTO_INCREMENT.
(Tipo, dtVerificacao, qtdUsos, horasUtilizadasDia, Atividade, FK_idMaquina)
VALUES -- Inserindo os 6 valores para as 6 colunas que eu coloquei acima.
('Proximidade', '2000-02-20', 30, 2, 'Ativo', 1),
('Proximidade', '2012-05-22', 31, 3, 'Ativo', 2),
('Proximidade', '2012-06-20', 32, 4, 'Ativo', 3),
('Proximidade', '2012-10-12', 33, 5, 'Ativo', 4),
('Proximidade', '2021-03-30', 34, 6, 'Ativo', 5),
('Proximidade', '2021-02-23', 35, 7, 'Ativo', 6),
('Proximidade', '2021-06-10', 36, 8, 'Ativo', 7),
('Proximidade', '2021-06-11', 37, 9, 'Ativo', 8),
('Proximidade', '2021-06-12', 38, 10, 'Ativo', 9),
('Proximidade', '2021-06-13', 39, 11, 'Ativo', 10),
('Proximidade', '2021-06-14', 40, 12, 'Ativo', 11),
('Proximidade', '2021-06-15', 41, 13, 'Ativo', 12),
('Proximidade', '2021-06-16', 42, 14, 'Inativo', 13),
('Proximidade', '2021-06-17', 43, 15, 'Inativo', 14),
('Proximidade', '2021-06-18', 44, 16, 'Inativo', 15),
('Proximidade', '2021-06-19', 45, 17, 'Inativo', 16),
('Proximidade', '2021-06-20', 46, 18, 'Inativo', 17),
('Proximidade', '2021-06-21', 47, 19, 'Inativo', 18),
('Proximidade', '2021-06-22', 48, 20, 'Inativo', 19),
('Proximidade', '2021-06-23', 49, 21, 'Inativo', 20),
('Proximidade', '2021-06-24', 50, 22, 'Inativo', 21),
('Proximidade', '2021-06-25', 51, 23, 'Inativo', 22),
('Proximidade', '2021-06-26', 52, 24, 'Inativo', 23),
('Proximidade', '2021-06-27', 53, 25, 'Inativo', 24);

SELECT * FROM DadosSensor;

DROP TABLE Academia; -- Dropar a tabela Academia caso precise.
DROP TABLE Cliente; -- Dropar a tabela Usuario caso precise.
DROP TABLE Maquina; -- Dropar a tabela Maquina caso precise.
DROP TABLE DadosSensor; -- Dropar a tabela DadosSensor caso precise.

SELECT * FROM Academia; -- Verificar se os campos da tabela Academia existem.
SELECT * FROM Cliente; -- Verificar se os campos da tabela Usuario existem, e se a FK da tabela Academia existe.
SELECT * FROM Maquina; -- Verificar se os campos da tabela Maquina existem, e se a FK da tabela Academia existe.
SELECT * FROM DadosSensor; -- Verificar se os campos da tabela DadosSensor existem, e se as Foreign Keys das tabelas Academia e Maquina existem.

-- DROP DATABASE SensorAcademia;

/*
SELECT DE TODAS AS TABELAS

SELECT *
FROM Academia AS Acad
INNER JOIN Cliente AS Cli
ON Cli.idCliente = Acad.FK_idCliente

INNER JOIN Maquina AS Maq
ON Acad.idAcademia = Maq.FK_idAcademia

INNER JOIN DadosSensor AS Sensor
ON Maq.idMaquina = Sensor.FK_idMaquina;
*/