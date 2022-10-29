#!/bin/bash
docker-compose exec oracle-xe sh -c "sqlplus / AS SYSDBA << EOF
ALTER SESSION SET \"_ORACLE_SCRIPT\"=true;
CREATE USER chinook IDENTIFIED BY p4ssw0rd;
GRANT CONNECT, RESOURCE, DBA TO chinook;
GRANT ALL PRIVILEGES TO chinook;
EOF"
