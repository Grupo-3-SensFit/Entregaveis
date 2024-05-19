create database desafioG3;
use desafioG3;

CREATE TABLE flautistas (
    idFlautista INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    habilidade INT
);

INSERT INTO flautistas (nome, habilidade) VALUES
  ('Hans Christian Andersen', 2),
  ('Johann Wolfgang von Goethe', 3),
  ('William Shakespeare', 4),
  ('Victoria Huga', 5),
  ('Fyodor Dostoevsky', 1);


CREATE TABLE musica (
    idMusica INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    encantamento INT
);

INSERT INTO musica (nome, encantamento) VALUES
  ('Melodia do Flautista Mágico', 1),
  ('Dança dos Ratos Alegres', 2),
  ('Marcha Triunfal do Lobo', 3),
  ('Sinfonia da Floresta Encantada', 5),
  ('Canção da Chuva Tranquila', 4);


create table repertorioMsc (
idRepertorio int auto_increment,
fkFlautista INT unique,
fkMusica INT unique,
primary key (idRepertorio),
constraint fkFlautista foreign key (fkFlautista) references flautistas(idFlautista),
constraint fkMusica foreign key (fkMusica) references musica(idMusica)
);

INSERT INTO repertorioMsc (fkFlautista, fkMusica)
values (1,2),
(2,1),
(3,4),
(4,5),
(5,3);


create table ninhada (
idNinhada INT auto_increment primary key,
tipo varchar(45),
fkRepertorio int,
constraint fkFlautistaMusicaRepertorio foreign key (fkRepertorio) references repertorioMsc(idRepertorio)
);

INSERT INTO ninhada (tipo, fkRepertorio) VALUES
  ('Ratazana', 1),
  ('Hamster', 2),
  ('Camundogo', 3),
  ('Rato-do-campo', 4);

create table ratos (
idRatos INT auto_increment primary key,
nome varchar(45), 
resistencia int,
fkNinhada INT,
constraint fkRatosNinhada foreign key (fkNinhada) references ninhada(idNinhada)
);

INSERT INTO ratos (nome, resistencia, fkNinhada) VALUES
  ('Rato Cinza', 10, 1),
  ('Rato Marrom', 8, 2),
  ('Rato Branco', 5, 3),
  ('Rato Rapido', 5, 1),
  ('Rato Forte', 9, 2),
  ('Rato Ninja', 10, 4),
  ('Rato Veloz', 1, 1),
  ('Rato Poderoso', 7, 2),
  ('Rato Sabio', 6, 3),
  ('Rato Mestre', 8, 4);
  


-- SELECT TODOS OS DADOS
SELECT 
    r.nome,
    r.resistencia,
    n.idNinhada,
    n.tipo,
    rm.idRepertorio,
    f.nome,
    f.habilidade,
    m.nome,
    m.encantamento
FROM
    ratos AS r
        INNER JOIN
    ninhada AS n ON r.fkNinhada = n.idNinhada
        INNER JOIN
    repertorioMsc AS rm ON n.fkRepertorio = rm.idRepertorio
        INNER JOIN
    musica AS m ON rm.fkMusica = m.idMusica
        INNER JOIN
    flautistas AS f ON rm.fkFlautista = f.idFlautista;


-- Mostre em ordem decrescente o rato com maior resistencia -Yasmim (FACIL)

-- Mostre os dados dos flautistas cujo habilidade é maior igual a 7. -Yasmim (FACIL)

-- Mostre qual ninhada de ratos é atraída por um determinado repertório -Yasmim(FACIL)

-- 	Mostre a média de resistencia de uma determinada ninhada -Yasmim (MEDIO)

-- Mostre o nome do rato, o nome do flautista, o nome da musica, a resistencia do rato, a habilidade do flautista, o encantamento da musica, e mostre o dano sofrido(habilidadeXencantamento) -Yasmim (DIFICIL)

-- Exiba os tipos de ratos existentes - Isaias (Fácil)

-- Exiba os nomes das músicas ordenados pelos encantamentos em ordem descrescente - Isaias(Fácil)

-- Exiba os nomes dos flautistas e as músicas que eles tocam - Isaias(Fácil)

-- Exiba os nomes dos ratos, os tipos de rato, a resistencia deles e o repertorio que os afetam de uma determinada ninhada - Isaias(Médio)

-- Exiba a ninhada de todos os ratos, os nomes dos ratos, os nomes dos flautistas, os nomes das músicas que os flautistas tocam agrupados pelos nomes dos flautistas, ratos, músicas em ordem descrescente pela ninhada - Isaias(Difícil)
