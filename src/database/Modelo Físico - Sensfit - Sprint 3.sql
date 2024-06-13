create database sensfit;
use sensfit;

-- drop database sensfit;

-- criando o tabela de infromações de usuário e login
create table usuario(
idUsuario int auto_increment,
nome varchar(45) not null,
CPF char(11) not null,
email varchar(45) not null,
senha varchar(10) not null,

constraint ukUsuarioEmail unique key (email),
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
insert into sensor(fkEquipamento)
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
select equip.idEquipamento,
		equip.tipo,
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

-- seleciona  a quantidade total de equipamentos do mesmo tipo e a quantidade que foi utilizada no mesmo horário em um determinado dia
select distinct 
equipamento.tipo,
	hour(hora) as hora,
    count(equipamento.tipo) as qtd,
    (select count(idSensor)
	from sensor 
	inner join equipamento on fkEquipamento = idEquipamento
	where equipamento.tipo = 'Esteira') as qtdTotal
from sensor
left join leitura on fkSensor = idSensor
left join equipamento on fkEquipamento = idEquipamento
where equipamento.tipo = 'Esteira' and fkAcademia = 1
and dataLeitura = '2024-06-08'
group by hour(hora), equipamento.tipo
order by hora;

-- seleciona o tipo de equipamento que possuem leituras de uma determinada academia
select distinct equip.tipo
    from equipamento as equip 
    inner join sensor as sens on sens.fkEquipamento = equip.idEquipamento
    inner join leitura as lei on lei.fkSensor = sens.idSensor
    where fkAcademia = 1;

-- seleciona o uso dos equipamentos nos últimos 7 dias separados por tipo de equipamento
select equip.tipo,
		sum(lei.atividade)as soma
from leitura as lei
inner join sensor as sens on lei.fkSensor = sens.idSensor
inner join equipamento as equip on sens.fkEquipamento = equip.idEquipamento
where fkAcademia = 1  and  dataLeitura >= DATE_ADD(CURDATE(),INTERVAL -7 DAY)
group by equip.tipo
order by soma desc;

-- seleciona a quantidade de equipamentos em mais usados
select count(*) as quantidade
            from (
                select e.idEquipamento
                from equipamento e
                join sensor s on e.idEquipamento = s.fkEquipamento
                join leitura l on s.idSensor = l.fkSensor
                where fkAcademia = 1
                group by e.idEquipamento
                having sum(l.atividade) > 10
            ) as subquery;
    
    
-- seleciona os quepiamentos mias usados
select e.idEquipamento, e.tipo, sum(l.atividade)as soma
from equipamento e
join sensor s on e.idEquipamento = s.fkEquipamento
join leitura l on s.idSensor = l.fkSensor
where fkAcademia = 1 and  dataLeitura >= DATE_ADD(CURDATE(),INTERVAL -7 DAY)
group by e.idEquipamento
having sum(l.atividade) > 10
order by soma desc;




select count(*) as quantidade
            from (
                select distinct e.idEquipamento
                from equipamento e
                join sensor s on e.idEquipamento = s.fkEquipamento
                left join leitura l on s.idSensor = l.fkSensor
                group by e.idEquipamento
                having sum(l.atividade) <= 5 or sum(l.atividade) = null
            ) as subquery;
                
                
                
                select count(*) as quantidade
            from (
                select distinct e.idEquipamento, ifnull(sum(l.atividade),0) as soma
                from equipamento e
                join sensor s on e.idEquipamento = s.fkEquipamento
                left join leitura l on s.idSensor = l.fkSensor
                group by e.idEquipamento      
            ) as subquery where soma <= 5;