------------------------------------------------------
-- Triggers
------------------------------------------------------

CREATE OR ALTER TRIGGER [dbo].[TRG_inserirValorAtual]
	ON premiacoes
	AFTER INSERT
	AS 
	/*
	Documentação
	Arquivo fonte.....: exercicio.sql
	Objetivo..........: Atualizar valor atual quando houver insert na tabela premiacoes
	Autor.............: SMN - Emanuel Bacalhau
	Data..............: 03/01/2023
	*/
	BEGIN

		DECLARE @empresa_id INT,
				@valor_ranking MONEY,
				@premiacao_id INT

		SELECT	@empresa_id = I.empresa_id,
				@valor_ranking = R.valor,
				@premiacao_id = I.id FROM inserted AS I
				INNER JOIN rankings AS R
					ON I.ranking_id = R.id

		IF @empresa_id IS NOT NULL AND @valor_ranking IS NOT NULL AND @premiacao_id IS NOT NULL
			UPDATE premiacoes
				SET valor_premiacao_atual = [dbo].[FUNC_calcularPremiacaoAtual] (@empresa_id, @valor_ranking)
			WHERE id = @premiacao_id
		
	END
GO