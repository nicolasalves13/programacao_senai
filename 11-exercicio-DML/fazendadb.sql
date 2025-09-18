create database fazenda_integrada;

use fazenda_integrada;

create table fornecedores_insumos
(
id INT AUTO_INCREMENT NOT NULL primary key,
nome VARCHAR(100)not null,
contato VARCHAR(100),
telefone VARCHAR(20)
);

create table insumos
(
id INT AUTO_INCREMENT primary key,
nome VARCHAR(100) NOT NULL,
tipo ENUM("fertilizante", "defensivo", "semente", "outros") NOT NULL,
unidade_medida VARCHAR(10),
custo_unitario DECIMAL(10,2) NOT NULL
);

create table culturas
(
id INT AUTO_INCREMENT primary key,
nome_cultura VARCHAR(50) NOT NULL UNIQUE,
tempo_colheita_dias INT,
condicoes_ideais VARCHAR(255)
);

create table equipamentos
(
id INT AUTO_INCREMENT primary key,
nome VARCHAR(100) NOT NULL,
tipo VARCHAR(50),
data_aquisicao DATE,
status ENUM('ativo', 'manutencao', 'inativo') DEFAULT 'ativo'
);

create table funcionarios
(
id INT AUTO_INCREMENT primary key,
nome VARCHAR(100) NOT NULL,
funcao VARCHAR(50),
salario DECIMAL(10,2) NOT NULL CHECK(salario > 0),
data_contratacao DATE
);

create table lotes_plantio
(
id INT AUTO_INCREMENT primary key,
fk_cultura INT NOT NULL ,
area_plantada_m2 DECIMAL(10,2) NOT NULL CHECK(area_plantada_m2 > 0),
data_plantio DATE NOT NULL,
data_colheita_prevista DATE,
observacoes VARCHAR(255),
Foreign key(Fk_cultura) references culturas(id)
);

create table estoque_geral
(
id INT AUTO_INCREMENT primary key,
fk_item_tipo ENUM('insumo','produto_colhido') NOT NULL,
fk_item_id int not null,
quantidade DECIMAL(10,3) NOT NULL DEFAULT 0,
data_atualizacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE current_timestamp
);

create table movimentacoes_estoque
(
id INT AUTO_INCREMENT primary key,
fk_estoque INT NOT NULL,
tipo_mov ENUM('entrada','saida','ajuste') NOT NULL,
quantidade DECIMAL(10,3) NOT NULL,check (quantidade > 0),
data_mov DATETIME NOT NULL,
referencia VARCHAR(100),
foreign key (fk_estoque) references estoque_geral(id)
);
create table receitas_aplicacao
(
id int auto_increment primary key,
fk_cultura int,
fk_insumo int,
quantidade decimal(10,2) not null,check (quantidade>0),
frequencia_dias int,

);

-- Inserir dados na tabela `fornecedores_insumos`
INSERT INTO fornecedores_insumos (nome, contato, telefone)
VALUES
('Fertilizantes ABC', 'Carlos Oliveira', '1234-5678'),
('Agro Defensivos Ltda', 'Ana Costa', '9876-5432'),
('Sementes do Campo', 'Lucas Silva', '3456-7890'),
('Distribuidora de Insumos', 'Maria Santos', '8765-4321'),
('Insumos Agropecuários', 'João Pereira', '4567-8901');

-- Inserir dados na tabela `insumos`
INSERT INTO insumos (nome, tipo, unidade_medida, custo_unitario)
VALUES
('Fertilizante NPK', 'fertilizante', 'kg', 120.50),
('Defensivo AgroX', 'defensivo', 'litro', 75.90),
('Semente de Milho', 'semente', 'kg', 45.00),
('Herbicida Green', 'defensivo', 'litro', 50.75),
('Fertilizante Orgânico', 'fertilizante', 'kg', 95.30);

-- Inserir dados na tabela `culturas`
INSERT INTO culturas (nome_cultura, tempo_colheita_dias, condicoes_ideais)
VALUES
('Milho', 90, 'Clima quente e seco, solo bem drenado'),
('Soja', 120, 'Clima temperado, solo rico em nutrientes'),
('Tomate', 75, 'Temperatura amena, solo leve e bem irrigado'),
('Cenoura', 120, 'Clima fresco, solo arenoso e bem irrigado'),
('Arroz', 150, 'Clima quente e úmido, solo alagado');

-- Inserir dados na tabela `equipamentos`
INSERT INTO equipamentos (nome, tipo, data_aquisicao, status)
VALUES
('Trator John Deere', 'Trator', '2022-05-10', 'ativo'),
('Pulverizador HidroJet', 'Pulverizador', '2021-03-15', 'manutencao'),
('Colheitadeira Case IH', 'Colheitadeira', '2023-01-25', 'ativo'),
('Arado de Disco', 'Arado', '2020-08-30', 'inativo'),
('Caminhão de Carga', 'Caminhão', '2022-11-05', 'ativo');

-- Inserir dados na tabela `funcionarios`
INSERT INTO funcionarios (nome, funcao, salario, data_contratacao)
VALUES
('Carlos Souza', 'Agrônomo', 4500.00, '2021-05-15'),
('Fernanda Lima', 'Operadora de Trator', 3000.00, '2020-08-20'),
('José Santos', 'Técnico em Equipamentos', 3500.00, '2022-03-01'),
('Roberta Silva', 'Coordenadora de Produção', 5000.00, '2019-06-10'),
('Marcos Oliveira', 'Assistente Administrativo', 2500.00, '2023-02-25');

-- Inserir dados na tabela `lotes_plantio`
INSERT INTO lotes_plantio (fk_cultura, area_plantada_m2, data_plantio, data_colheita_prevista, observacoes)
VALUES
(1, 1000.00, '2023-06-01', '2023-09-01', 'Lote de milho para colheita em setembro'),
(2, 1500.00, '2023-04-10', '2023-08-10', 'Lote de soja em solo rico em nutrientes'),
(3, 500.00, '2023-05-15', '2023-08-01', 'Tomates para venda em mercados locais'),
(4, 700.00, '2023-07-01', '2023-10-01', 'Lote de cenouras com irrigação constante'),
(5, 1200.00, '2023-02-20', '2023-07-20', 'Lote de arroz com solo alagado');

-- Inserir dados na tabela `estoque_geral`
INSERT INTO estoque_geral (fk_item_tipo, fk_item_id, quantidade, data_atualizacao)
VALUES
('insumo', 1, 500.00, '2023-09-01 10:00:00'),
('insumo', 2, 200.00, '2023-09-01 10:00:00'),
('produto_colhido', 3, 1000.00, '2023-09-01 10:00:00'),
('insumo', 4, 300.00, '2023-09-01 10:00:00'),
('produto_colhido', 5, 1500.00, '2023-09-01 10:00:00');

-- Inserir dados na tabela `movimentacoes_estoque`
INSERT INTO movimentacoes_estoque (fk_estoque, tipo_mov, quantidade, data_mov, referencia)
VALUES
(1, 'entrada', 100.00, '2023-09-01 12:00:00', 'Compra de fertilizante NPK'),
(2, 'saida', 50.00, '2023-09-02 09:30:00', 'Venda de defensivo AgroX'),
(3, 'entrada', 500.00, '2023-09-01 14:00:00', 'Entrada de produto colhido de milho'),
(4, 'ajuste', 20.00, '2023-09-03 10:00:00', 'Ajuste de estoque de herbicida Green'),
(5, 'saida', 1000.00, '2023-09-02 15:00:00', 'Venda de arroz colhido');

