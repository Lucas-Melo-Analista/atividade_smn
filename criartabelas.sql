CREATE TABLE CNAES
(id SMALLINT PRIMARY KEY IDENTITY,
cnae INT NOT NULL
)

CREATE TABLE TIPOS_PREMIACOES 
(id TINYINT PRIMARY KEY IDENTITY,
nome VARCHAR (45)
)

CREATE TABLE RAKINGS 
(id TINYINT PRIMARY KEY IDENTITY,
nome VARCHAR (45) NOT NULL,
valor FLOAT NOT NULL
)

CREATE TABLE EMPRESAS 
(id INT PRIMARY KEY IDENTITY,
razao_social VARCHAR (150) NOT NULL,
nome_fantasia VARCHAR (150) NOT NULL,
cnpj BIGINT NOT NULL,
inscricao_estadual BIGINT,
inscricao_municipal BIGINT NOT NULL,
email VARCHAR (100) NOT NULL,
telefone BIGINT NOT NULL
)

CREATE TABLE PREMIACOES
(id INT PRIMARY KEY IDENTITY,
raking_id TINYINT NOT NULL REFERENCES RAKINGS (id),
tipo_id TINYINT NOT NULL REFERENCES TIPOS_PREMIACOES (id),
empresa_id INT NOT NULL REFERENCES EMPRESAS (id),
valor_premiacao_atual FLOAT,
mes TINYINT NOT NULL,
ano SMALLINT NOT NULL
)

CREATE TABLE CNAES_EMPRESAS
(cnaes_id SMALLINT NOT NULL REFERENCES CNAES (id),
empresa_id INT NOT NULL REFERENCES EMPRESAS (id),
status BIT NOT NULL
)
