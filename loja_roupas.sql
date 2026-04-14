-- =============================================================================
-- PROJETO 1 – MODELO DE DADOS: LOJA DE ROUPAS E-COMMERCE
-- Disciplina: Banco de Dados II
-- Professor: Daniel de Souza Carvalho
-- =============================================================================
-- Este script contém:
--   1. Criação do banco de dados
--   2. Criação de todas as tabelas (com PK e FK)
--   3. Inserção de dados de teste
-- =============================================================================


-- =============================================================================
-- SEÇÃO 1: CRIAÇÃO DO BANCO DE DADOS
-- =============================================================================

CREATE DATABASE IF NOT EXISTS loja_roupas
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE loja_roupas;


-- =============================================================================
-- SEÇÃO 2: CRIAÇÃO DAS TABELAS
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Tabela: cliente
-- Descrição: Armazena os dados dos clientes cadastrados na plataforma.
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS cliente (
  id_cliente INT          AUTO_INCREMENT PRIMARY KEY,
  nome       VARCHAR(100)                           COMMENT 'Nome completo do cliente',
  email      VARCHAR(100)                           COMMENT 'E-mail de contato',
  telefone   VARCHAR(20)                            COMMENT 'Telefone de contato'
) COMMENT = 'Cadastro de clientes da loja';


-- -----------------------------------------------------------------------------
-- Tabela: endereco
-- Descrição: Endereços de entrega associados a um cliente.
--            Um cliente pode ter múltiplos endereços (relação 1:N).
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS endereco (
  id_endereco INT          AUTO_INCREMENT PRIMARY KEY,
  rua         VARCHAR(100)                           COMMENT 'Nome da rua',
  numero      VARCHAR(10)                            COMMENT 'Número do imóvel',
  cidade      VARCHAR(50)                            COMMENT 'Cidade',
  estado      VARCHAR(2)                             COMMENT 'Sigla do estado (UF)',
  id_cliente  INT                                    COMMENT 'FK: cliente ao qual pertence',
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
) COMMENT = 'Endereços de entrega dos clientes';


-- -----------------------------------------------------------------------------
-- Tabela: categoria
-- Descrição: Classifica os produtos em grupos (ex.: Camisetas, Calças).
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS categoria (
  id_categoria INT         AUTO_INCREMENT PRIMARY KEY,
  nome         VARCHAR(50)                           COMMENT 'Nome da categoria'
) COMMENT = 'Categorias dos produtos';


-- -----------------------------------------------------------------------------
-- Tabela: produto
-- Descrição: Produtos disponíveis para venda no catálogo da loja.
--            Cada produto pertence a uma categoria (relação N:1).
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS produto (
  id_produto   INT            AUTO_INCREMENT PRIMARY KEY,
  nome         VARCHAR(100)                            COMMENT 'Nome do produto',
  descricao    TEXT                                    COMMENT 'Descrição detalhada',
  preco        DECIMAL(10,2)                           COMMENT 'Preço de venda (R$)',
  id_categoria INT                                     COMMENT 'FK: categoria do produto',
  FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
) COMMENT = 'Catálogo de produtos da loja';


-- -----------------------------------------------------------------------------
-- Tabela: variacao_produto
-- Descrição: Cada produto pode ter variações de tamanho e cor.
--            O estoque é controlado por variação (ex.: Camiseta M Azul).
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS variacao_produto (
  id_variacao INT         AUTO_INCREMENT PRIMARY KEY,
  tamanho     VARCHAR(5)                           COMMENT 'Tamanho: P, M, G, GG, Único',
  cor         VARCHAR(20)                          COMMENT 'Cor da peça',
  estoque     INT                                  COMMENT 'Quantidade disponível',
  id_produto  INT                                  COMMENT 'FK: produto ao qual pertence',
  FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
) COMMENT = 'Variações de tamanho e cor dos produtos, com controle de estoque';


-- -----------------------------------------------------------------------------
-- Tabela: pedido
-- Descrição: Registra os pedidos realizados por clientes.
--            Status possíveis: Pago, Enviado, Pendente, Cancelado.
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS pedido (
  id_pedido  INT          AUTO_INCREMENT PRIMARY KEY,
  data       DATETIME                              COMMENT 'Data e hora do pedido',
  status     VARCHAR(50)                           COMMENT 'Status: Pago, Enviado, Pendente, Cancelado',
  id_cliente INT                                   COMMENT 'FK: cliente que realizou o pedido',
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
) COMMENT = 'Pedidos realizados pelos clientes';


-- -----------------------------------------------------------------------------
-- Tabela: item_pedido
-- Descrição: Detalha os produtos (variações) de cada pedido.
--            Armazena o preço no momento da compra para histórico fiel.
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS item_pedido (
  id_item         INT            AUTO_INCREMENT PRIMARY KEY,
  quantidade      INT                                     COMMENT 'Quantidade comprada',
  preco_unitario  DECIMAL(10,2)                           COMMENT 'Preço unitário no momento da compra',
  id_pedido       INT                                     COMMENT 'FK: pedido ao qual o item pertence',
  id_variacao     INT                                     COMMENT 'FK: variação do produto adquirida',
  FOREIGN KEY (id_pedido)   REFERENCES pedido(id_pedido),
  FOREIGN KEY (id_variacao) REFERENCES variacao_produto(id_variacao)
) COMMENT = 'Itens individuais de cada pedido';


-- -----------------------------------------------------------------------------
-- Tabela: pagamento
-- Descrição: Registra o pagamento de um pedido.
--            Tipos: Cartão, PIX, Boleto.
--            Status: Aprovado, Pendente, Recusado.
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS pagamento (
  id_pagamento INT         AUTO_INCREMENT PRIMARY KEY,
  tipo         VARCHAR(50)                          COMMENT 'Forma de pagamento: Cartão, PIX, Boleto',
  status       VARCHAR(50)                          COMMENT 'Status: Aprovado, Pendente, Recusado',
  id_pedido    INT                                  COMMENT 'FK: pedido ao qual o pagamento se refere',
  FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
) COMMENT = 'Pagamentos dos pedidos';


-- =============================================================================
-- SEÇÃO 3: CARGA DE DADOS DE TESTE
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 3.1 Clientes
-- -----------------------------------------------------------------------------
INSERT INTO cliente (nome, email, telefone) VALUES
  ('João Silva',   'joao@email.com',   '11999990001'),
  ('Maria Souza',  'maria@email.com',  '11999990002'),
  ('Carlos Lima',  'carlos@email.com', '11999990003'),
  ('Ana Oliveira', 'ana@email.com',    '11999990004'),
  ('Lucas Pereira','lucas@email.com',  '11999990005');


-- -----------------------------------------------------------------------------
-- 3.2 Endereços (um por cliente)
-- -----------------------------------------------------------------------------
INSERT INTO endereco (rua, numero, cidade, estado, id_cliente) VALUES
  ('Rua A', '100', 'São Paulo',       'SP', 1),
  ('Rua B', '200', 'São Paulo',       'SP', 2),
  ('Rua C', '300', 'Campinas',        'SP', 3),
  ('Rua D', '400', 'Rio de Janeiro',  'RJ', 4),
  ('Rua E', '500', 'Belo Horizonte',  'MG', 5);


-- -----------------------------------------------------------------------------
-- 3.3 Categorias
-- -----------------------------------------------------------------------------
INSERT INTO categoria (nome) VALUES
  ('Camisetas'),   -- id 1
  ('Calças'),      -- id 2
  ('Vestidos'),    -- id 3
  ('Jaquetas'),    -- id 4
  ('Acessórios');  -- id 5


-- -----------------------------------------------------------------------------
-- 3.4 Produtos
-- -----------------------------------------------------------------------------
INSERT INTO produto (nome, descricao, preco, id_categoria) VALUES
  ('Camiseta Básica',    'Camiseta de algodão',       49.90,  1),  -- id 1
  ('Camiseta Estampada', 'Camiseta com estampa',      59.90,  1),  -- id 2
  ('Calça Jeans',        'Calça jeans azul',         120.00,  2),  -- id 3
  ('Vestido Floral',     'Vestido leve floral',      150.00,  3),  -- id 4
  ('Jaqueta Couro',      'Jaqueta de couro sintético',300.00, 4),  -- id 5
  ('Boné',               'Boné casual',               35.00,  5);  -- id 6


-- -----------------------------------------------------------------------------
-- 3.5 Variações de produto (tamanho, cor, estoque)
-- -----------------------------------------------------------------------------
INSERT INTO variacao_produto (tamanho, cor, estoque, id_produto) VALUES
  ('P',     'Preto',  20, 1),  -- id 1 | Camiseta Básica P Preta
  ('M',     'Branco', 15, 1),  -- id 2 | Camiseta Básica M Branca
  ('G',     'Azul',   10, 2),  -- id 3 | Camiseta Estampada G Azul
  ('M',     'Azul',    8, 3),  -- id 4 | Calça Jeans M Azul
  ('G',     'Preto',   5, 3),  -- id 5 | Calça Jeans G Preta
  ('M',     'Vermelho',7, 4),  -- id 6 | Vestido Floral M Vermelho
  ('G',     'Marrom',  3, 5),  -- id 7 | Jaqueta Couro G Marrom
  ('Único', 'Preto',  25, 6);  -- id 8 | Boné Único Preto


-- -----------------------------------------------------------------------------
-- 3.6 Pedidos
-- -----------------------------------------------------------------------------
INSERT INTO pedido (data, status, id_cliente) VALUES
  (NOW(), 'Pago',      1),  -- id 1 | João Silva
  (NOW(), 'Enviado',   2),  -- id 2 | Maria Souza
  (NOW(), 'Pendente',  3),  -- id 3 | Carlos Lima
  (NOW(), 'Cancelado', 4),  -- id 4 | Ana Oliveira
  (NOW(), 'Pago',      1),  -- id 5 | João Silva (2º pedido)
  (NOW(), 'Pago',      5);  -- id 6 | Lucas Pereira


-- -----------------------------------------------------------------------------
-- 3.7 Itens dos pedidos
-- -----------------------------------------------------------------------------
INSERT INTO item_pedido (quantidade, preco_unitario, id_pedido, id_variacao) VALUES
  -- Pedido 1 (João Silva – Pago): Camiseta Básica P + Calça Jeans M
  (2, 49.90, 1, 1),   -- 2x Camiseta Básica P Preta
  (1, 120.00, 1, 4),  -- 1x Calça Jeans M Azul

  -- Pedido 2 (Maria Souza – Enviado): Camiseta Estampada + 2 Bonés
  (1, 59.90, 2, 3),   -- 1x Camiseta Estampada G Azul
  (2, 35.00, 2, 8),   -- 2x Boné Único Preto

  -- Pedido 3 (Carlos Lima – Pendente): 3x Camiseta Básica M
  (3, 49.90, 3, 2),   -- 3x Camiseta Básica M Branca

  -- Pedido 4 (Ana Oliveira – Cancelado): Jaqueta Couro
  (1, 300.00, 4, 7),  -- 1x Jaqueta Couro G Marrom

  -- Pedido 5 (João Silva – Pago): 2x Vestido Floral
  (2, 150.00, 5, 6),  -- 2x Vestido Floral M Vermelho

  -- Pedido 6 (Lucas Pereira – Pago): Boné + Camiseta Básica
  (1, 35.00, 6, 8),   -- 1x Boné Único Preto
  (1, 49.90, 6, 1);   -- 1x Camiseta Básica P Preta


-- -----------------------------------------------------------------------------
-- 3.8 Pagamentos
-- -----------------------------------------------------------------------------
INSERT INTO pagamento (tipo, status, id_pedido) VALUES
  ('Cartão', 'Aprovado',  1),  -- Pedido 1 – João (Pago)
  ('PIX',    'Aprovado',  2),  -- Pedido 2 – Maria (Enviado)
  ('Boleto', 'Pendente',  3),  -- Pedido 3 – Carlos (Pendente)
  ('Cartão', 'Recusado',  4),  -- Pedido 4 – Ana (Cancelado)
  ('PIX',    'Aprovado',  5),  -- Pedido 5 – João (Pago)
  ('Cartão', 'Aprovado',  6);  -- Pedido 6 – Lucas (Pago)


-- =============================================================================
-- SEÇÃO 4: QUERIES DE QA (QUESTÕES DE NEGÓCIO)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- QA 1: Faturamento total da loja (apenas pedidos pagos)
-- -----------------------------------------------------------------------------
SELECT SUM(i.quantidade * i.preco_unitario) AS faturamento_total
FROM item_pedido i
JOIN pedido p ON i.id_pedido = p.id_pedido
WHERE p.status = 'Pago';


-- -----------------------------------------------------------------------------
-- QA 2: Clientes que mais gastaram (apenas pedidos pagos)
-- -----------------------------------------------------------------------------
SELECT c.nome, SUM(i.quantidade * i.preco_unitario) AS total_gasto
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
JOIN item_pedido i ON p.id_pedido = i.id_pedido
WHERE p.status = 'Pago'
GROUP BY c.nome
ORDER BY total_gasto DESC;

-- -----------------------------------------------------------------------------
-- QA 3: Categoria que mais vende em quantidade
-- -----------------------------------------------------------------------------
SELECT cat.nome, SUM(i.quantidade) AS total_vendido
FROM item_pedido i
JOIN variacao_produto v   ON i.id_variacao = v.id_variacao
JOIN produto p            ON v.id_produto  = p.id_produto
JOIN categoria cat        ON p.id_categoria = cat.id_categoria
GROUP BY cat.nome
ORDER BY total_vendido DESC;



-- -----------------------------------------------------------------------------
-- QA 4: Ticket médio dos pedidos pagos
-- -----------------------------------------------------------------------------
SELECT ROUND(AVG(total_pedido), 2) AS ticket_medio
FROM (
    SELECT p.id_pedido, SUM(i.quantidade * i.preco_unitario) AS total_pedido
    FROM pedido p
    JOIN item_pedido i ON p.id_pedido = i.id_pedido
    WHERE p.status = 'Pago'
    GROUP BY p.id_pedido
) AS sub;


-- -----------------------------------------------------------------------------
-- QA 5: Produtos com estoque baixo (até 5 unidades)
-- -----------------------------------------------------------------------------
SELECT p.nome AS produto, v.tamanho, v.cor, v.estoque
FROM variacao_produto v
JOIN produto p ON v.id_produto = p.id_produto
WHERE v.estoque <= 5
ORDER BY v.estoque ASC;


-- =============================================================================
-- FIM DO SCRIPT
-- =============================================================================
