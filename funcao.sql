------------------------------------------------------
-- Função
------------------------------------------------------

CREATE OR ALTER FUNCTION [dbo].[FUNC_calcularPremiacaoAtual] (
	@empresa_id INT,
	@valor_ranking MONEY
)
	RETURNS MONEY
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Deletar cnaes_has_empresas
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	Ex................: SELECT [dbo].[FUNC_calcularPremiacaoAtual] (1, -800)
	*/
	AS 
	BEGIN 

		DECLARE @valor_atual MONEY,
				@calculo MONEY;
		
		SET @valor_atual =(
			SELECT TOP 1 valor_premiacao_atual FROM premiacoes
				WHERE empresa_id = @empresa_id AND
				mes <= (SELECT MAX(mes) FROM premiacoes WHERE empresa_id = @empresa_id) AND
				ano = (SELECT MAX(ano) FROM premiacoes WHERE empresa_id = @empresa_id) AND 
				valor_premiacao_atual IS NOT NULL
			ORDER BY id DESC);

		IF @valor_atual IS NOT NULL
			SET @calculo = @valor_atual + @valor_ranking
		ELSE 
			SET @calculo = @valor_ranking
		
		RETURN @calculo
	END
GO