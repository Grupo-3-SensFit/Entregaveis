create database Sensfit;
use Sensfit;


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
matriz int,
fkUsuario int,
constraint matrizAcademia foreign key (matriz) references academia (idAcademia),
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
dataHora timestamp null default current_timestamp, -- define este campo como a data e hora atual 
atividade int,
fkSensor int,
constraint fkLeituraSensor foreign key (fkSensor) references sensor(idSensor),
primary key pkLeitura(idLeitura,fkSensor));



-- inserção de dados usuarios
insert into usuario(nome,CPF,email,senha)
values('Junior','51081126884','junior@gmail.com','Senha1231'),
('Fernanda','74209754005', 'fernanda@gmail.com','Senha1232'),
('Agenor','01717251072','agenor@gmail.com','Senha1233'),
('Brenda','30489698026','brenda@gmail.com','Senha1234');

-- inserção de dados academia
insert into academia(nome,CNPJ,CEP, Matriz, fkUsuario)
values('SmartFit','18273645263718','01928374', null, 1),
('BlueFit','01928374651243','01926381', null, 2),
('Panobianco','91827361926371','10273612', null, 3);

insert into academia(nome,CNPJ,CEP, Matriz, fkUsuario)
values('SmartFit','14785236987456','07179065', 1, 4);


-- inserção dos dados dos equipamentos
insert into equipamento(dataManutencao,tipo,fkAcademia)
values('2024-03-10','Esteira',1),
('2023-09-23','Bicicleta',1),
('2024-12-27','Cadeira flexora',1),
('2024-10-12','Leg press',1),
('2023-12-22','Remo',1),

('2024-03-10','Esteira',2),
('2023-09-23','Bicicleta',2),
('2024-12-27','Cadeira flexora',2),
('2024-10-12','Leg press',2),
('2023-12-22','Remo',2),

('2024-03-10','Esteira',3),
('2023-09-23','Bicicleta',3),
('2024-12-27','Cadeira flexora',3),
('2024-10-12','Leg press',3),
('2023-12-22','Remo',3),

('2024-03-10','Esteira',4),
('2023-09-23','Bicicleta',4),
('2024-12-27','Cadeira flexora',4),
('2024-10-12','Leg press',4),
('2023-12-22','Remo',4);


-- INSERÇÃO DE DADOS NO SENSOR
insert into Sensor(fkEquipamento)
values(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20);

-- inserção dos valores da leitura
insert into leitura(atividade,fkSensor)
values(1,1),
(1,2),
(0,3),
(1,4),
(0,5),
(1,6),
(0,7),
(0,8),
(0,9),
(1,10),
(0,11),
(0,12),
(1,13),
(1,14),
(1,15),
(1,16),
(0,17),
(0,18),
(1,19),
(1,20);



-- select de cada tabela separada
select*from usuario;
select*from academia;
select*from equipamento;
select*from sensor;
select*from leitura;



-- academia e seus equipamentos
select  a.nome 'Academia',
		a.CNPJ,
        a.CEP,
        e.tipo 'Equipamento',
        e.dataManutencao 'Última manutenção'		
from academia as a
inner join equipamento as e 
on e.fkAcademia = a.idAcademia;


-- Academia da cada usuário
select  u.nome 'User',
		u.email,
        U.CPF,
        u.senha,
        a.nome 'Academia'
from usuario as u
inner join academia as a on a.fkUsuario = u.idUsuario;

-- leituras dos sensores e seus equipamentos
select  l.idLeitura 'Leitura',
		l.dataHora 'data e hora',
        l.atividade,
        s.idSensor,
        e.idEquipamento,
        e.tipo 'Equipamento'
from leitura as l
inner join sensor as s
on l.fkSensor = s.idSensor
inner join equipamento as e
on s.fkEquipamento = idEquipamento;
