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
    

-- seleciona a atividade dos 3 primeiros sensores que excedem 6 desde a ultima manutenção do equipamento
select equip.tipo,
sum(lei.atividade) as soma
from leitura as lei
inner join sensor as sens on lei.fkSensor = sens.idSensor
inner join equipamento as equip on sens.fkEquipamento = equip.idEquipamento
where equip.dataManutencao <= lei.dataLeitura and fkAcademia = 1 
group by fkSensor
having soma >= 6 
order by soma desc
limit 3;


-- inserção de dados de leitura para teste
insert into leitura(dataLeitura, hora,atividade,fkSensor)
values('2024-06-07','14:15:11',1,1),
('2024-06-07','14:15:12',1,1),
('2024-06-07','14:15:13',1,1),
('2024-06-07','14:15:14',1,1),
('2024-06-07','14:15:15',1,1),
('2024-06-07','14:15:16',1,1),
('2024-06-07','14:15:17',1,1),
('2024-06-07','14:15:18',1,1),
('2014-02-10','15:23:42',1,1),
('2014-02-10','08:12:58',1,1);

insert into leitura(dataLeitura, hora,atividade,fkSensor)
values('2024-02-10',now(),1,2),
('2024-06-07','14:15:11',1,2),
('2024-06-07','14:15:12',1,2),
('2024-06-07','14:15:13',1,2),
('2024-06-07','14:15:14',1,2),
('2024-06-07','14:15:15',1,2),
('2024-06-07','14:15:16',1,2),
('2024-06-07','14:15:17',1,2),
('2024-06-07','14:15:18',1,2),
('2014-02-10','15:23:42',1,2),
('2014-02-10','08:12:58',1,2);

insert into leitura(dataLeitura, hora,atividade,fkSensor)
values('2025-02-10',now(),1,3),
('2025-06-07','14:15:11',1,3),
('2025-06-07','14:15:12',1,3),
('2025-06-07','14:15:13',1,3),
('2025-06-07','14:15:14',1,3),
('2025-06-07','14:15:15',1,3),
('2025-06-07','14:15:16',1,3),
('2015-02-10','15:23:42',1,3),
('2015-02-10','08:12:58',1,3);

select *from equipamento;
select *from leitura;
select*from sensor;