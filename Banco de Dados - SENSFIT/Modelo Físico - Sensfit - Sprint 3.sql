create database sensfit;
use Sensfit;

-- drop database sensfit;

-- criando o tabela de infromações de usuário e login
create table usuario(
idUsuario int auto_increment,
nome varchar(45) not null,
CPF char(11) not null,
email varchar(45) not null,
senha varchar(10) not null,
primary key pkUsuario (idUsuario));


-- cadastro de academias 
create table academia(
idAcademia int auto_increment,
nome varchar(45) not null,
CNPJ varchar(14) not null unique,
CEP varchar(8) not null,
fkUsuario int,
constraint fk_usuario foreign key (fkUsuario) references usuario (idUsuario),
primary key pkAcademia (idAcademia));


-- cadastro de equipamentos 
create table equipamento(
idEquipamento int auto_increment,
dataManutencao date, -- data da ultima manutenção do equipamento
tipo varchar(45) not null, -- tipo/nome de máquina
fkAcademia int,
constraint fkEquipamentoAcademia foreign key (fkAcademia) references academia(idAcademia),
primary key pkEquipamento (idEquipamento));


-- cadastro do sensor 
create table sensor(
idSensor int auto_increment,
fkEquipamento int,
constraint fkSensorEquipamento foreign key (fkEquipamento) references equipamento (idEquipamento),
primary key pkSensor (idSensor));

-- tabela de captura de leitura
create table leitura(
idLeitura int auto_increment,
dataLeitura date,
hora time, -- define este campo como a data e hora atual 
atividade int,
fkSensor int default(1),
constraint fkLeituraSensor foreign key (fkSensor) references sensor(idSensor),
primary key pkLeitura(idLeitura,fkSensor));


-- inserção de dados usuarios
insert into usuario(nome,CPF,email,senha)
values('Junior','51081126884','junior@gmail.com','Senha1231');

-- inserção de dados academia
insert into academia(nome,CNPJ,CEP, fkUsuario)
values('SmartFit','18273645263718','01928374', 1);


-- inserção dos dados dos equipamentos
insert into equipamento(dataManutencao,tipo,fkAcademia)
values('2024-03-10','Esteira',1),
('2023-09-23','Bicicleta',1),
('2024-12-27','Cadeira flexora',1),
('2024-10-12','Leg press',1),
('2023-12-22','Remo',1);


-- INSERÇÃO DE DADOS NO SENSOR
insert into Sensor(fkEquipamento)
values(1),
(2),
(3),
(4),
(5);


select*from leitura;
truncate leitura;

-- QUANTOS SEGUNDOS DE USO
SELECT fkSensor,
    TIMESTAMPDIFF(SECOND, MIN(hora), MAX(hora)) AS total_segundos_atividade_1
FROM 
    leitura
WHERE 
    atividade = 1
GROUP BY fkSensor;


-- QUANTOS SEGUNDOS NÃO UTILIZADOS
/*SELECT 
    DATE(dataHora) AS data,
    fkSensor,
    COUNT(*) AS total_ocorrencias
FROM 
    leitura
WHERE 
    atividade = 0  -- Use a data desejada aqui
GROUP BY 
    DATE(dataHora),
    fkSensor
ORDER BY 
    total_ocorrencias DESC;
*/
   
   
-- QUANTIDADE DE HORAS 
   SELECT 
    dataLeitura AS data,
    fkSensor,
    COUNT(*) / 3600.0 AS total_horas_UTILIZADA
FROM 
    leitura
GROUP BY 
    dataLeitura,
    fkSensor
ORDER BY 
    total_horas_UTILIZADA DESC;


-- SELECIONA QUAIS EQUIPAMENTOS FICARAM UTILIZADOS ACIMA DE 2 SEGUNDOS
SELECT 
    dataLeitura AS data,
    fkSensor,
    COUNT(*) AS total_ocorrencias
FROM 
    leitura
WHERE 
    atividade = 1  -- Use a data desejada aqui
GROUP BY 
    dataLeitura,
    fkSensor
HAVING 
    total_ocorrencias > 2
ORDER BY 
    total_ocorrencias DESC;
    
    
-- TOTAL DE EQUIPAMENTOS UTILIZADO ACIMA DE 2 SEGUNDOS NA ULTIMA SEMANA
    SELECT 
    dataLeitura AS data,
    fkSensor,
    COUNT(*) AS total_ocorrencias
FROM 
    leitura
WHERE 
    dataLeitura BETWEEN DATE_SUB(NOW(), INTERVAL 1 WEEK) AND NOW() -- Dados da última semana
GROUP BY 
    dataLeitura,
    fkSensor
ORDER BY 
    total_ocorrencias DESC;
    