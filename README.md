# Trabalho-BD2
## :man_technologist: Desenvolvedores: Fernando Moreira, Rodrigo Barroso, Thiago Mozart e Yuri Nogueira

## :pencil2: Como utilizar?
É possível rodar o servidor do SGBD Oracle utilizando Docker Compose porém nâo é necessário caso utilize o servidor local na própria máquina.
Para utilizar via Docker, execute:  
``` docker compose up```  

Após, execute no terminal o script de geraçâo de usuário para realizar login no SGBD Oracle:  
```./configure.sh```  
***
**Observações: A questão de ponto extra que pede a criação de um novo usuário, o mesmo consta no script configure.sh**     
**O usuário padrão para se conectar ao SGBD Oracle tem usuário chinook e senha p4ssw0rd.**
***  
  
Para popular o schema CHINOOK, execute o arquivo **chinook_oracle.sql**.
