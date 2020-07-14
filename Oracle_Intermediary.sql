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

/* Operadores AND e OR e NOT - Tudo que n�o tem a ver com essas condi��es */
SELECT * FROM EMPLOYEE
WHERE NOT TITLE = 'Teller'
AND DEPT_ID = 1
OR FIRST_NAME = 'Sarah';

/* LIKE - Selecione tudo que esta na condi��o como se fosse tal 
   'Sil%' => Come�a com a letra Sil
   '%SILV' => Termina com SILV
*/
SELECT * FROM EMPLOYEE
WHERE FIRST_NAME like 'S%'
AND DEPT_ID = '1';

/* IN - Testa uma condi��o em uma lista de valores fixos 
    Retorna todos os dados que sejam verdadeiros na lista que est� sendo passada
*/
SELECT FIRST_NAME, LAST_NAME, DEPT_ID FROM EMPLOYEE
WHERE FIRST_NAME IN ('Susan', 'Paula', 'Helen');

/* BETWEEN - Procura valores baseado em uma range */
SELECT FIRST_NAME, LAST_NAME, DEPT_ID FROM EMPLOYEE
WHERE (DEPT_ID BETWEEN 1 AND 3);

/* BETWEEN COM FUN��ES DE DATA */
SELECT FIRST_NAME, LAST_NAME, DEPT_ID, TO_CHAR(START_DATE, 'dd-MM-YYYY') AS START_VN_DATE FROM EMPLOYEE
WHERE (START_DATE BETWEEN TO_DATE('03-05-2002','dd-MM-yyyy') AND TO_DATE('13-07-2020', 'dd-MM-YYYY'));


/* ORDER BY */
SELECT PRODUCT_CD, PRODUCT_TYPE_CD, NAME FROM PRODUCT
ORDER BY PRODUCT_TYPE_CD DESC;

SELECT PRODUCT_CD, PRODUCT_TYPE_CD, NAME FROM PRODUCT
ORDER BY NAME, PRODUCT_TYPE_CD DESC; -- Classifica o primeiro campo como ASC e o segundo como DESC


/* FUN��ES DE AGREGA��ES -  B�SICAMENTE S�O FUN��ES MATEM�TICAS - NORMALMENTE USADAS COM GROUP BY E HAVING */
SELECT COUNT(ACCOUNT_ID) FROM ACCOUNT;
 