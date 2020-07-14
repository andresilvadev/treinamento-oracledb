/* Criando um tablespace - Unidade lógica de armazenamento */
CREATE TABLESPACE oracledb
DATAFILE 'C:\app\andre\product\18.0.0\oradata\XE\oracledb.dbf'
SIZE 100m AUTOEXTEND ON NEXT 500m MAXSIZE 500m
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO;

/* Definição de parâmetro oculto */
alter session set "_ORACLE_SCRIPT"=true;

/* Cria um novo usuário com a senha schoolofnet */
create user andre IDENTIFIED BY schoolofnet
DEFAULT TABLESPACE oracledb QUOTA unlimited ON oracledb;

/* Permissões de usuário */
GRANT CREATE session to andre;


/* Cria uma nova tabela */
CREATE TABLE test (nome varchar(100));

/* Cria uma tabela com chave primaria */
CREATE TABLE funcionarios (
    matricula INT NOT NULL,
    nome VARCHAR2(50) NOT NULL,
    sobrenome VARCHAR2(100),
    data_nasc DATE,
    PRIMARY KEY(matricula)    
);

/* Cria uma sequencia das chaves primarias */
CREATE SEQUENCE matricula
START WITH 1
INCREMENT BY 1
NOCACHE;

/* Cria uma tabela departamento com chave extrangeira */
CREATE TABLE departamento (
    id_departamento INTEGER,
    nome_departamento VARCHAR2(100),
    matricula INT NOT NULL,
    FOREIGN KEY(matricula) REFERENCES funcionarios (matricula)
);

/* Cria uma sequencia das chaves primarias */
CREATE SEQUENCE id_departamento
START WITH 1
INCREMENT BY 1
NOCACHE;

/* Alterando uma coluna - Removendo campo */
ALTER TABLE funcionarios DROP COLUMN genero;

/* Alterando uma coluna - Adicionando campo */
ALTER TABLE funcionarios ADD genero VARCHAR2(1);

/* Alterando uma coluna - Modificando tipo do dado */
ALTER TABLE funcionarios MODIFY genero CHAR(1)

/* Renomeando uma coluna */
ALTER TABLE funcionarios RENAME COLUMN genero TO sexo;

/* Renomeando uma tabela */
ALTER TABLE funcionarios RENAME TO colaboradores;

/* Inserindo dados em */
INSERT INTO funcionarios (matricula, nome, sobrenome, data_nasc, sexo)
VALUES (1, 'André', 'Luiz da Silva', TO_DATE('1984-07-28','yyyy-mm-dd'), 'M' );

/* Inserindo varios os valores - Oracle possui uma tabela de conveniência chamada DUO */
INSERT ALL
INTO funcionarios (matricula, nome, sobrenome, data_nasc, sexo)
VALUES (2, 'Jesuan', 'Ferreira', TO_DATE('1984-07-28','yyyy-mm-dd'), 'M' )
INTO funcionarios (matricula, nome, sobrenome, data_nasc, sexo)
VALUES (3, 'Matheus', 'Tamaguxi', TO_DATE('1984-07-28','yyyy-mm-dd'), 'M' )
SELECT * FROM DUAL;

/* Inserindo dado departamento */
INSERT INTO departamento(id_departamento, nome_departamento, matricula )
VALUES(1,'Financeiro', 1)

/* Inserindo dado com o nextval */
INSERT INTO departamento(id_departamento, nome_departamento, matricula )
VALUES(id_departamento.nextval,'Recursos Humanos', 1)

/* Atualizando dados */
UPDATE funcionarios SET sobrenome = 'Lima';

/* Atualizando dados com delimitador */
UPDATE funcionarios SET sobrenome = 'Lima'
WHERE matricula = 2;

/* Atualizando mais de um campo */
UPDATE funcionarios SET sobrenome = 'Lima', nome = 'Alfredo'
WHERE matricula = 2;

/* Consultas simples */
SELECT * FROM funcionarios
WHERE matricula = '2';

SELECT * FROM funcionarios
WHERE sobrenome like 'Tam%';





