/* regra semântica onde o valor Total de um Invoice
   é uma  += UnitPrice * Quantity de todos os registros de InvoiceLine */

/* função que retorna 2 valores: 1 ou 2
   a função irá multiplicar o UNITPRICE com a quantity
   se o valor do invoice.total for igual a multiplicação, retorna 1
   caso seja diferente, ele atualiza a tabela e retorna 2 */

CREATE OR REPLACE FUNCTION check_invoice_total_by_id
    (invoice_id IN integer)
    return number
IS
    invoicetotal number;
    invoicelinetotal number;
    checked integer;
BEGIN
    checked := 0;
    SELECT inv.total INTO invoicetotal FROM INVOICE inv
    WHERE inv.INVOICEID = invoice_id;

    SELECT SUM(invline.UNITPRICE * invline.quantity) INTO invoicelinetotal FROM INVOICELINE invline
    WHERE invline.INVOICEID = invoice_id;

    if invoicetotal = invoicelinetotal then
        checked := 1;
    else
        UPDATE INVOICE inv
        SET TOTAL = invoicelinetotal
        WHERE inv.INVOICEID = invoice_id;
        checked := 2;
    end if;
RETURN checked;
end;