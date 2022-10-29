#!/bin/bash
docker-compose exec oracle-xe sh -c "sqlplus / AS SYSDBA << EOF
ALTER SESSION SET \"_ORACLE_SCRIPT\"=true;
CREATE USER oracle_user IDENTIFIED BY oracle_password;
GRANT CONNECT, RESOURCE, DBA TO oracle_user;
GRANT ALL PRIVILEGES TO oracle_user;
EOF"

docker-compose exec -i oracle-xe sqlplus / -u oracle_user -p oracle_password < ./chinook_oracle.sql
