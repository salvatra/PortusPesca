-- 1. LIMPEZA E CRIAÇÃO DE ROLES 

DROP ROLE IF EXISTS 
    'g_administrador', 
    'g_oficial', 
    'g_tripulacao';

CREATE ROLE 
    'g_administrador', -- Equipa de IT / Gestão
    'g_oficial',       -- Capitães e Imediatos
    'g_tripulacao';    -- Marinheiros, Cozinheiros, etc.

-- 2. DEFINIÇÃO DE PERMISSÕES POR REQUISITO

-- [RA5] Administradores total controlo
-- "Os administradores devem ser capazes de consultar, inserir, atualizar e remover..."
GRANT ALL PRIVILEGES ON PortusPesca.* TO 'g_administrador' WITH GRANT OPTION;

-- [RA2] Oficiais podem alterar dados da viagem
-- "Apenas tripulantes com cargos de responsabilidade podem alterar dados..."
GRANT SELECT, INSERT, UPDATE ON PortusPesca.Viagem TO 'g_oficial';
GRANT SELECT, INSERT, UPDATE ON PortusPesca.Captura TO 'g_oficial';
GRANT SELECT, INSERT, UPDATE ON PortusPesca.TripulanteViagem TO 'g_oficial';
GRANT SELECT, INSERT, UPDATE ON PortusPesca.ViagemZonaPesca TO 'g_oficial';

-- [RA3] Tripulantes sem responsabilidade NÃO acedem a financeiro
-- (Estratégia: Dar acesso às outras tabelas, mas bloquear explicitamente Financeiro ao não o incluir)

-- Permissões de Leitura Geral (Comum a Oficiais e Tripulação)
GRANT SELECT ON PortusPesca.Embarcacao TO 'g_oficial', 'g_tripulacao';
GRANT SELECT ON PortusPesca.PortosAutorizados TO 'g_oficial', 'g_tripulacao';
GRANT SELECT ON PortusPesca.ZonaPesca TO 'g_oficial', 'g_tripulacao';
GRANT SELECT ON PortusPesca.Nacionalidade TO 'g_oficial', 'g_tripulacao';

-- [RA4] Acesso a dados de viagem
-- Oficiais vêm tudo
GRANT SELECT ON PortusPesca.Financeiro TO 'g_oficial'; 

-- Tripulação vê dados operacionais, mas NÃO vê Financeiro (RA3 cumprido por omissão)
GRANT SELECT ON PortusPesca.Viagem TO 'g_tripulacao';
GRANT SELECT ON PortusPesca.Captura TO 'g_tripulacao';

-- SEGURANÇA DE DADOS SENSÍVEIS (Nível de Coluna)
-- A tripulação pode ver quem são os colegas (Nome, Email), mas NÃO o Salário.
GRANT SELECT(ID, CedulaMarinha, Nome, email, ContactoEmergencia, Estado) 
ON PortusPesca.Tripulante 
TO 'g_tripulacao';

-- Oficiais podem precisar de ver mais detalhes, mas talvez não o salário uns dos outros
-- (Assumindo aqui que Oficiais veem tudo do Tripulante para gestão)
GRANT SELECT ON PortusPesca.Tripulante TO 'g_oficial';


-- 3. CRIAÇÃO DE UTILIZADORES E ASSOCIAÇÃO A ROLES

DROP USER IF EXISTS 
    'admin_rui'@'localhost', 
    'capitao_ahab'@'localhost', 
    'marinheiro_ismael'@'localhost';

CREATE USER 
    'admin_rui'@'localhost' IDENTIFIED BY 'passAdmin123',
    'capitao_ahab'@'localhost' IDENTIFIED BY 'passBaleiaBranca',
    'marinheiro_ismael'@'localhost' IDENTIFIED BY 'passMarujo';

-- 4. ATRIBUIÇÃO FINAL


-- Associar Admin
GRANT 'g_administrador' TO 'admin_rui'@'localhost';
SET DEFAULT ROLE 'g_administrador' TO 'admin_rui'@'localhost';

-- Associar Oficial
GRANT 'g_oficial' TO 'capitao_ahab'@'localhost';
SET DEFAULT ROLE 'g_oficial' TO 'capitao_ahab'@'localhost';

-- Associar Tripulação
GRANT 'g_tripulacao' TO 'marinheiro_ismael'@'localhost';
SET DEFAULT ROLE 'g_tripulacao' TO 'marinheiro_ismael'@'localhost';

-- Refrescar Privilégios
FLUSH PRIVILEGES;