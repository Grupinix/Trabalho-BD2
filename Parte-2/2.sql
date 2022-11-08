/* Validação de E-mail por Trigger */

CREATE OR REPLACE TRIGGER VALIDA_EMAIL_TRIGGER
BEFORE INSERT OR UPDATE ON CUSTOMER
FOR EACH ROW
BEGIN
    IF NOT REGEXP_LIKE(:NEW.EMAIL, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$') THEN
        RAISE_APPLICATION_ERROR(-20202, 'E-MAIL INVÁLIDO');
    END IF;
END;

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
VALUES (8797,
        'MARC RUFALO',
        'Dubois',
        NULL,
        '11, Place Bellecour',
        'Lyon',
        NULL,
        'France',
        69002,
        '+33 04 78 30 30 30',
        NULL,
        'marc.duboishotmail.com',
        5
);

/* Validação de NAÇÃO por B */

CREATE OR REPLACE TRIGGER VALIDA_COUNTRY_TRIGGER
BEFORE INSERT OR UPDATE ON CUSTOMER
FOR EACH ROW
BEGIN
    IF (NOT (:NEW.COUNTRY) LIKE 'B%') AND (NOT (:NEW.COUNTRY) LIKE 'b%') THEN
        RAISE_APPLICATION_ERROR(-20025, 'NAÇÃO INVÁLIDA');
    END IF;
END;

SELECT * FROM USER_ERRORS;

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
VALUES (87787,
        'MARC RUFALO',
        'Dubois',
        NULL,
        '11, Place Bellecour',
        'Lyon',
        NULL,
        'France',
        69002,
        '+33 04 78 30 30 30',
        NULL,
        'marc.dubois@hotmail.com',
        5
);
