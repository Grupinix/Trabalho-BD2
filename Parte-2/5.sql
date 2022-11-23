/* Altera a tabela CUSTOMER, e cria uma coluna para
   os números de sequência */

ALTER TABLE CUSTOMER
ADD sequence_number NUMBER;

/* Faz um SELECT FOR UPDATE dessa nova coluna e
   depois faz um UPDATE incrementando o valor da coluna */

BEGIN
    SELECT sequence_number
    FROM CUSTOMER
    FOR UPDATE;

    UPDATE CUSTOMER C
    SET C.sequence_number = C.sequence_number + 1;

    COMMIT;
end;

