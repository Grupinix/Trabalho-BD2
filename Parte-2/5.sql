CURSOR solucao
IS
SELECT INVOICEID
FROM INVOICE
WHERE
    FOR UPDATE;

-- não sei o que fazer fml