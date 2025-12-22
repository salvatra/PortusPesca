DELIMITER / / CREATE PROCEDURE CriaTripulanteEViagem (
   -- Dados do Tripulante
   IN p_nome VARCHAR(150),
   IN p_cedula VARCHAR(30),
   IN p_data_nascimento DATE,
   IN p_salario DECIMAL(10, 2),
   -- Dados da Viagem
   IN p_embarcacao VARCHAR(8),
   IN p_origem VARCHAR(50),
   IN p_destino VARCHAR(50),
   IN p_descricao TEXT,
   -- Associação
   IN p_cargo ENUM (
      'Capitão',
      'Imediato',
      'Oficial de Navegação',
      'Engenheiro',
      'Mestre de Redes',
      'Maquinista',
      'Cozinheiro',
      'Marinheiro'
   ),
   OUT msg VARCHAR(255)
) BEGIN DECLARE v_tripulante_id INT;

DECLARE v_viagem_id INT;

DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK;

SET
   msg = 'Erro ao criar tripulante e viagem.';

END;

START TRANSACTION;

-- 1. Criar Tripulante (AGORA USA A DATA RECEBIDA)
INSERT INTO
   Tripulante (
      CedulaMarinha,
      Nome,
      DataNascimento,
      Salario,
      Estado
   )
VALUES
   (
      p_cedula,
      p_nome,
      p_data_nascimento,
      p_salario,
      'Ativo'
   );

SET
   v_tripulante_id = LAST_INSERT_ID ();

-- Nacionalidade default
INSERT INTO
   Nacionalidade (Tripulante, Nacionalidade)
VALUES
   (v_tripulante_id, 'Portuguesa');

-- 2. Criar Viagem
INSERT INTO
   Viagem (
      Embarcacao,
      PortoOrigem,
      PortoDestino,
      Descricao,
      DataPartida,
      Estado
   )
VALUES
   (
      p_embarcacao,
      p_origem,
      p_destino,
      p_descricao,
      NOW (),
      'Em Curso'
   );

SET
   v_viagem_id = LAST_INSERT_ID ();

-- 3. Associar Tripulante à Viagem
INSERT INTO
   TripulanteViagem (Tripulante, Viagem, Cargo, DataEntrada)
VALUES
   (v_tripulante_id, v_viagem_id, p_cargo, CURDATE ());

COMMIT;

SET
   msg = CONCAT (
      'Tripulante ID ',
      v_tripulante_id,
      ' e Viagem ID ',
      v_viagem_id,
      ' criados com sucesso.'
   );

END / / DELIMITER;