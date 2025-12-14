DELIMITER //

CREATE FUNCTION CustoTotalViagem(viagem_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE custo_total DECIMAL(10,2) DEFAULT 0;

    -- Calcular o somatório de todas as despesas da viagem
    SELECT COALESCE(SUM(ABS(Valor)), 0)
    INTO custo_total
    FROM Financeiro
    WHERE Viagem = viagem_id AND Tipo = 'Despesa';

    RETURN custo_total;
END //

DELIMITER ;





DELIMITER //

CREATE FUNCTION CalcularSaldoViagem(viagem_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE saldo DECIMAL(10,2) DEFAULT 0;
    DECLARE total_receitas DECIMAL(10,2) DEFAULT 0;
    DECLARE total_despesas DECIMAL(10,2) DEFAULT 0;

    -- Calcular total de receitas da viagem
    SELECT COALESCE(SUM(Valor), 0)
    INTO total_receitas
    FROM Financeiro
    WHERE Viagem = viagem_id AND Tipo = 'Receita';

    -- Calcular total de despesas da viagem (valor absoluto)
    SELECT COALESCE(SUM(ABS(Valor)), 0)
    INTO total_despesas
    FROM Financeiro
    WHERE Viagem = viagem_id AND Tipo = 'Despesa';

    -- Calcular lucro/prejuízo
    SET saldo = total_receitas - total_despesas;

    RETURN saldo;
END //

DELIMITER ;




