/* Altera a tabela CUSTOMER, e cria uma coluna para
   os números de sequência */

ALTER TABLE CUSTOMER
ADD sequence_number NUMBER;

/* Faz um SELECT FOR UPDATE dessa nova coluna e
   depois faz um UPDATE incrementando o valor da coluna */

CREATE OR REPLACE PROCEDURE seq
    (customer_id NUMBER, firstname_n IN VARCHAR2, lastname_n IN VARCHAR2)
AS
actual_number NUMBER;
BEGIN
    SET TRANSACTION READ WRITE;
    SELECT C.sequence_number INTO actual_number
    FROM CUSTOMER C WHERE C.CUSTOMERID = customer_id
    FOR UPDATE;


    UPDATE CUSTOMER C
    SET C.sequence_number = (CASE WHEN actual_number IS NULL THEN 1 ELSE actual_number + 1 END),
        C.FIRSTNAME = firstname_n, C.LASTNAME = lastname_n
    WHERE C.CUSTOMERID = customer_id;

    COMMIT;
end;

CALL seq(1, 'teste', 'testado');

SELECT * FROM CUSTOMER WHERE CUSTOMERID = 1;
