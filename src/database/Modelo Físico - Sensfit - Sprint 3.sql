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
('2024-01-27','Cadeira flexora',1),
('2024-10-12','Leg press',1),
('2023-12-22','Remo',1);


-- INSERÇÃO DE DADOS NO SENSOR
insert into Sensor(fkEquipamento)
values(1),
(2),
(3),
(4),
(5);


select*from usuario;
select*from academia;
select*from equipamento;
select*from leitura;
truncate leitura;

/*SELECT * 
FROM leitura 
WHERE atividade = 1;*/


-- QUANTOS SEGUNDOS DE USO
SELECT fkSensor,
    TIMESTAMPDIFF(SECOND, MIN(dataHora), MAX(dataHora)) AS total_segundos_atividade_1
FROM 
    leitura
WHERE 
    atividade = 1
GROUP BY fkSensor;


-- QUANTOS SEGUNDOS NÃO UTILIZADOS
SELECT 
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
    
   
   
-- QUANTIDADE DE HORAS 
   SELECT 
    DATE(dataHora) AS data,
    fkSensor,
    COUNT(*) / 3600.0 AS total_horas_UTILIZADA
FROM 
    leitura
WHERE 
    atividade = 0  
GROUP BY 
    DATE(dataHora),
    fkSensor
ORDER BY 
    total_horas_UTILIZADA DESC;

-- SELECIONA QUAIS EQUIPAMENTOS FICARAM UTILIZADOS ACIMA DE 2 SEGUNDOS
SELECT 
    DATE(dataHora) AS data,
    fkSensor,
    COUNT(*) AS total_ocorrencias
FROM 
    leitura
WHERE 
    atividade = 1  -- Use a data desejada aqui
GROUP BY 
    DATE(dataHora),
    fkSensor
HAVING 
    total_ocorrencias > 2
ORDER BY 
    total_ocorrencias DESC;
    
    
-- TOTAL DE EQUIPAMENTOS UTILIZADO ACIMA DE 2 SEGUNDOS NA ULTIMA SEMANA
    SELECT 
    DATE(dataHora) AS data,
    fkSensor,
    COUNT(*) AS total_ocorrencias
FROM 
    leitura
WHERE 
    atividade = 0
    AND DATE(dataHora) BETWEEN DATE_SUB(NOW(), INTERVAL 1 WEEK) AND NOW() -- Dados da última semana
GROUP BY 
    DATE(dataHora),
    fkSensor
ORDER BY 
    total_ocorrencias DESC;


-- seleciona a atividade dos 3 primeiros sensores mais proximos da manutenção (conta a atividade a partir da data da ultima manutenção)
select equip.tipo,
		sum(lei.atividade) as soma
from leitura as lei
inner join sensor as sens on lei.fkSensor = sens.idSensor
inner join equipamento as equip on sens.fkEquipamento = equip.idEquipamento
where equip.dataManutencao <= lei.dataLeitura and fkAcademia = 1 
group by fkSensor
order by soma desc
limit 3;


-- seleciona a data de leitura dos últimos 7 dias
select distinct 
    DATE_FORMAT(dataLeitura,'%Y-%m-%d') as dataLeitura,
    DATE_FORMAT(dataLeitura,'%d/%m/%Y') as data
from leitura
inner join sensor on fkSensor = idSensor
inner join equipamento on fkEquipamento = idEquipamento
where dataLeitura >= DATE_ADD(CURDATE(),INTERVAL -7 DAY)
and fkAcademia = 1
order by dataLeitura desc;


-- seleciona a quantidade de atividades por horario inteiro de um determinado dia e equipamento
select hour(hora) as hora,
    sum(atividade) as pico
    from leitura
    where fkSensor = 1
    and dataLeitura = '2024-06-08'
    group by hour(hora)
    order by hora;


-- seleciona os equipamentos de uma determinada academia
select equip.idEquipamento,
		equip.tipo
from equipamento as equip 
inner join sensor as sens on sens.fkEquipamento = equip.idEquipamento
where fkAcademia = 1;