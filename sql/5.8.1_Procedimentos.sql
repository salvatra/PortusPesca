DELIMITER //

CREATE PROCEDURE ConsultarViagensTripulante(IN p_tripulante INT)
BEGIN
    SELECT V.ID AS ViagemID,
           V.PortoOrigem,
           V.PortoDestino,
           V.DataPartida,
           V.Estado,
           TV.Cargo
    FROM TripulanteViagem AS TV
    INNER JOIN Viagem AS V ON TV.Viagem = V.ID
    WHERE TV.Tripulante = p_tripulante;
END //

DELIMITER ;





DELIMITER //

CREATE PROCEDURE ConsultarViagensEmbarcacao(
    IN matricula_embarcacao VARCHAR(8)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Embarcacao WHERE ID = matricula_embarcacao) THEN
        SELECT 'Embarcação não encontrada no sistema.' AS Mensagem;
    ELSE
        SELECT 
            V.ID AS ViagemID,
            V.PortoOrigem,
            V.PortoDestino,
            V.DataPartida,
            V.DataChegada,
            V.Estado,
            V.Descricao,
            E.Nome AS NomeEmbarcacao,
            E.Tipo AS TipoEmbarcacao
        FROM Viagem AS V
        INNER JOIN Embarcacao AS E 
            ON V.Embarcacao = E.ID
        WHERE 
            V.Embarcacao = matricula_embarcacao
        ORDER BY
            V.DataPartida DESC;
            
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
 //