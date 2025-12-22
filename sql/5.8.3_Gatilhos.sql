DELIMITER / /
-- Gatilho 1: Atualizar estado da viagem e libertar tripulação
CREATE TRIGGER UpdateViagemEstado BEFORE
UPDATE ON Viagem FOR EACH ROW BEGIN
-- Verifica se o estado da viagem passou de 'Em Curso' para um estado final
IF OLD.Estado = 'Em Curso'
AND NEW.Estado IN ('Finalizada', 'Cancelada') THEN
-- Atualiza a data de chegada da viagem automaticamente
SET
   NEW.DataChegada = CURRENT_TIMESTAMP;

-- Desassocia (regista a saída) de todos os tripulantes desta viagem
UPDATE TripulanteViagem
SET
   DataSaida = CURRENT_DATE
WHERE
   Viagem = NEW.ID
   AND DataSaida IS NULL;

END IF;

END / / DELIMITER;

DELIMITER / /
-- Gatilho 2: Fechar participações de tripulantes inativos
CREATE TRIGGER UpdateTripulanteEstado AFTER
UPDATE ON Tripulante FOR EACH ROW BEGIN
-- Verifica se o tripulante passou para 'Inativo'
IF OLD.Estado = 'Ativo'
AND NEW.Estado = 'Inativo' THEN
-- Fecha qualquer participação ativa em viagens
UPDATE TripulanteViagem
SET
   DataSaida = CURRENT_DATE
WHERE
   Tripulante = NEW.ID
   AND DataSaida IS NULL;

END IF;

END / / DELIMITER;