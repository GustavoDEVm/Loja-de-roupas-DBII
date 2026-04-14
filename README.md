# Projeto 1 – Modelo de Dados: Loja de Roupas
 
**Disciplina:** Banco de Dados II  
**Professor:** Daniel de Souza Carvalho  
**Equipe:** Emili Vieira Tabuti · Gustavo Macedo Costa
 
---
 
## Sobre o projeto
 
Modelagem e implementação de um banco de dados para um sistema de e-commerce de roupas, desenvolvido como trabalho acadêmico da disciplina de Banco de Dados II (PUC-SP).
 
O banco controla clientes, produtos, variações (tamanho/cor), pedidos, pagamentos e estoque.
 
---
 
## Arquivos
 
| Arquivo | Descrição |
|---|---|
| `loja_roupas.sql` | Script SQL com criação das tabelas e dados de teste |
| `modelo_loja_roupas.mwb` | Diagrama MER (MySQL Workbench) |
| `MER.pdf` | Exportação do diagrama em PDF |
| `html.zip` | Exportação HTML do modelo (DBDoc) |
| `projeto_loja_roupas 1.pdf` | Documentação completa do projeto |
 
---
 
## Banco de dados
 
**8 tabelas:** `cliente`, `endereco`, `categoria`, `produto`, `variacao_produto`, `pedido`, `item_pedido`, `pagamento`
 
```sql
-- Executar no MySQL:
SOURCE loja_roupas.sql;
```
 
---
 
## Tecnologias
 
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white)
![MySQL Workbench](https://img.shields.io/badge/MySQL_Workbench-4479A1?style=flat&logo=mysql&logoColor=white)
