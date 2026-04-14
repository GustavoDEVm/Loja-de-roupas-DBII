# 📦 Projeto 1 – Modelo de Dados E-Commerce (Loja de Roupas)

## 👥 Equipe

* Emili Vieira Tabuti
* Gustavo Macedo Costa 

---
⚙️ Tecnologias Utilizadas
MySQL
MySQL Workbench
SQL

## 📌 1. Sumário Executivo

Este projeto tem como objetivo a modelagem e implementação de um banco de dados para um sistema de **E-Commerce de Roupas**, contemplando as etapas de modelagem conceitual e física, além da documentação de engenharia de software.

O sistema permite:

* Cadastro de clientes
* Gerenciamento de produtos e categorias
* Controle de variações (tamanho e cor)
* Realização de pedidos
* Registro de pagamentos
* Armazenamento de endereços

A modelagem foi desenvolvida visando organização, integridade dos dados e suporte a consultas de negócio.

---

## 🔄 2. DFD – Diagrama de Fluxo de Dados (Nível 0)

### 📊 Descrição:

O sistema possui como principal ator o **Cliente**, que interage com o sistema de e-commerce realizando consultas e compras.

### 🔁 Fluxos:

* Cliente → Sistema: dados de cadastro e pedidos
* Sistema → Banco de Dados: armazenamento e consulta
* Sistema → Pagamento: processamento de transações

---

## 🧠 3. Modelo de Dados Conceitual

### 📌 Entidades:

* Cliente
* Endereço
* Produto
* Categoria
* Variação de Produto
* Pedido
* Item do Pedido
* Pagamento

### 🔗 Relacionamentos:

* Cliente realiza Pedido
* Pedido possui Itens
* Produto pertence a Categoria
* Produto possui Variações
* Pedido possui Pagamento
* Cliente possui Endereço

---

## 🧱 4. Modelo de Dados Físico (MER)

O modelo físico foi implementado utilizando o **MySQL Workbench**, com definição de:

* Tabelas
* Colunas
* Tipos de dados
* Chaves primárias (PK)
* Chaves estrangeiras (FK)
* Restrições de integridade

📌 Arquivos entregues:

* Diagrama MER (PDF)
* Arquivo `.mwb`
* Exportação HTML

---

## 📚 5. Dicionário de Dados

### 🔹 Tabela: cliente

| Campo      | Tipo    | Descrição           |
| ---------- | ------- | ------------------- |
| id_cliente | INT     | Identificador único |
| nome       | VARCHAR | Nome do cliente     |
| email      | VARCHAR | Email               |
| telefone   | VARCHAR | Telefone            |

---

### 🔹 Tabela: produto

| Campo        | Tipo    | Descrição                |
| ------------ | ------- | ------------------------ |
| id_produto   | INT     | Identificador do produto |
| nome         | VARCHAR | Nome do produto          |
| preco        | DECIMAL | Valor do produto         |
| id_categoria | INT     | Categoria associada      |

---

### 🔹 Tabela: variacao_produto

| Campo       | Tipo    | Descrição             |
| ----------- | ------- | --------------------- |
| id_variacao | INT     | Identificador         |
| tamanho     | VARCHAR | Tamanho da roupa      |
| cor         | VARCHAR | Cor                   |
| estoque     | INT     | Quantidade disponível |

---

## 💻 6. Script de Criação do Banco (SQL)

O script SQL contempla:

* Criação do banco de dados
* Criação das tabelas
* Definição de chaves primárias e estrangeiras
* Inserção de dados de teste

📄 Arquivo entregue:

* `script.sql` (comentado)

---

## 📊 7. QA – Perguntas de Negócio e Queries

### ❓ 1. Produtos mais vendidos

```sql id="c9pkkc"
SELECT p.nome, SUM(i.quantidade) AS total_vendido
FROM item_pedido i
JOIN variacao_produto v ON i.id_variacao = v.id_variacao
JOIN produto p ON v.id_produto = p.id_produto
GROUP BY p.nome;
```

---

### ❓ 2. Total gasto por cliente

```sql id="b1ifvh"
SELECT c.nome, SUM(i.quantidade * i.preco_unitario) AS total_gasto
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
JOIN item_pedido i ON p.id_pedido = i.id_pedido
GROUP BY c.nome;
```

---

### ❓ 3. Tamanho mais vendido

```sql id="j1h91g"
SELECT v.tamanho, SUM(i.quantidade) AS total
FROM item_pedido i
JOIN variacao_produto v ON i.id_variacao = v.id_variacao
GROUP BY v.tamanho;
```

---

## 📁 8. Estrutura do Repositório

```id="4hb7eh"
📦 projeto-ecommerce
 ┣ 📄 README.md
 ┣ 📄 script.sql
 ┣ 📄 dicionario_dados.pdf
 ┣ 📄 MER.pdf
 ┣ 📄 DFD.pdf
 ┣ 📄 modelo.mwb
```

---

## 📌 9. Considerações Finais

A modelagem de dados é uma etapa fundamental no desenvolvimento de sistemas, pois define a estrutura e integridade das informações.

O projeto foi desenvolvido seguindo boas práticas de modelagem, garantindo:

* Consistência dos dados
* Facilidade de manutenção
* Suporte a consultas de negócio

