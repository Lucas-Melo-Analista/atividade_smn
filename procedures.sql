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
						EXEC @resultado = [dbo].[PROC_inserirCNAES] 1234567
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - CNAE já em uso
						2 - Erro na inclusão
	*/
	BEGIN
		-- Verificando se o CNAE já está em uso
		IF EXISTS(SELECT cnae FROM CNAES WHERE cnae = @cnae) RETURN 1;

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
		SELECT * FROM cnaes 
			WHERE	(@id IS NULL OR id = @id) AND
					(@cnae IS NULL OR cnae = @cnae);
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
		IF NOT EXISTS(SELECT id FROM cnaes  WHERE id = @id) RETURN 1;

		-- Verificando se o CNAE já está em uso
		IF EXISTS(SELECT cnae FROM cnaes WHERE cnae = @cnae) RETURN 2;
		
		UPDATE cnaes
			SET cnae = COALESCE(@cnae, cnae)
		WHERE id = @id;

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
						EXEC @resultado = [dbo].[PROC_deletarCNAES] 1
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - CNAES inexistente
						2 - Erro na atualização
	*/
	BEGIN
		-- Verificando se existe por id
		IF NOT EXISTS(SELECT id FROM CNAES WHERE id = @id) RETURN 1;

		DELETE FROM cnaes_has_empresas	
			WHERE cnaes_id = @id;
		
		DELETE FROM cnaes
			WHERE id = @id;

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
						EXEC @resultado = [dbo].[PROC_inserirTiposPremiacoes] 'Organização'
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - Nome já em uso
						2 - Erro na inclusão
	*/
	BEGIN
		-- Verificando se o NOME já está em uso
		IF EXISTS(SELECT nome FROM tipos_premiacoes WHERE nome = @nome) RETURN 1;

		INSERT INTO tipos_premiacoes (nome)
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
		SELECT * FROM tipos_premiacoes 
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
		IF NOT EXISTS(SELECT id FROM tipos_premiacoes WHERE id = @id) RETURN 1;

		-- Verificando se o NOME já está em uso
		IF EXISTS(SELECT nome FROM tipos_premiacoes WHERE nome = @nome) RETURN 2;
		
		UPDATE tipos_premiacoes
			SET nome = COALESCE(@nome, nome)
		WHERE id = @id;

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
						EXEC @resultado = [dbo].[PROC_deletarTiposPremiacoes] 1
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - Tipo premiação inexistente
						2 - Erro na atualização
	*/
	BEGIN
		-- Verificando se existe por id
		IF NOT EXISTS(SELECT id FROM TIPOS_PREMIACOES WHERE id = @id) RETURN 1;

		DELETE FROM premiacoes
			WHERE tipo_id = @id;
		
		DELETE FROM tipos_premiacoes
			WHERE id = @id;

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
	@valor MONEY
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
		DECLARE @contagem TINYINT;

		-- Verificando se o NOME já está em uso
		IF EXISTS(SELECT nome FROM rankings WHERE nome = @nome) RETURN 1;

		SET @contagem = (SELECT COUNT(*) FROM rankings);

		IF @contagem = 10 RETURN 2;

		INSERT INTO rankings (nome, valor)
			VALUES (@nome, @valor);

		-- Verificando se possui algum erro
		IF @@ERROR != 0 RETURN 3;

		RETURN 0;
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[PROC_selecionarRanking](
	@id TINYINT = NULL,
	@nome VARCHAR(45) = NULL,
	@valor MONEY = NULL
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
		SELECT	id AS coidigo,
				nome,
				valor FROM rankings 
			WHERE	(@id IS NULL OR id = @id) AND
					(@nome IS NULL OR nome = @nome) AND
					(@valor IS NULL OR valor = @valor);
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[PROC_atualizarRanking](
	@id SMALLINT,
	@nome VARCHAR(50) = NULL,
	@valor MONEY = NULL
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Atualizar ranking.
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = [dbo].[PROC_atualizarRanking] 2, NULL, -300
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - Ranking inexistente
						2 - Nome já em uso
						3 - Erro na atualização
	*/
	BEGIN
		-- Verificando se existe por id
		IF NOT EXISTS(SELECT id FROM rankings WHERE id = @id) RETURN 1;

		-- Verificando se o NOME já está em uso
		IF EXISTS(SELECT nome FROM rankings WHERE nome = @nome) RETURN 2;
		
		UPDATE rankings
			SET nome = COALESCE(@nome, nome),
				valor = COALESCE(@valor, valor)
		WHERE id = @id;

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
						EXEC @resultado = [dbo].[PROC_deletarRanking] 2
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - Tipo premiação inexistente
						2 - Erro na atualização
	*/
	BEGIN
		-- Verificando se existe por id
		IF NOT EXISTS(SELECT id FROM rankings WHERE id = @id) RETURN 1;

		DELETE FROM PREMIACOES
			WHERE ranking_id = @id;
		
		DELETE FROM rankings
			WHERE id = @id;

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
						EXEC @resultado = [dbo].[PROC_inserirEmpresa] 'teste', 'teste 5', 123456589, 123, 2545685441, 'teste465@teste.com', 69655452
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
		IF EXISTS(SELECT cnpj FROM empresas WHERE cnpj = @cnpj) RETURN 1;

		-- Verificando se a INSCRIÇÃO ESTADUAL já está em uso
		IF @inscricao_estadual IS NOT NULL AND EXISTS(SELECT inscricao_estadual FROM empresas WHERE inscricao_estadual = @inscricao_estadual) RETURN 2;

		-- Verificando se a INSCRIÇÃO MUNICIPAL já está em uso
		IF EXISTS(SELECT inscricao_municipal FROM empresas WHERE inscricao_municipal = @inscricao_municipal) RETURN 3;

		-- Verificando se o EMAIL já está em uso
		IF EXISTS(SELECT email FROM empresas WHERE email = @email) RETURN 4;

		-- Verificando se o TELEFONE já está em uso
		IF EXISTS(SELECT telefone FROM empresas WHERE telefone = @telefone) RETURN 5;

		INSERT INTO empresas (razao_social, nome_fantasia, cnpj, inscricao_estadual, inscricao_municipal, email, telefone)
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
	Ex................: EXEC [dbo].[PROC_selecionarEmpresa] @cnpj = 12345658
	*/
	BEGIN
		SELECT	E.nome_fantasia, 
				E.cnpj, 
				CASE WHEN E.inscricao_estadual IS NOT NULL THEN E.inscricao_estadual ELSE '-' END AS inscricao_estadual, 
				E.inscricao_municipal, 
				E.email,
				CASE WHEN CE.status = 1 THEN CONCAT(C.cnae, ' - ', E.razao_social) ELSE 'Não possui CNAE principal' END AS 'cnae'
			FROM empresas AS E
				INNER JOIN cnaes_has_empresas AS CE
					ON CE.empresa_id = E.id
				INNER JOIN cnaes AS C
					ON C.id = CE.cnaes_id
			WHERE	(@id IS NULL OR E.id = @id) AND
					(@razao_social IS NULL OR E.razao_social = @razao_social) AND
					(@nome_fantasia IS NULL OR E.nome_fantasia = @nome_fantasia) AND
					(@cnpj IS NULL OR E.cnpj = @cnpj) AND
					(@inscricao_estadual IS NULL OR E.inscricao_estadual = @inscricao_estadual) AND
					(@inscricao_municipal IS NULL OR E.inscricao_municipal = @inscricao_municipal) AND
					(@email IS NULL OR E.email = @email) AND
					(@telefone IS NULL OR E.telefone = @telefone);
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
						EXEC @resultado = [dbo].[PROC_atualizarEmpresa] 15, 'PREMIAÇÃO 1'
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - Empresa inexistente
						2 - CNPJ já em uso
						3 - Inscrição estadual já em uso
						4 - Inscricao Municipal já em uso
						5 - Email já em uso
						6 - Telefone já em uso
						7 - Erro na atualização
	*/
	BEGIN
		-- Verificando se o NOME já está em uso
		IF NOT EXISTS(SELECT id FROM empresas WHERE id = @id) RETURN 1;

		-- Verificando se o NOME já está em uso
		IF EXISTS(SELECT cnpj FROM empresas WHERE cnpj = @cnpj) RETURN 2;

		-- Verificando se a INSCRIÇÃO ESTADUAL já está em uso
		IF @inscricao_estadual IS NOT NULL AND EXISTS(SELECT inscricao_estadual FROM empresas WHERE inscricao_estadual = @inscricao_estadual) RETURN 3;

		-- Verificando se a INSCRIÇÃO MUNICIPAL já está em uso
		IF EXISTS(SELECT inscricao_municipal FROM empresas WHERE inscricao_municipal = @inscricao_municipal) RETURN 4;

		-- Verificando se o EMAIL já está em uso
		IF EXISTS(SELECT email FROM empresas WHERE email = @email) RETURN 5;

		-- Verificando se o TELEFONE já está em uso
		IF EXISTS(SELECT telefone FROM empresas WHERE telefone = @telefone) RETURN 6;
		
		UPDATE empresas
			SET razao_social = COALESCE(@razao_social, razao_social),
				nome_fantasia = COALESCE(@nome_fantasia, nome_fantasia),
				cnpj = COALESCE(@cnpj, cnpj),
				inscricao_estadual = COALESCE(@inscricao_estadual, inscricao_estadual),
				inscricao_municipal = COALESCE(@inscricao_municipal, inscricao_municipal),
				email = COALESCE(@email, email),
				telefone = COALESCE(@telefone, telefone)
		WHERE id = @id;

		-- Verificando se possui algum erro
		IF @@ERROR != 0 RETURN 7;

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
		IF NOT EXISTS(SELECT id FROM empresas WHERE id = @id) RETURN 1;

		DELETE FROM premiacoes
			WHERE empresa_id = @id;

		DELETE FROM cnaes_has_empresas
			WHERE empresa_id = @id;
		
		DELETE FROM empresas
			WHERE id = @id;

		-- Verificando se possui algum erro
		IF @@ERROR != 0 RETURN 2;

		RETURN 0;
	END
GO

------------------------------------------------------
-- PREMIACOES
------------------------------------------------------

CREATE OR ALTER PROCEDURE [dbo].[PROC_inserirPremiacoes](
	@ranking_id TINYINT,
	@tipo_id TINYINT,
	@empresa_id INT,
	@mes TINYINT,
	@ano SMALLINT
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Inserir uma nova premiação
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = [dbo].[PROC_inserirPremiacoes] 9, 2, 1, 3, 2024
						SELECT @resultado
						SELECT * FROM premiacoes
	Retornos..........: 0 - OK
						1 - Empresa inexistente
						2 - Tipo de premiação inexistente
						3 - Ranking inexistente
						4 - Mês inválido
						5 - Ano inválido
						6 - Empresa já possui registro com uma premiação do mesmo tipo e ranking neste mês e ano
						7 - Erro na inclusão
	*/
	BEGIN
		-- Declarando variáveis
		DECLARE @empresaTRMA INT

		-- Verificar se a empresa existe
		IF NOT EXISTS(SELECT id FROM empresas WHERE id = @empresa_id) RETURN 1

		-- Verificar se o tipo de premição
		IF NOT EXISTS(SELECT id FROM tipos_premiacoes WHERE id = @tipo_id) RETURN 2

		-- Verificar se ranking existe
		IF NOT EXISTS(SELECT id FROM rankings WHERE id = @ranking_id) RETURN 3

		-- Verificar se o mês é menor ou igual que 0 ou maior que 12
		IF (@mes <= 0 OR @mes > 12) RETURN 4

		-- Verificar se o ano é maior ou menor que o ano atual
		IF (@ano < YEAR(GETDATE()) OR @ano > YEAR(GETDATE())) RETURN 5

		-- Setando valor na variável
		SET @empresaTRMA =	(SELECT id FROM premiacoes 
									WHERE 
										empresa_id = @empresa_id AND 
										mes = @mes AND 
										ano = @ano AND 
										tipo_id = @tipo_id AND
										ranking_id = @ranking_id
							)
		-- Verificar se a empresa já possui uma premição com o mesmo tipo, ranking, no mesmo mês e ano
		IF (@empresaTRMA IS NOT NULL) RETURN 6

		INSERT INTO premiacoes (empresa_id, tipo_id, ranking_id, ano, mes)
			VALUES (@empresa_id, @tipo_id, @ranking_id, @ano, @mes)

		-- Verificar se houve erro
		IF (@@ERROR != 0) RETURN 7

		RETURN 0;
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[PROC_selecionarPremiacao](
	@tipo_id TINYINT,
	@ranking_id TINYINT = NULL,
	@empresa_id INT = NULL,
	@mes TINYINT = NULL,
	@ano SMALLINT = NULL
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Buscar varias premições ou apenas uma.
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: EXEC [dbo].[PROC_selecionarPremiacao] 2
	*/
	BEGIN
		SELECT 
				R.nome AS Ranking,
				E.nome_fantasia AS Empresa,
				E.cnpj,
				TP.nome AS 'Tipo Premiação',
				FORMAT(P.valor_premiacao_atual, 'c') AS 'Faturamento Mensal',
				CONCAT(P.mes, '/', P.ano) AS 'Mês e Ano'
			FROM premiacoes AS P
			INNER JOIN tipos_premiacoes AS TP
				ON TP.id = P.tipo_id
			INNER JOIN rankings AS R
				ON P.ranking_id = R.id
			INNER JOIN empresas AS E
				ON E.id = P.empresa_id
			WHERE	P.tipo_id = @tipo_id AND
					(@ranking_id IS NULL OR P.ranking_id = @ranking_id) AND
					(@empresa_id IS NULL OR P.empresa_id = @empresa_id) AND
					(@mes IS NULL OR P.mes = @mes) AND
					(@ano IS NULL OR P.ano = @ano)
			ORDER BY P.valor_premiacao_atual DESC
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[PROC_atualizarPremiacao](
	@id INT,
	@ranking_id TINYINT = NULL,
	@tipo_id TINYINT = NULL,
	@empresa_id INT = NULL,
	@mes TINYINT = NULL,
	@ano SMALLINT = NULL
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Atualizar premiação.
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = [dbo].[PROC_atualizarPremiacao] 11, 2
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - Premiação inexistente
						2 - Empresa inexistente
						3 - Tipo de premiação inexistente
						4 - Ranking inexistente
						5 - Mês inválido
						6 - Ano inválido
						7 - Empresa já possui registro com uma premiação do mesmo tipo e ranking neste mês e ano
						8 - Erro na atualização
	*/
	BEGIN
		-- Declarando variáveis
		DECLARE @empresaTRMA INT

		-- Verificar se a premição existe
		IF (NOT EXISTS(SELECT id FROM premiacoes WHERE id = @id)) RETURN 1

		-- Verificar se a empresa existe
		IF (NOT EXISTS(SELECT id FROM empresas WHERE id = @empresa_id)) RETURN 2

		-- Verificar se o tipo de premição
		IF (NOT EXISTS(SELECT id FROM tipos_premiacoes WHERE id = @tipo_id)) RETURN 3

		-- Verificar se ranking existe
		IF (NOT EXISTS(SELECT id FROM rankings WHERE id = @ranking_id)) RETURN 4

		-- Verificar se o mês é menor ou igual que 0 ou maior que 12
		IF (@mes <= 0 OR @mes > 12) RETURN 5

		-- Verificar se o ano é maior ou menor que o ano atual
		IF (@ano < YEAR(GETDATE()) OR @ano > YEAR(GETDATE())) RETURN 6

		-- Setando valor na variável
		SET @empresaTRMA =	(SELECT id FROM premiacoes 
									WHERE 
										empresa_id = @empresa_id AND 
										mes = @mes AND 
										ano = @ano AND 
										tipo_id = @tipo_id AND
										ranking_id = @ranking_id
							)
		-- Verificar se a empresa já possui uma premição com o mesmo tipo, ranking, no mesmo mês e ano
		IF (@empresaTRMA IS NOT NULL) RETURN 7

		UPDATE premiacoes
			SET ranking_id = COALESCE(@ranking_id, ranking_id),
				tipo_id = COALESCE(@tipo_id, @tipo_id),
				empresa_id = COALESCE(@empresa_id, empresa_id),
				ano = COALESCE(@ano, ano),
				mes = COALESCE(@mes, mes)
		WHERE id = @id

		-- Verificar se houve erro
		IF @@ERROR != 0 RETURN 8;

		RETURN 0;
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[PROC_deletarPremiacao](
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
						EXEC @resultado = [dbo].[PROC_deletarPremiacao] 1
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - Premiação inexistente
						2 - Erro na deleção
	*/
	BEGIN
		-- Verificando se existe por id
		IF NOT EXISTS(SELECT id FROM premiacoes WHERE id = @id) RETURN 1

		DELETE FROM PREMIACOES
			WHERE id = @id

		-- Verificando se possui algum erro
		IF @@ERROR != 0 RETURN 2;

		RETURN 0;
	END
GO

------------------------------------------------------
-- CNAES_HAS_EMPRESAS
------------------------------------------------------

CREATE OR ALTER PROCEDURE [dbo].[PROC_inserirCnaeHasEmpresa](
	@cnaes_id TINYINT,
	@empresa_id INT,
	@status BIT
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Inserir uma nova premiação
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = [dbo].[PROC_inserirCnaeHasEmpresa] 1, 2, 1
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - Empresa inexistente
						2 - Cnaes inexistente
						3 - A empresa já possui um cnaes principal
						4 - Erro na inclusão
	*/
	BEGIN
		-- Verificar se a empresa existe
		IF (NOT EXISTS(SELECT id FROM empresas WHERE id = @empresa_id)) RETURN 1

		-- Verificar se o cnaes existe
		IF (NOT EXISTS(SELECT id FROM cnaes WHERE id = @cnaes_id)) RETURN 2

		-- Verificar se a empresa possui cnaes algum principal
		IF @status = 1 AND EXISTS(SELECT cnaes_id FROM cnaes_has_empresas WHERE empresa_id = @empresa_id AND status = 1) RETURN 3
		
		INSERT INTO cnaes_has_empresas(empresa_id, cnaes_id, status)
			VALUES (@empresa_id, @cnaes_id, @status)

		-- Verificar se houve erro
		IF (@@ERROR != 0) RETURN 4

		RETURN 0;
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[PROC_selecionarCnaeHasEmpresa](
	@cnaes_id TINYINT = NULL,
	@empresa_id INT = NULL,
	@status BIT = NULL
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Buscar varias cnaes_has_empresas ou apenas um.
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: EXEC [dbo].[PROC_selecionarCnaeHasEmpresa] @status = 1
	*/
	BEGIN
		SELECT * FROM cnaes_has_empresas 
			WHERE	(@cnaes_id IS NULL OR cnaes_id = @cnaes_id) AND
					(@empresa_id IS NULL OR empresa_id = @empresa_id) AND
					(@status IS NULL OR status = @status)
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[PROC_atualizarCnaeHasEmpresa](
	@id SMALLINT,
	@cnaes_id TINYINT = NULL,
	@empresa_id INT = NULL,
	@status BIT = NULL
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Atualizar premiação.
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = [dbo].[PROC_atualizarCnaeHasEmpresa] 2, 1, 1, 0
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - Inexistente
						2 - Cnaes inexistente
						3 - Empresa inexistente
						4 - A empresa já possui um cnaes principal
						5 - Erro na atualização
	*/
	BEGIN
		-- Verificar se a empresa existe
		IF (NOT EXISTS(SELECT id FROM cnaes_has_empresas WHERE id = @id)) RETURN 1

		-- Verificar se o cnaes existe
		IF (@cnaes_id IS NOT NULL) AND (NOT EXISTS(SELECT id FROM cnaes WHERE id = @cnaes_id)) RETURN 2

		-- Verificar se a empresa existe
		IF (@empresa_id IS NOT NULL) AND (NOT EXISTS(SELECT id FROM empresas WHERE id = @empresa_id)) RETURN 3


		-- Verificar se a empresa possui cnaes algum principal
		IF @status = 1 AND EXISTS(SELECT cnaes_id FROM cnaes_has_empresas WHERE empresa_id = @empresa_id AND status = 1) RETURN 4
		
		UPDATE cnaes_has_empresas
			SET cnaes_id = COALESCE(@cnaes_id, cnaes_id),
				empresa_id = COALESCE(@empresa_id, empresa_id),
				status = COALESCE(@status, status)
		WHERE id = @id

		-- Verificar se houve erro
		IF @@ERROR != 0 RETURN 5;

		RETURN 0;
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[PROC_deletarCnaeHasEmpresa](
	@id INT
)
	AS
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Deletar cnaes_has_empresas
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: DECLARE @resultado TINYINT
						EXEC @resultado = [dbo].[PROC_deletarCnaeHasEmpresa] 1
						SELECT @resultado
	Retornos..........: 0 - OK
						1 - Inexistente
						2 - Erro na deleção
	*/
	BEGIN
		-- Verificando se existe por id
		IF NOT EXISTS(SELECT id FROM cnaes_has_empresas WHERE id = @id) RETURN 1

		DELETE FROM cnaes_has_empresas
			WHERE id = @id

		-- Verificando se possui algum erro
		IF @@ERROR != 0 RETURN 2;

		RETURN 0;
	END
GO
