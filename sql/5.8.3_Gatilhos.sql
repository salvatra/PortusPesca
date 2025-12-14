DELIMITER //
CREATE TRIGGER UpdateViagemEstado
BEFORE UPDATE ON Viagem
FOR EACH ROW
BEGIN
    -- Verifica se o estado da viagem passou de 'Em Curso' para um estado final
    IF OLD.Estado = 'Em Curso' AND NEW.Estado IN ('Finalizada', 'Cancelada') THEN
        
        -- Atualiza a data de chegada da viagem automaticamente
        SET NEW.DataChegada = CURRENT_TIMESTAMP;

        -- Desassocia (regista a saída) de todos os tripulantes desta viagem
        UPDATE TripulanteViagem
        SET DataSaida = CURRENT_DATE
        WHERE Viagem = NEW.ID AND DataSaida IS NULL;
        
    END IF;
END //
DELIMITER ;





DELIMITER //

CREATE PROCEDURE CriaTripulanteEViagem (
   -- Dados do Tripulante
   IN p_nome VARCHAR(150),
   IN p_cedula VARCHAR(30),
   IN p_salario DECIMAL(10,2),

   -- Dados da Viagem
   IN p_embarcacao VARCHAR(8),
   IN p_origem VARCHAR(50),
   IN p_destino VARCHAR(50),
   IN p_descricao TEXT,

   -- Associação
   IN p_cargo ENUM(
      'Capitão','Imediato','Oficial de Navegação','Engenheiro',
      'Mestre de Redes','Maquinista','Cozinheiro','Marinheiro'
   ),

   OUT msg VARCHAR(255)
)
BEGIN
   DECLARE v_tripulante_id INT;
   DECLARE v_viagem_id INT;

   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
      ROLLBACK;
      SET msg = 'Erro ao criar tripulante e viagem.';
   END;

   START TRANSACTION;

   -- 1. Criar Tripulante
   INSERT INTO Tripulante
      (CedulaMarinha, Nome, DataNascimento, Salario, Estado)
   VALUES
      (p_cedula, p_nome, '1990-01-01', p_salario, 'Ativo');

   SET v_tripulante_id = LAST_INSERT_ID();

   -- Nacionalidade default
   INSERT INTO Nacionalidade (Tripulante, Nacionalidade)
   VALUES (v_tripulante_id, 'Portuguesa');

   -- 2. Criar Viagem
   INSERT INTO Viagem
      (Embarcacao, PortoOrigem, PortoDestino, Descricao, DataPartida, Estado)
   VALUES
      (p_embarcacao, p_origem, p_destino, p_descricao, NOW(), 'Em Curso');

   SET v_viagem_id = LAST_INSERT_ID();

   -- 3. Associar Tripulante à Viagem
   INSERT INTO TripulanteViagem
      (Tripulante, Viagem, Cargo, DataEntrada)
   VALUES
      (v_tripulante_id, v_viagem_id, p_cargo, CURDATE());

   COMMIT;

   SET msg = CONCAT(
      'Tripulante ID ', v_tripulante_id,
      ' e Viagem ID ', v_viagem_id,
      ' criados com sucesso.'
   );
END //

DELIMITER ;





DELIMITER //
CREATE TRIGGER UpdateTripulanteEstado
AFTER UPDATE ON Tripulante
FOR EACH ROW
BEGIN
    -- Verifica se o tripulante passou para 'Inativo'
    IF OLD.Estado = 'Ativo' AND NEW.Estado = 'Inativo' THEN
        
        -- Fecha qualquer participação ativa em viagens
        UPDATE TripulanteViagem
        SET DataSaida = CURRENT_DATE
        WHERE Tripulante = NEW.ID AND DataSaida IS NULL;
        
    END IF;
END //
DELIMITER ;