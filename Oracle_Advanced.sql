/* Operadores AND */
SELECT * FROM EMPLOYEE
WHERE TITLE = 'Teller'
AND FIRST_NAME = 'Sarah';

/* Operadores OR */
SELECT * FROM EMPLOYEE
WHERE TITLE = 'Teller'
OR FIRST_NAME = 'Sarah';

/* Operadores AND e OR */
SELECT * FROM EMPLOYEE
WHERE TITLE = 'Teller'
AND DEPT_ID = 1
OR FIRST_NAME = 'Sarah';

/* Operadores AND e OR e NOT - Tudo que não tem a ver com essas condições */
SELECT * FROM EMPLOYEE
WHERE NOT TITLE = 'Teller'
AND DEPT_ID = 1
OR FIRST_NAME = 'Sarah';

/* LIKE - Selecione tudo que esta na condição como se fosse tal 
   'Sil%' => Começa com a letra Sil
   '%SILV' => Termina com SILV
*/
SELECT * FROM EMPLOYEE
WHERE FIRST_NAME like 'S%'
AND DEPT_ID = '1';

/* IN - Testa uma condição em uma lista de valores fixos 
    Retorna todos os dados que sejam verdadeiros na lista que está sendo passada
*/
SELECT FIRST_NAME, LAST_NAME, DEPT_ID FROM EMPLOYEE
WHERE FIRST_NAME IN ('Susan', 'Paula', 'Helen');

/* BETWEEN - Procura valores baseado em uma range */
SELECT FIRST_NAME, LAST_NAME, DEPT_ID FROM EMPLOYEE
WHERE (DEPT_ID BETWEEN 1 AND 3);

/* BETWEEN COM FUNÇÕES DE DATA */
SELECT FIRST_NAME, LAST_NAME, DEPT_ID, TO_CHAR(START_DATE, 'dd-MM-YYYY') AS START_VN_DATE FROM EMPLOYEE
WHERE (START_DATE BETWEEN TO_DATE('03-05-2002','dd-MM-yyyy') AND TO_DATE('13-07-2020', 'dd-MM-YYYY'));


/* ORDER BY */
SELECT PRODUCT_CD, PRODUCT_TYPE_CD, NAME FROM PRODUCT
ORDER BY PRODUCT_TYPE_CD DESC;

SELECT PRODUCT_CD, PRODUCT_TYPE_CD, NAME FROM PRODUCT
ORDER BY NAME, PRODUCT_TYPE_CD DESC; -- Classifica o primeiro campo como ASC e o segundo como DESC


/* FUNÇÕES DE AGREGAÇÕES -  BÁSICAMENTE SÃO FUNÇÕES MATEMÁTICAS - NORMALMENTE USADAS COM GROUP BY E HAVING */
SELECT COUNT(ACCOUNT_ID) FROM ACCOUNT;




SELECT * FROM ACCOUNT;

/* FUNÇÕES DE AGREGAÇÕES */
/* Conta o número de contas existentes no banco */
SELECT COUNT(account_id) FROM ACCOUNT;


SELECT * FROM ACC_TRANSACTION;

/* FUNÇÕES DE AGREGAÇÕES */
/* Distinct elimina os resultados duplicados. */
/* Esta query trás todas as contas que tiveram pelo menos uma transação no banco */
SELECT COUNT(DISTINCT ACCOUNT_ID) FROM ACC_TRANSACTION;


SELECT * FROM ACCOUNT;

/* FUNÇÕES DE AGREGAÇÕES */
/* Soma retorna o total da soma de colunas númericas */
/* Queremos saber a quantidade de dinheiro que tem nas contas dos consumidores */
SELECT SUM(AVAIL_BALANCE) FROM ACCOUNT;

/* FUNÇÕES DE AGREGAÇÕES */
/* Soma da coluna baseada em um critério */
SELECT SUM(AVAIL_BALANCE) FROM ACCOUNT
WHERE CUST_ID = 1;


/* FUNÇÕES DE AGREGAÇÕES */
/* AVG - AVARAGE - Função que retorna a média de um valor de uma coluna numérica */
SELECT AVG(AVAIL_BALANCE) FROM ACCOUNT;

/* Média de um tipo de produto - Referente a média de depósitos */
SELECT AVG(AVAIL_BALANCE) FROM ACCOUNT
WHERE product_cd = 'SAV';


/* FUNÇÕES DE AGREGAÇÕES */
/* MIN - MÍNIMA - Função que retorna o menor valor de uma coluna selecionada */
SELECT MIN(AVAIL_BALANCE) FROM ACCOUNT
WHERE product_cd = 'SAV';

/* FUNÇÕES DE AGREGAÇÕES */
/* MAX - MAXIMO - Função que retorna o maior valor de uma coluna selecionada */
SELECT MAX(AVAIL_BALANCE) FROM ACCOUNT
WHERE product_cd = 'SAV';

/* FUNÇÕES DE AGREGAÇÕES */
/* GROUP BY */
/* Frequentemente usado com as funções de agregação, ele agrupa um conjunto de resultados
baseado em uma ou mais colunas */
/* 
 - EMPRÉSTIMOS
 - DEPÓSITOS - SAV
 - TRANSFERENCIAS
 - APLICAÇÕES
 Quero ver o valor em conta proporcional a cada tipo de serviços/produtos diferente
 Query que gera um conjunto de resultados baseado em um código de um produto
*/
SELECT 
    PRODUCT_CD,
    COUNT(PRODUCT_CD),  -- TOTAL DE PRODUTOS MOVIMENTADOS
    SUM(AVAIL_BALANCE), -- SOMA DOS VALORES
    AVG(AVAIL_BALANCE)  -- MÉDIA DE DEPOSITOS
FROM ACCOUNT
    GROUP BY PRODUCT_CD;
    

/* Query que retorna quantas contas cada cliente tem */
SELECT 
    CUST_ID,
    COUNT(ACCOUNT_ID)
FROM ACCOUNT
    GROUP BY CUST_ID;
    
    
/* Query que retorna quantas contas cada cliente tem baseado no id do cliente */
SELECT 
    CUST_ID,
    COUNT(ACCOUNT_ID)
FROM ACCOUNT
    WHERE CUST_ID = 1
    GROUP BY CUST_ID;
    
/* Qual a quantidade de dinheiro que cada cliente tem em sua conta */    
SELECT 
    CUST_ID,
    sum(AVAIL_BALANCE)
FROM ACCOUNT
    GROUP BY CUST_ID;
    
    
/* FUNÇÕES DE AGREGAÇÕES */
/* HAVING > Coloca condições nos grupos criados pela clausula GROUP BY */
/* Vamos agrupar os tipos de serviços, mas vamos exibir apenas os que tenham mais de 3 participantes, 
ou seja as que tiveram o uso maior que 3 */
SELECT 
    PRODUCT_CD,
    COUNT(PRODUCT_CD),  -- TOTAL DE PRODUTOS MOVIMENTADOS
    SUM(AVAIL_BALANCE), -- SOMA DOS VALORES
    AVG(AVAIL_BALANCE)  -- MÉDIA DE DEPOSITOS
FROM ACCOUNT
    GROUP BY PRODUCT_CD
    HAVING COUNT(PRODUCT_CD) > 3;
    
    
/* HAVING COM WHERE */
/* WHERE VEM SEMPRE ANTES DO GRUP BY  */
SELECT 
    PRODUCT_CD,
    COUNT(PRODUCT_CD),  -- TOTAL DE PRODUTOS MOVIMENTADOS
    SUM(AVAIL_BALANCE), -- SOMA DOS VALORES
    AVG(AVAIL_BALANCE)  -- MÉDIA DE DEPOSITOS
FROM ACCOUNT
    WHERE OPEN_BRANCH_ID = 1
    GROUP BY PRODUCT_CD
    HAVING COUNT(PRODUCT_CD) > 1;
    
    
    
/* INNER JOIN - Junções de tabelas */
/* Seleciona os registros que tem registros correspondentes entre si nas mesmas tabelas */
SELECT 
    EMP.FIRST_NAME, 
    EMP.LAST_NAME, 
    EMP.DEPT_ID, 
    DEP.NAME 
FROM EMPLOYEE EMP
INNER JOIN DEPARTMENT DEP
ON EMP.DEPT_ID = DEP.DEPT_ID;


/* LEFT JOIN - Junções de tabelas */
/* TABELA A e B - Left trás todos os dados da tabela A mesmo que não haja dados correspondentes na tabela B */
/* TABELA CUSTOMER => LEFT */
/* TABELA OFFICER => RIGHT */
SELECT 
    CUST.CUST_ID,
    CUST.STATE,
    CUST.FED_ID,
    OFF.CUST_ID,
    OFF.OFFICER_ID,
    OFF.START_DATE,
    OFF.TITLE
FROM CUSTOMER CUST
LEFT JOIN OFFICER OFF
ON CUST.CUST_ID = OFF.CUST_ID;


/* RIGHT JOIN - Junções de tabelas */
/* TABELA A e B - Left trás todos os dados da tabela B mesmo que não haja dados correspondentes na tabela A */
/* TABELA CUSTOMER => LEFT */
/* TABELA OFFICER => RIGHT */
SELECT 
    CUST.CUST_ID,
    CUST.STATE,
    CUST.FED_ID,
    OFF.CUST_ID,
    OFF.OFFICER_ID,
    OFF.START_DATE,
    OFF.TITLE
FROM CUSTOMER CUST
RIGHT JOIN OFFICER OFF
ON CUST.CUST_ID = OFF.CUST_ID;
 
 
/* SUBQUERY COM WHERE - CHAMDO DE NESTED SUBQUERYS */ 
/* Selecionamos os campos com uma outra consulta na tabela customer filtrando o tipo igual a 'B' */
SELECT 
    ACCOUNT_ID,
    OPEN_DATE,
    AVAIL_BALANCE
FROM ACCOUNT
WHERE CUST_ID IN 
(
    SELECT CUS.CUST_ID FROM CUSTOMER CUS
    WHERE CUS.CUST_TYPE_CD = 'B'
);
 
 
SELECT * FROM CUSTOMER;
SELECT * FROM ACCOUNT;

----------------------------------------------------------------------------

/* SUBQUERY COM FROM - SERIA O MESMO QUE SE REFERIR A UMA VIEW OU UMA TABELA VIRTUAL */ 
/* Baseado nos customers ids, eu quero que selecione os campos baseados na subconsulta - que é a soma do balanço deles */
SELECT 
    CUS.CUST_ID,
    CUS.ADDRESS,
    CUS.FED_ID
FROM CUSTOMER CUS,
(
    SELECT 
        ACC.CUST_ID,
        SUM(ACC.AVAIL_BALANCE)
    FROM ACCOUNT ACC
    GROUP BY ACC.CUST_ID
) ACC2
    WHERE CUS.CUST_ID = ACC2.CUST_ID;
 
 
SELECT * FROM CUSTOMER;
SELECT * FROM ACCOUNT;

----------------------------------------------------------------------------

/* SUBQUERY NA CLAUSULA SELECT */ 
/* Pega o resultado da consulta e joga como se fosse mais uma coluna */
/* Nessa sub-consulta ela deve retornar apenas um uníco valor */
SELECT 
    CUS.CUST_ID,
    CUS.ADDRESS,
    CUS.FED_ID,
    (
    SELECT 
        SUM(ACC.AVAIL_BALANCE)
    FROM ACCOUNT ACC
    WHERE ACC.CUST_ID = CUS.CUST_ID
    ) AS SUM_AVAIL_BALANCE
    FROM CUSTOMER CUS;
    
    