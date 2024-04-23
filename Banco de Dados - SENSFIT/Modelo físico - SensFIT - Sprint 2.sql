create database Sensfit;
use sensfit;
-- drop database sensfit;

-- criando o tabela de infromações de usuário e login
create table usuario(
idUsuario int auto_increment,
nome varchar(45) not null,
email varchar(45) not null,
senha varchar(8) not null,
 
primary key pkusuario (idUsuario));


-- tabela com infromações do gestor, cada gestor tem um usuário mas nem todo usuário é um gestor
create table gestor(
idGestor int auto_increment,
nome varchar(45) not null,
cpf varchar(11) not null unique,
telefone varchar(9) not null,
fkUsuario int,

primary key pkgestor (idGestor),
constraint fkUsuarioGestor foreign key (fkUsuario) references usuario (idUsuario));


-- cadastro de academias 
create table academia(
idAcademia int auto_increment,
nome varchar(45) not null,
cnpj varchar(14) not null unique,
cep varchar(8) not null,
logradouro varchar(4) not null,
telefone varchar(9) not null,

primary key pkAcademia (idAcademia));


-- associando academias a usuarios sendo que uma academia pode ter varios usuario e um usuario pode ter mais de uma academia
create table usuarioAcademia(
fkUsuario int,
fkAcademia int,
tipo varchar(20) default ('funcionário'), -- tipo de usuario por padrao é um funcionario

constraint fkUsuarioAcademia foreign key (fkUsuario) references usuario (idUsuario),
constraint fkAcademiaUsuario foreign key (fkAcademia) references academia (idAcademia),
primary key pkusuarioaAcademia (fkUsuario,fkAcademia));


-- cadastro de equipamentos 
create table equipamento(
idEquipamento int auto_increment,
dataVerificacao date, -- data da ultima manutenção do equipamento
tipo varchar(45) not null, -- tipo de máquina
fkAcademia int,

constraint fkEquipamentoAcademia foreign key (fkAcademia) references academia(idAcademia),
primary key pkEquipamento (idEquipamento));


-- cadastro do sensor 
create table sensor(
idSensor int auto_increment,
tipo varchar(45) not null,
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



-- inserção de dados mockados
insert into academia(nome,cnpj,cep,logradouro,telefone)
values('SmartFit','18273645263718','01928374',850,'918273641'),
('BlueFit','01928374651243','01926381',33,'916278354'),
('Panobianco','91827361926371','10273612',12,'917362910'),
('Leven','18273619263718','10223232',1004,'928338810'),
('Runner','81726354910263','17263524',70,'996112234');


insert into equipamento(dataVerificacao,tipo,fkAcademia)
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
('2023-12-22','Remo',4),
('2024-03-10','Esteira',5),
('2023-09-23','Bicicleta',5),
('2024-12-27','Cadeira flexora',5),
('2024-10-12','Leg press',5),
('2023-12-22','Remo',5);

insert into Sensor(tipo,fkEquipamento)
values('bloqueio',1),
('bloqueio',2),
('bloqueio',3),
('bloqueio',4),
('bloqueio',5),
('bloqueio',6),
('bloqueio',7),
('bloqueio',8),
('bloqueio',9),
('bloqueio',10),
('bloqueio',11),
('bloqueio',12),
('bloqueio',13),
('bloqueio',14),
('bloqueio',15),
('bloqueio',16),
('bloqueio',17),
('bloqueio',18),
('bloqueio',19),
('bloqueio',20),
('bloqueio',21),
('bloqueio',22),
('bloqueio',23),
('bloqueio',24),
('bloqueio',25);

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
(1,20),
(1,21),
(0,22),
(0,23),
(1,24),
(0,25);

insert into usuario(nome,email,senha)
values('Junior','junior@gmail.com','senha'),
('Fernanda','fernanda@gmail.com','senha1'),
('Agenor','agenor@gmail.com','senha2'),
('Minnie','minnie@gmail.com','senha3'),
('Dandara','dandara@gmail.com','senha4'),
('Brenda','brenda@gmail.com','senha5'),
('João','joao@gmail.com','senha6');


insert into gestor(nome,cpf,telefone,fkUsuario)
values('Brenda','19283746583','919283746',6),
('Minnie','10293847563','918273642',4),
('João','10384720594','928273645',7),
('Junior','10292837461','910293876',1),
('Agenor','10293847562','918273648',3);

insert into usuarioacademia(fkUsuario,fkAcademia,tipo)
values(1,1,'gestor'),
(2,2,'funcionário'),
(3,3,'gestor'),
(4,4,'gestor'),
(5,5,'funcionário'),
(6,2,'gestor'),
(7,5,'gestor');


-- select de cada tabela separada
select*from academia;
select*from equipamento;
select*from sensor;
select*from leitura;
select*from usuario;
select*from gestor;
select*from usuarioacademia;


-- academia e seus equipamentos
select  a.nome 'Academia',
		a.cnpj,
        a.cep,
        a.logradouro,
        a.telefone,
        e.tipo 'Equipamento',
        e.dataVerificacao 'Última manutenção'		
from academia as a
inner join equipamento as e 
on e.fkAcademia = a.idAcademia;

-- Usuário de cada gestor
select  g.nome 'Gestor',
		g.cpf,
        g.telefone,
        u.nome 'User',
        u.email,
        u.senha
from gestor as g
inner join usuario as u
on g.fkUsuario = u.idUsuario;

-- Academia da cada usuário
select  u.nome 'User',
		u.email,
        u.senha,
        a.nome 'Academia',
        uau.tipo
from usuario as u
inner join usuarioacademia as uau
on uau.fkUsuario = u.idUsuario
inner join academia as a
on uau.fkAcademia = a.idAcademia;

-- leituras dos sensores e seus equipamentos
select  l.idLeitura 'Leitura',
		l.dataHora 'data e hora',
        l.atividade,
        s.idSensor,
        s.tipo 'Tipo sensor',
        e.idEquipamento,
        e.tipo 'Equipamento'
from leitura as l
inner join sensor as s
on l.fkSensor = s.idSensor
inner join equipamento as e
on s.fkEquipamento = idEquipamento;

        