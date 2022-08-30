INTEGER 
REAL
SERIAL 	
NUMERIC 

VARCHAR (n)									
CHAR (n)
TEXT

BOOLEAN

DATE
TIME
TIMESTAMP

CREATE TABLE aluno(
	id serial,
	nome varchar(255),
	cpf char(11),
	observacao text,
	idade integer,
	dinherio numeric(10,2),
	altura real,
	ativo boolean,
	data_nascimento date,
	hora_aula time,
	matriculado_em timestamp
);

select * from aluno;

/*Para inserir valores nas colunas da tabela*/
INSERT INTO aluno (nome, cpf, observacao, idade, dinheiro, altura,
				   ativo, data_nascimento,hora_aula, matriculado_em)
values ('Felipe', '11234567890', 'Mensagem de texto sem tamanho 
		minimo ou máximo', 35, 100.50, 1.83, true,'2002-12-31',
	   '13:55:00', '2022-08-29 13:56:00')

/*Para alterar uma coluna na tabela
ALTER TABLE aluno RENAME COLUMN dinherio TO dinheiro;*/

/*Atualizando um registro na tabela*/
SELECT * FROM aluno
where id = 1

UPDATE aluno
	SET nome = 'Sandro', 
		cpf = '52649587623', 
		observacao = 'Atualização de tabela para teste', 
		idade = 26, 
		dinheiro = 1000.00, 
		altura = 1.80,
		ativo = FALSE, 
		data_nascimento = '1996-07-07',
		hora_aula = '13:00:00', 
		matriculado_em = '2020-01-02 15:00:00'
where id = 1;

--excluindo um registro de uma tabela
SELECT * FROM aluno
where nome = 'Sandro';

DELETE FROM aluno
where nome = 'Sandro'; --Irá apagar TODOS os registros, pois não há um FILTRO.

--Para selecionar apenas alguns registros
SELECT nome as "Nome do Aluno", --Para alterar o nome de exibição de um campo
	   idade,
	   matriculado_em
from aluno;

--Aplicando filtro na tabela
INSERT INTO aluno (nome) VALUES ('Leonardo');
INSERT INTO aluno (nome) VALUES ('Jackison');
INSERT INTO aluno (nome) VALUES ('Fernando');
INSERT INTO aluno (nome) VALUES ('Sandro');

SELECT * FROM aluno
where nome LIKE 'Leona_do' --para consultar qualquer registro que tenha essas letras

SELECT * FROM aluno
where nome NOT LIKE 'Leonardo' --p/ consultar todos os registro, menos o especificado

SELECT * FROM aluno
where nome LIKE '%e' --qualquer coisa que termine com s
where nome LIKE 'J%' --qualquer coisa iniciado com J
where nome LIKE '% %' --qualuqer coisa com espaço no meio
		
SELECT * FROM aluno
where idade BETWEEN 10 and 27 --um filtro entre as idades (serve p/ todos os campos)

--Aplicando condição (ou mais de uma)
SELECT * FROM aluno 
	where ativo IS null
SELECT * FROM aluno
	where nome LIKE 'Leonardo' OR nome LIKE 'Felipe' AND cpf IS NOT NULL
	
--------------------------------APLICANDO RELACIONAMENTO----------------------------------
CREATE TABLE aluno(
	id SERIAL PRIMARY KEY, --será único, não pode ser repetido e nem nulo
	nome VARCHAR(255) NOT NULL
);

SELECT * FROM aluno

CREATE TABLE curso(
	id int PRIMARY KEY,
	nome VARCHAR(255) NOT NULL
);

--CRIANDO CHAVE ESTRANGEIRA
CREATE TABLE aluno_curso(
	aluno_id INTEGER,
	curso_id INTEGER,
	PRIMARY KEY (aluno_id, curso_id), --pk composta
	FOREIGN KEY (aluno_id) --especificar qual campo da tabela que irá se relacionar
		REFERENCES aluno (id)
		ON DELETE CASCADE  --para não conflitar os id's das tabelas na hora de deletar
		ON UPDATE CASCADE, --para não conflitar os id's das tabelas na hora de atualizar
	FOREIGN KEY (curso_id) 
		REFERENCES curso (id)
);


INSERT INTO curso (id, nome) VALUES (1, 'JavaScript');
INSERT INTO curso (id, nome) VALUES (2, 'HTML');
INSERT INTO curso (id, nome) VALUES (3, 'CSS');

SELECT * FROM curso

INSERT INTO aluno (nome) VALUES ('Diogo');
INSERT INTO aluno (nome) VALUES ('Vinicius');
INSERT INTO aluno (nome) VALUES ('Sandro');

SELECT * from aluno
 
--INSERINDO OS ALUNOS NOS CURSOS
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (1, 1); --incluindo diogo no curso de JS através do ID dele e ID do curso
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (2, 2); --incluindo vinicius no curso de HTML "
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (3, 3); --incluindo Sandro
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (2, 1);

SELECT * FROM aluno_curso

--CONSULTA COM RELACIONAMENTO
SELECT aluno.nome as "Nome dos Alunos",
	   curso.nome as "Curso matriculado"
	FROM aluno
	JOIN aluno_curso on aluno_curso.aluno_id = aluno.id --mostrará aluno, seu id e id do curso matriculado
	JOIN curso on curso.id = aluno_curso.curso_id --mostrará tudo, incluindo nome e id do curso matriculado

--TIPOS DE JOINS
JOIN -> Para juntar todas as tabelas, necessitando que od dados das tabelas estejam
relacionados entre si 
LEFT join -> Quando prioriza o dado da tabela da esquerda (cima)
RIGHT join -> Prioridade da direita (baixo)
FULL join -> Ignora se tiver algum nulo em qualquer dos lados
CROSS join -> todos por todos

--DELETAR OU ATUALIZAR UM REGISTRO QUE POSSUI FK
Basta adicionar um delete cascade após a referencia na tabela, exemplo:
FOREIGN KEY (aluno_id) 
	REFERENCES aluno (id)
	ON DELETE CASCADE, --AQUI SERVE PARA DELETAR SER CONFLITAR COM A FK OU PK
FOREIGN KEY (curso_id) 
	REFERENCES curso (id)

DELETE FROM aluno WHERE ID = 1; --após, basta solicitar a exclusão do registro normalmente

UPDATE aluno SET id= 2 --após, basta atualizar os registros necessário (será atualizado em todas as tabelas que estiverem relacionadas)
	where id= 3

----------------------------AVANÇANDO COM CONSULTAS----------------------------
--Limitando as consultas
ORDER BY -> ordernar por
LIMIT -> Limita a quantidade de registros 
OFFSET -> anda a quantidade de registros para a frente

--Funções de Agregação
COUNT -> Retorna a quantidade de registros
	SELECT COUNT (id) as "Quantidade total dos ID"
		FROM aluno;

SUM -> Retorna a soma dos registros
	SELECT SUM (id) as "Soma dos ID"
		FROM aluno;

MAX -> Retorna o maior valor dos registros
	SELECT MAX(id) as "O maior ID é"
		FROM aluno;

MIN -> Retorna o menor valor dos registros
	SELECT MIN(id) as "O menor ID é"
		FROM aluno;
		
AVG -> Retorna a média dos regristros
	SELECT ROUND (AVG(id),2)  as "Média dos ID é" --round para limitar as casas decimais
		FROM aluno;

--Filtrando consultas agrupadas
SELECT aluno.nome AS "Nome do Aluno",
    count(curso.id) AS "Quantidade de Cursos Matriculados"
FROM aluno 
    JOIN curso ON curso.id = aluno.id
	GROUP BY 1 HAVING count(curso.id) < 10 ORDER BY 1








