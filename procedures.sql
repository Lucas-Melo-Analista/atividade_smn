USE smningatreinamentogrupo4;

------------------------------------------------------
-- CNAES
------------------------------------------------------

CREATE OR ALTER PROCEDURE [dbo].[PROC_inserirCNAES](
	@cnae INT
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Inserir um novo cnae
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = [dbo].[PROC_inserirCNAES] 123456
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - CNAE já em uso
						2 - Erro na inclusão
	*/
	BEGIN
		-- Verificando se o CNAE já está em uso
		IF EXISTS(SELECT cnae FROM CNAES WHERE cnae = @cnae) RETURN 1

		INSERT INTO CNAES (cnae)
			VALUES (@cnae);

		-- Verificando se possui algum erro
		IF @@ERROR != 0 RETURN 2;

		RETURN 0;
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[PROC_selecionarCNAES](
	@id SMALLINT = NULL,
	@cnae INT = NULL
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Buscar varios cnaes ou apenas um.
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: EXEC [dbo].[PROC_selecionarCNAES] @cnae = 1234567
	*/
	BEGIN
		SELECT * FROM CNAES 
			WHERE	(@id IS NULL OR id = @id) AND
					(@cnae IS NULL OR cnae = @cnae)
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[PROC_atualizarCNAES](
	@id SMALLINT,
	@cnae INT = NULL
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Atualizar cnae.
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = [dbo].[PROC_atualizarCNAES] 2, 1234566
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - CNAES inexistente
						2 - CNAE já em uso
						3 - Erro na atualização
	*/
	BEGIN
		-- Verificando se existe por id
		IF NOT EXISTS(SELECT id FROM CNAES WHERE id = @id) RETURN 1

		-- Verificando se o CNAE já está em uso
		IF EXISTS(SELECT cnae FROM CNAES WHERE cnae = @cnae) RETURN 2
		
		UPDATE CNAES
			SET cnae = COALESCE(@cnae, cnae)
		WHERE id = @id

		-- Verificando se possui algum erro
		IF @@ERROR != 0 RETURN 3;

		RETURN 0;
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[PROC_deletarCNAES](
	@id SMALLINT
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Deletar cnae
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = [dbo].[PROC_deletarCNAES] 2
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - CNAES inexistente
						2 - Erro na atualização
	*/
	BEGIN
		-- Verificando se existe por id
		IF NOT EXISTS(SELECT id FROM CNAES WHERE id = @id) RETURN 1
		
		DELETE FROM CNAES
			WHERE id = @id

		-- Verificando se possui algum erro
		IF @@ERROR != 0 RETURN 2;

		RETURN 0;
	END
GO

------------------------------------------------------
-- TIPOS_PREMIAÇÕES
------------------------------------------------------

CREATE OR ALTER PROCEDURE [dbo].[PROC_inserirTiposPremiacoes](
	@nome VARCHAR(45)
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Inserir um novo tipo de premiação
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = [dbo].[PROC_inserirTiposPremiacoes] '123456'
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - Nome já em uso
						2 - Erro na inclusão
	*/
	BEGIN
		-- Verificando se o NOME já está em uso
		IF EXISTS(SELECT nome FROM TIPOS_PREMIACOES WHERE nome = @nome) RETURN 1

		INSERT INTO TIPOS_PREMIACOES (nome)
			VALUES (@nome);

		-- Verificando se possui algum erro
		IF @@ERROR != 0 RETURN 2;

		RETURN 0;
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[PROC_selecionarTiposPremiacoes](
	@id TINYINT = NULL,
	@nome VARCHAR(45) = NULL
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Buscar varios tipos premiações ou apenas uma.
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: EXEC [dbo].[PROC_selecionarTiposPremiacoes] NULL, '123456'
	*/
	BEGIN
		SELECT * FROM TIPOS_PREMIACOES 
			WHERE	(@id IS NULL OR id = @id) AND
					(@nome IS NULL OR nome = @nome)
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[PROC_atualizarTiposPremiacoes](
	@id SMALLINT,
	@nome VARCHAR(50) = NULL
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Atualizar tipo premiações.
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = [dbo].[PROC_atualizarTiposPremiacoes] 1, '1234566'
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - Tipo inexistente
						2 - Nome já em uso
						3 - Erro na atualização
	*/
	BEGIN
		-- Verificando se existe por id
		IF NOT EXISTS(SELECT id FROM TIPOS_PREMIACOES WHERE id = @id) RETURN 1

		-- Verificando se o NOME já está em uso
		IF EXISTS(SELECT nome FROM TIPOS_PREMIACOES WHERE nome = @nome) RETURN 2
		
		UPDATE TIPOS_PREMIACOES
			SET nome = COALESCE(@nome, nome)
		WHERE id = @id

		-- Verificando se possui algum erro
		IF @@ERROR != 0 RETURN 3;

		RETURN 0;
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[PROC_deletarTiposPremiacoes](
	@id TINYINT
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Deletar cnae
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = [dbo].[PROC_deletarTiposPremiacoes] 5
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - Tipo premiação inexistente
						2 - Erro na atualização
	*/
	BEGIN
		-- Verificando se existe por id
		IF NOT EXISTS(SELECT id FROM TIPOS_PREMIACOES WHERE id = @id) RETURN 1
		
		DELETE FROM TIPOS_PREMIACOES
			WHERE id = @id

		-- Verificando se possui algum erro
		IF @@ERROR != 0 RETURN 2;

		RETURN 0;
	END
GO

------------------------------------------------------
-- RANKING
------------------------------------------------------

CREATE OR ALTER PROCEDURE [dbo].[PROC_inserirRanking](
	@nome VARCHAR(45),
	@valor FLOAT
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Inserir um novo ranking
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = [dbo].[PROC_inserirRanking] 'PREMIAÇÃO 10', -1000
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - Nome já em uso
						2 - Número máximo
						3 - Erro na inclusão
	*/
	BEGIN
		-- Declarando variaves
		DECLARE @contagem TINYINT

		-- Verificando se o NOME já está em uso
		IF EXISTS(SELECT nome FROM RANKINGS WHERE nome = @nome) RETURN 1

		SET @contagem = (SELECT COUNT(*) FROM RANKINGS)

		IF @contagem = 10 RETURN 2

		INSERT INTO RANKINGS (nome, valor)
			VALUES (@nome, @valor);

		-- Verificando se possui algum erro
		IF @@ERROR != 0 RETURN 3;

		RETURN 0;
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[PROC_selecionarRanking](
	@id TINYINT = NULL,
	@nome VARCHAR(45) = NULL,
	@valor FLOAT = NULL
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Buscar varios rankings ou apenas um.
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: EXEC [dbo].[PROC_selecionarRanking] NULL, NULL, -1000
	*/
	BEGIN
		SELECT * FROM RANKINGS 
			WHERE	(@id IS NULL OR id = @id) AND
					(@nome IS NULL OR nome = @nome) AND
					(@valor IS NULL OR valor = @valor)
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[PROC_atualizarRanking](
	@id SMALLINT,
	@nome VARCHAR(50) = NULL,
	@valor FLOAT = NULL
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Atualizar ranking.
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = [dbo].[PROC_atualizarRanking] 10, 'PREMIAÇÃO 10', -1000
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - Ranking inexistente
						2 - Nome já em uso
						3 - Erro na atualização
	*/
	BEGIN
		-- Verificando se existe por id
		IF NOT EXISTS(SELECT id FROM RANKINGS WHERE id = @id) RETURN 1

		-- Verificando se o NOME já está em uso
		IF EXISTS(SELECT nome FROM RANKINGS WHERE nome = @nome) RETURN 2
		
		UPDATE RANKINGS
			SET nome = COALESCE(@nome, nome),
				valor = COALESCE(@valor, valor)
		WHERE id = @id

		-- Verificando se possui algum erro
		IF @@ERROR != 0 RETURN 3;

		RETURN 0;
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[PROC_deletarRanking](
	@id TINYINT
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Deletar ranking
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = [dbo].[PROC_deletarRanking] 10
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - Tipo premiação inexistente
						2 - Erro na atualização
	*/
	BEGIN
		-- Verificando se existe por id
		IF NOT EXISTS(SELECT id FROM RANKINGS WHERE id = @id) RETURN 1

		DELETE FROM PREMIACOES
			WHERE ranking_id = @id
		
		DELETE FROM RANKINGS
			WHERE id = @id

		-- Verificando se possui algum erro
		IF @@ERROR != 0 RETURN 2;

		RETURN 0;
	END
GO

------------------------------------------------------
-- EMPRESAS
------------------------------------------------------

CREATE OR ALTER PROCEDURE [dbo].[PROC_inserirEmpresa](
	@razao_social VARCHAR (150),
	@nome_fantasia VARCHAR (150),
	@cnpj BIGINT,
	@inscricao_estadual BIGINT = NULL,
	@inscricao_municipal BIGINT,
	@email VARCHAR (100),
	@telefone BIGINT
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Inserir um novo ranking
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = [dbo].[PROC_inserirEmpresa] 'teste', 'teste 2', 1234567, NULL, 2545685, 'teste5@teste.com', 89655456
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - CNPJ já em uso
						2 - Inscrição estadual já em uso
						3 - Inscricao Municipal já em uso
						4 - Email já em uso
						5 - Telefone já em uso
						6 - Erro na inclusão
	*/
	BEGIN
		-- Verificando se o NOME já está em uso
		IF EXISTS(SELECT cnpj FROM EMPRESAS WHERE cnpj = @cnpj) RETURN 1

		-- Verificando se a INSCRIÇÃO ESTADUAL já está em uso
		IF @inscricao_estadual IS NOT NULL AND EXISTS(SELECT inscricao_estadual FROM EMPRESAS WHERE inscricao_estadual = @inscricao_estadual) RETURN 2

		-- Verificando se a INSCRIÇÃO MUNICIPAL já está em uso
		IF EXISTS(SELECT inscricao_municipal FROM EMPRESAS WHERE inscricao_municipal = @inscricao_municipal) RETURN 3

		-- Verificando se o EMAIL já está em uso
		IF EXISTS(SELECT email FROM EMPRESAS WHERE email = @email) RETURN 4

		-- Verificando se o TELEFONE já está em uso
		IF EXISTS(SELECT telefone FROM EMPRESAS WHERE telefone = @telefone) RETURN 5

		INSERT INTO EMPRESAS (razao_social, nome_fantasia, cnpj, inscricao_estadual, inscricao_municipal, email, telefone)
			VALUES (@razao_social, @nome_fantasia, @cnpj, @inscricao_estadual, @inscricao_municipal, @email, @telefone);

		-- Verificando se possui algum erro
		IF @@ERROR != 0 RETURN 6;

		RETURN 0;
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[PROC_selecionarEmpresa](
	@id INT = NULL,
	@razao_social VARCHAR (150) = NULL,
	@nome_fantasia VARCHAR (150) = NULL,
	@cnpj BIGINT = NULL,
	@inscricao_estadual BIGINT = NULL,
	@inscricao_municipal BIGINT = NULL,
	@email VARCHAR (100) = NULL,
	@telefone BIGINT = NULL
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Buscar varias empresas ou apenas uma.
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: EXEC [dbo].[PROC_selecionarEmpresa] @cnpj = 123456
	*/
	BEGIN
		SELECT * FROM EMPRESAS 
			WHERE	(@id IS NULL OR id = @id) AND
					(@razao_social IS NULL OR razao_social = @razao_social) AND
					(@nome_fantasia IS NULL OR nome_fantasia = @nome_fantasia) AND
					(@cnpj IS NULL OR cnpj = @cnpj) AND
					(@inscricao_estadual IS NULL OR inscricao_estadual = @inscricao_estadual) AND
					(@inscricao_municipal IS NULL OR inscricao_municipal = @inscricao_municipal) AND
					(@email IS NULL OR inscricao_municipal = @email) AND
					(@telefone IS NULL OR telefone = @telefone)
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[PROC_atualizarEmpresa](
	@id INT,
	@razao_social VARCHAR (150) = NULL,
	@nome_fantasia VARCHAR (150) = NULL,
	@cnpj BIGINT = NULL,
	@inscricao_estadual BIGINT = NULL,
	@inscricao_municipal BIGINT = NULL,
	@email VARCHAR (100) = NULL,
	@telefone BIGINT = NULL
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Atualizar empresa.
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = [dbo].[PROC_atualizarEmpresa] 1, 'PREMIAÇÃO 1'
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - CNPJ já em uso
						2 - Inscrição estadual já em uso
						3 - Inscricao Municipal já em uso
						4 - Email já em uso
						5 - Telefone já em uso
						6 - Erro na atualização
	*/
	BEGIN
		-- Verificando se o NOME já está em uso
		IF EXISTS(SELECT cnpj FROM EMPRESAS WHERE cnpj = @cnpj) RETURN 1

		-- Verificando se a INSCRIÇÃO ESTADUAL já está em uso
		IF @inscricao_estadual IS NOT NULL AND EXISTS(SELECT inscricao_estadual FROM EMPRESAS WHERE inscricao_estadual = @inscricao_estadual) RETURN 2

		-- Verificando se a INSCRIÇÃO MUNICIPAL já está em uso
		IF EXISTS(SELECT inscricao_municipal FROM EMPRESAS WHERE inscricao_municipal = @inscricao_municipal) RETURN 3

		-- Verificando se o EMAIL já está em uso
		IF EXISTS(SELECT email FROM EMPRESAS WHERE email = @email) RETURN 4

		-- Verificando se o TELEFONE já está em uso
		IF EXISTS(SELECT telefone FROM EMPRESAS WHERE telefone = @telefone) RETURN 5
		
		UPDATE EMPRESAS
			SET razao_social = COALESCE(@razao_social, razao_social),
				nome_fantasia = COALESCE(@nome_fantasia, nome_fantasia),
				cnpj = COALESCE(@cnpj, cnpj),
				inscricao_estadual = COALESCE(@inscricao_estadual, inscricao_estadual),
				inscricao_municipal = COALESCE(@inscricao_municipal, inscricao_municipal),
				email = COALESCE(@email, email),
				telefone = COALESCE(@telefone, telefone)
		WHERE id = @id

		-- Verificando se possui algum erro
		IF @@ERROR != 0 RETURN 3;

		RETURN 0;
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[PROC_deletarEmpresa](
	@id INT
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Deletar empresa
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = [dbo].[PROC_deletarEmpresa] 1
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - Tipo premiação inexistente
						2 - Erro na atualização
	*/
	BEGIN
		-- Verificando se existe por id
		IF NOT EXISTS(SELECT id FROM EMPRESAS WHERE id = @id) RETURN 1

		DELETE FROM PREMIACOES
			WHERE empresa_id = @id
		
		DELETE FROM EMPRESAS
			WHERE id = @id

		-- Verificando se possui algum erro
		IF @@ERROR != 0 RETURN 2;

		RETURN 0;
	END
GO

------------------------------------------------------
-- PREMIACOES
------------------------------------------------------

------------------------------------------------------
-- CNAES_EMPRESAS
------------------------------------------------------