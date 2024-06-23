####  CRIAÇÂO DOS KEYSPACES ####

CREATE KEYSPACE IF NOT EXISTS filial_nyc WITH REPLICATION = {
  'class': 'SimpleStrategy',
  'replication_factor': 3
};

CREATE KEYSPACE IF NOT EXISTS filial_la WITH REPLICATION = {
  'class': 'SimpleStrategy',
  'replication_factor': 3
};

#### PARTICIONAMENTO DOS DADOS ####

USE filial_nyc;

CREATE TABLE produtos (
  product_id UUID PRIMARY KEY,
  nome TEXT,
  categoria TEXT,
  preco DECIMAL,
  estoque INT
);

USE filial_la;

CREATE TABLE produtos (
  product_id UUID PRIMARY KEY,
  nome TEXT,
  categoria TEXT,
  preco DECIMAL,
  estoque INT
);


#### INDEXAÇÃO ####

USE filial_nyc;
CREATE INDEX ON produtos (categoria);

USE filial_la;
CREATE INDEX ON produtos (categoria);

#### SELECT - TESTE DESEMPENHO ####

USE filial_nyc;
SELECT * FROM produtos WHERE categoria='Bebidas';

USE filial_la;
SELECT * FROM produtos WHERE categoria='Laticínios';

#### UPDATE - TESTE DESEMPENHO####

USE filial_nyc;
UPDATE produtos SET estoque = estoque - 10 WHERE product_id=uuid();

USE filial_la;
UPDATE produtos SET estoque = estoque + 20 WHERE product_id=uuid();

#### ADIÇÃO DE NOVAS FILIAIS ####

CREATE KEYSPACE IF NOT EXISTS filial_chicago WITH REPLICATION = {
  'class': 'SimpleStrategy',
  'replication_factor': 3
};

USE filial_chicago;

CREATE TABLE produtos (
  product_id UUID PRIMARY KEY,
  nome TEXT,
  categoria TEXT,
  preco DECIMAL,
  estoque INT
);
