/* A inserção de um novo customer precisa possuir a nação começando com
   B ou b em caso do nome começar com M ou m*/



CREATE OR REPLACE PROCEDURE INSERT_CUSTOMER(
    CUSTOMERID NUMBER,
    FIRSTNAME IN VARCHAR2,
    LASTNAME IN VARCHAR2,
    COMPANY IN VARCHAR2,
    ADDRESS IN VARCHAR2,
    CITY IN VARCHAR2,
    STATE IN VARCHAR2,
    COUNTRY IN VARCHAR2,
    POSTALCODE IN VARCHAR2,
    PHONE IN VARCHAR2,
    FAX IN VARCHAR2,
    EMAIL IN VARCHAR2,
    SUPPORTREPID NUMBER
) AS
BEGIN
    IF ((NOT COUNTRY LIKE 'B%') AND (NOT COUNTRY LIKE 'b%') AND (FIRSTNAME LIKE 'M%' OR FIRSTNAME LIKE 'm%')) THEN
        RAISE_APPLICATION_ERROR(-2025, 'NAÇÃO INVÁLIDA');
    END IF;
    INSERT INTO CUSTOMER(CUSTOMERID,
                         FIRSTNAME,
                         LASTNAME,
                         COMPANY,
                         ADDRESS,
                         CITY,
                         STATE,
                         COUNTRY,
                         POSTALCODE,
                         PHONE,
                         FAX,
                         EMAIL,
                         SUPPORTREPID)
    VALUES (CUSTOMERID,
            FIRSTNAME,
            LASTNAME,
            COMPANY,
            ADDRESS,
            CITY,
            STATE,
            COUNTRY,
            POSTALCODE,
            PHONE,
            FAX,
            EMAIL,
            SUPPORTREPID);
END;

/* Creating a USER without permission to Insert, only by Procedure */
CREATE USER questao3 IDENTIFIED BY p4ssw0rd;
GRANT CONNECT, RESOURCE, CREATE SESSION, ALTER SESSION TO questao3;
GRANT SELECT ANY TABLE TO questao;
GRANT EXECUTE ON CHINOOK.INSERT_CUSTOMER TO questao3;


/* Para testar use o novo usuário para se conectar e tente executar
   o insert ira dar erro, depois tente executar a procedure */

INSERT INTO CUSTOMER(CUSTOMERID,
                     FIRSTNAME,
                     LASTNAME,
                     COMPANY,
                     ADDRESS,
                     CITY,
                     STATE,
                     COUNTRY,
                     POSTALCODE,
                     PHONE,
                     FAX,
                     EMAIL,
                     SUPPORTREPID)
VALUES (87287,
        'MARC RUFALO',
        'Dubois',
        NULL,
        '11, Place Bellecour',
        'Lyon',
        NULL,
        'Brasil',
        69002,
        '+33 04 78 30 30 30',
        NULL,
        'marc.dubois@hotmail.com',
        5
);
