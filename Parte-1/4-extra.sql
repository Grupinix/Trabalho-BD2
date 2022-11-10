CREATE OR REPLACE PROCEDURE SYS.CREATE_SCHEMA_FROM_CHINOOK_SCHEMA(NEW_SCHEMA IN VARCHAR2) IS
CREATE_SCHEMA VARCHAR2(1024);
CURSOR COMMANDOS IS (
SELECT COMANDOS
FROM (
    SELECT
        'CREATE TABLE ' || NEW_SCHEMA || '.' ||
        DC.TABLE_NAME ||
        '(' ||
        (
            SELECT LISTAGG((
                COLUMN_NAME || ' ' || ATC.DATA_TYPE || (
                CASE
                    WHEN ATC.DATA_TYPE = 'VARCHAR2'
                        THEN ('(' || ATC.CHAR_LENGTH || ')')
                    WHEN ATC.DATA_TYPE = 'NUMBER' AND (
                            ATC.DATA_PRECISION IS NOT NULL AND
                            ATC.DATA_SCALE IS NOT NULL
                        )
                        THEN ('(' || ATC.DATA_PRECISION || ',' || ATC.DATA_SCALE || ')')
                    WHEN ATC.DATA_TYPE = 'NUMBER' AND ATC.DATA_PRECISION IS NOT NULL
                        THEN ('(' || ATC.DATA_PRECISION || ')')
                    ELSE ''
                END ||
                CASE WHEN ATC.NULLABLE = 'N' THEN ' NOT NULL' ELSE '' END
            )), ', ')
            FROM ALL_TAB_COLS ATC
            WHERE ATC.TABLE_NAME = DC.TABLE_NAME AND ATC.OWNER = 'CHINOOK'
            GROUP BY ATC.TABLE_NAME
        ) ||
        ', CONSTRAINT PK_' || DC.TABLE_NAME || ' PRIMARY KEY (' ||
        (
            SELECT LISTAGG((DCC.COLUMN_NAME), ', ')
            FROM DBA_CONSTRAINTS DCT
            JOIN DBA_CONS_COLUMNS DCC ON DCT.CONSTRAINT_NAME = DCC.CONSTRAINT_NAME
            WHERE DCT.TABLE_NAME = DC.TABLE_NAME
                AND DCT.CONSTRAINT_TYPE = 'P'
                AND DCT.OWNER = 'CHINOOK'
                AND DCC.OWNER = 'CHINOOK'
        ) ||
        '))' AS COMANDOS
    FROM DBA_CATALOG DC
    WHERE DC.OWNER = 'CHINOOK' AND TABLE_TYPE = 'TABLE'
    GROUP BY DC.TABLE_NAME
) UNION (
    SELECT
        'ALTER TABLE ' || NEW_SCHEMA || '.' ||
        DC.TABLE_NAME ||
        ' ADD CONSTRAINT ' ||
        DCC.CONSTRAINT_NAME ||
        ' FOREIGN KEY (' ||
        DCC.COLUMN_NAME ||
        ') REFERENCES ' || NEW_SCHEMA || '.' ||
        CD.TABLE_NAME ||
        '(' ||
        (
            SELECT LISTAGG((DCCC.COLUMN_NAME), ', ')
            FROM DBA_CONSTRAINTS DCT
            JOIN DBA_CONS_COLUMNS DCCC ON DCT.CONSTRAINT_NAME = DCCC.CONSTRAINT_NAME
            WHERE DCT.TABLE_NAME = CD.TABLE_NAME
                AND DCT.CONSTRAINT_TYPE = 'P'
                AND DCT.OWNER = 'CHINOOK'
                AND DCCC.OWNER = 'CHINOOK'
        ) ||
        ')' AS COMANDOS
    FROM DBA_CONSTRAINTS DC
    JOIN DBA_CONS_COLUMNS DCC ON DC.CONSTRAINT_NAME = DCC.CONSTRAINT_NAME
    JOIN DBA_CONSTRAINTS CD ON DC.R_CONSTRAINT_NAME = CD.CONSTRAINT_NAME
    WHERE DC.OWNER = 'CHINOOK'
        AND DC.CONSTRAINT_TYPE = 'R'
        AND CD.CONSTRAINT_TYPE = 'P'
        AND DCC.OWNER = 'CHINOOK'
        AND CD.OWNER = 'CHINOOK'
));
BEGIN
    CREATE_SCHEMA := 'CREATE USER ' || NEW_SCHEMA || ' IDENTIFIED BY p4ssw0rd';
    EXECUTE IMMEDIATE CREATE_SCHEMA;

    FOR I_CMD IN COMMANDOS LOOP
        EXECUTE IMMEDIATE I_CMD.COMANDOS;
    END LOOP;
END;

/* Basta chamar a procedure CREATE_SCHEMA_FROM_CHINOOK_SCHEMA que ela irá criar
   um novo usuário (para criar um schema no oracle é necessário criar um novo
   usuário) e então irá recriar o schema atual do CHINOOK nesse novo usuário
   O nome do usuário deve ser passado como parametro */

CALL SYS.CREATE_SCHEMA_FROM_CHINOOK_SCHEMA('NOVO_SCHEMA');