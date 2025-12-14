-- ====================================================================
-- 1. ENTIDADES FORTES - Embarcação e seus atributos multivalorados
-- ====================================================================

-- Povoar tabela Embarcacao
INSERT INTO Embarcacao (ID, Nome, Tipo, Altura, Largura, Comprimento, CapCarga) VALUES
    ('AV123456', 'Portus I', 'Arrastão', 12.00, 5.00, 40.00, 100.00),
    ('AV234567', 'Mar Bravo', 'Traineira', 10.50, 4.50, 35.00, 80.00),
    ('PT345678', 'Atlântico', 'Palangreiro', 15.00, 6.00, 50.00, 150.00),
    ('PT456789', 'Neptuno', 'Atuneiro', 18.00, 7.50, 60.00, 200.00),
    ('AV567890', 'Maré Alta', 'Cerqueiro', 11.00, 4.80, 38.00, 90.00),
    ('PT678901', NULL, 'Emalhador', 9.50, 4.00, 32.00, 70.00);

-- Povoar tabela PortosAutorizados
INSERT INTO PortosAutorizados (Embarcacao, Porto) VALUES
    ('AV123456', 'Aveiro'),
    ('AV123456', 'Portimão'),
    ('AV123456', 'Figueira da Foz'),
    ('AV234567', 'Aveiro'),
    ('AV234567', 'Matosinhos'),
    ('PT345678', 'Portimão'),
    ('PT345678', 'Lagos'),
    ('PT345678', 'Olhão'),
    ('PT456789', 'Portimão'),
    ('PT456789', 'Peniche'),
    ('AV567890', 'Aveiro'),
    ('AV567890', 'Sesimbra'),
    ('PT678901', 'Portimão'),
    ('PT678901', 'Setúbal');

-- ====================================================================
-- 2. ENTIDADES FORTES - Tripulante e seus atributos multivalorados
-- ====================================================================

-- Povoar tabela Tripulante
INSERT INTO Tripulante (ID, Estado, CedulaMarinha, Nome, DataNascimento, Salario, Rua, Numero, CodPostal, Localidade, ContactoEmergencia, Email) VALUES
    (1, 'Ativo', 'AB12345', 'João Silva', '1967-04-16', 2500.00, 'Rua do Mar', 10, '3800-123', 'Aveiro', 911121111, 'joao.silva@gmail.com'),
    (2, 'Ativo', 'CD23456', 'Manuel Costa', '1975-08-22', 3200.00, 'Avenida da Liberdade', 45, '3810-200', 'Aveiro', 912131313, 'manuel.costa@gmail.com'),
    (3, 'Ativo', 'EF34567', 'António Pereira', '1980-12-10', 1800.00, 'Rua das Flores', 23, '3800-456', 'Torreira', 913141414, 'antonio.pereira@gmail.com'),
    (4, 'Ativo', 'GH45678', 'Carlos Rodrigues', '1985-03-15', 2200.00, 'Praça do Peixe', 7, '3800-789', 'Aveiro', 914151515, 'carlos.rodrigues@gmail.com'),
    (5, 'Ativo', 'IJ56789', 'José Santos', '1990-07-20', 1600.00, 'Rua dos Navegantes', 18, '3810-300', 'Aveiro', 915161616, 'jose.santos@gmail.com'),
    (6, 'Ativo', 'KL67890', 'Paulo Martins', '1988-11-05', 1900.00, 'Bairro dos Pescadores', 32, '3800-234', 'Torreira', NULL, 'paulo.martins@gmail.com'),
    (7, 'Ativo', 'MN78901', 'Fernando Alves', '1992-02-28', 1700.00, 'Rua da Ria', 56, '3810-400', 'Aveiro', 917181818, NULL),
    (8, 'Ativo', 'OP89012', 'Ricardo Sousa', '1983-09-12', 2100.00, 'Avenida do Atlântico', 12, '8500-123', 'Portimão', 918191919, 'ricardo.sousa@gmail.com'),
    (9, 'Ativo', 'QR90123', 'Miguel Ferreira', '1978-06-18', 2800.00, 'Rua do Porto', 89, '8500-234', 'Portimão', 919202020, 'miguel.ferreira@gmail.com'),
    (10, 'Ativo', 'ST01234', 'Rui Gomes', '1995-01-25', 1500.00, 'Praça da Marina', 3, '8500-345', 'Portimão', 920212121, 'rui.gomes@gmail.com'),
    (11, 'Inativo', 'UV12345', 'Joaquim Dias', '1960-10-08', 2600.00, 'Rua Velha', 67, '3800-567', 'Aveiro', 921222222, 'joaquim.dias@gmail.com'),
    (12, 'Ativo', 'WX23456', 'Pedro Oliveira', '1987-04-14', 1800.00, 'Alameda das Gaivotas', 41, '3810-500', 'Aveiro', 922232323, 'pedro.oliveira@gmail.com');

-- Povoar tabela Nacionalidade
INSERT INTO Nacionalidade (Tripulante, Nacionalidade) VALUES
    (1, 'Portuguesa'),
    (1, 'Cabo-Verdiana'),
    (2, 'Portuguesa'),
    (3, 'Portuguesa'),
    (4, 'Portuguesa'),
    (5, 'Portuguesa'),
    (6, 'Portuguesa'),
    (6, 'Brasileira'),
    (7, 'Portuguesa'),
    (8, 'Portuguesa'),
    (9, 'Portuguesa'),
    (10, 'Portuguesa'),
    (11, 'Portuguesa'),
    (12, 'Portuguesa'),
    (12, 'Angolana');

-- ====================================================================
-- 3. ENTIDADE CENTRAL - Viagem
-- ====================================================================

-- Povoar tabela Viagem
INSERT INTO Viagem (ID, Embarcacao, PortoOrigem, PortoDestino, Descricao, DataPartida, DataChegada, Estado) VALUES
    (1, 'AV123456', 'Aveiro', 'Portimão', 'Expedição de captura de carapau na costa sul', '2024-03-12 08:30:00', '2024-03-17 16:30:00', 'Finalizada'),
    (2, 'PT345678', 'Portimão', 'Lagos', 'Pesca de espadarte em alto mar', '2024-04-05 06:00:00', '2024-04-12 18:00:00', 'Finalizada'),
    (3, 'AV234567', 'Aveiro', 'Figueira da Foz', 'Captura de sardinha na costa centro', '2024-05-20 07:00:00', NULL, 'Em Curso'),
    (4, 'PT456789', 'Portimão', 'Peniche', 'Expedição de atum na zona atlântica', '2024-06-01 05:30:00', NULL, 'Em Curso'),
    (5, 'AV567890', 'Aveiro', 'Sesimbra', 'Pesca de pescada com redes de cerco', '2024-02-10 08:00:00', '2024-02-15 17:00:00', 'Finalizada'),
    (6, 'PT678901', 'Portimão', 'Setúbal', 'Captura de dourada e robalo', '2024-01-15 09:00:00', '2024-01-18 14:00:00', 'Finalizada'),
    (7, 'AV123456', 'Aveiro', 'Portimão', 'Expedição cancelada por mau tempo', '2024-07-10 07:00:00', '2024-07-10 12:00:00', 'Cancelada');

-- ====================================================================
-- 4. ENTIDADES RELACIONADAS COM VIAGEM
-- ====================================================================

-- Povoar tabela ZonaPesca
INSERT INTO ZonaPesca (ID, Nome, Descricao, Latitude, Longitude) VALUES
    (1, 'Zona Noroeste', 'Águas costeiras do norte de Portugal, ricas em sardinha', 41.15000000, -8.67000000),
    (2, 'Zona Sul-Algarve', 'Costa sul portuguesa, ideal para captura de espadarte', 37.02000000, -7.93000000),
    (3, 'Zona Centro-Atlântico', 'Alto mar na zona centro, propícia para atum', 39.50000000, -10.20000000),
    (4, 'Zona Estuário Tejo', 'Águas semi-salgadas próximas ao estuário do Tejo', 38.70000000, -9.15000000),
    (5, 'Zona Berlengas', 'Arquipélago das Berlengas, zona de grande biodiversidade', 39.41000000, -9.51000000);

-- Povoar tabela ViagemZonaPesca
INSERT INTO ViagemZonaPesca (Viagem, ZonaPesca) VALUES
    (1, 2),
    (1, 4),
    (2, 2),
    (2, 3),
    (3, 1),
    (4, 3),
    (4, 5),
    (5, 4),
    (6, 2);

-- Povoar tabela Captura
INSERT INTO Captura (ID, Viagem, ZonaPesca, NomeComum, NomeCientifico, Quantidade) VALUES
    (1, 1, 2, 'Carapau', 'Trachurus trachurus', 450.00),
    (2, 1, 4, 'Pescada', 'Merluccius merluccius', 280.00),
    (3, 2, 2, 'Espadarte', 'Xiphias gladius', 180.00),
    (4, 2, 3, 'Atum', 'Thunnus thynnus', 320.00),
    (5, 3, 1, 'Sardinha', 'Sardina pilchardus', 600.00),
    (6, 4, 3, 'Atum', 'Thunnus thynnus', 410.00),
    (7, 4, 5, 'Dourada', 'Sparus aurata', 150.00),
    (8, 5, 4, 'Pescada', 'Merluccius merluccius', 340.00),
    (9, 5, 4, 'Robalo', 'Dicentrarchus labrax', 120.00),
    (10, 6, 2, 'Dourada', 'Sparus aurata', 200.00),
    (11, 6, 2, 'Robalo', 'Dicentrarchus labrax', 180.00);

-- Povoar tabela Financeiro
INSERT INTO Financeiro (ID, Viagem, Tipo, Valor, Descricao, Categoria) VALUES
    -- Viagem 1
    (1, 1, 'Despesa', -850.00, 'Combustível para travessia Aveiro-Portimão', 'Combustível'),
    (2, 1, 'Despesa', -320.00, 'Taxas portuárias em Portimão', 'Portos'),
    (3, 1, 'Despesa', -150.00, 'Manutenção preventiva do motor', 'Manutenção'),
    (4, 1, 'Receita', 2700.00, 'Venda de carapau (450kg a 6€/kg)', 'Venda'),
    (5, 1, 'Receita', 2240.00, 'Venda de pescada (280kg a 8€/kg)', 'Venda'),
    -- Viagem 2
    (6, 2, 'Despesa', -1200.00, 'Combustível para expedição em alto mar', 'Combustível'),
    (7, 2, 'Despesa', -400.00, 'Taxas portuárias em Lagos', 'Portos'),
    (8, 2, 'Despesa', -280.00, 'Reparação de redes de pesca', 'Manutenção'),
    (9, 2, 'Receita', 5400.00, 'Venda de espadarte (180kg a 30€/kg)', 'Venda'),
    (10, 2, 'Receita', 6400.00, 'Venda de atum (320kg a 20€/kg)', 'Venda'),
    -- Viagem 3 (Em Curso)
    (11, 3, 'Despesa', -650.00, 'Combustível para deslocação costa centro', 'Combustível'),
    (12, 3, 'Despesa', -180.00, 'Provisões para tripulação', 'Outro'),
    (13, 3, 'Receita', 3000.00, 'Venda parcial de sardinha (600kg a 5€/kg)', 'Venda'),
    -- Viagem 4 (Em Curso)
    (14, 4, 'Despesa', -1500.00, 'Combustível para zona atlântica', 'Combustível'),
    (15, 4, 'Despesa', -350.00, 'Seguro de expedição de alto mar', 'Seguros'),
    (16, 4, 'Receita', 8200.00, 'Venda de atum (410kg a 20€/kg)', 'Venda'),
    -- Viagem 5
    (17, 5, 'Despesa', -720.00, 'Combustível Aveiro-Sesimbra', 'Combustível'),
    (18, 5, 'Despesa', -260.00, 'Taxas portuárias em Sesimbra', 'Portos'),
    (19, 5, 'Receita', 2720.00, 'Venda de pescada (340kg a 8€/kg)', 'Venda'),
    (20, 5, 'Receita', 1440.00, 'Venda de robalo (120kg a 12€/kg)', 'Venda'),
    -- Viagem 6
    (21, 6, 'Despesa', -580.00, 'Combustível Portimão-Setúbal', 'Combustível'),
    (22, 6, 'Despesa', -200.00, 'Taxas portuárias em Setúbal', 'Portos'),
    (23, 6, 'Receita', 2800.00, 'Venda de dourada (200kg a 14€/kg)', 'Venda'),
    (24, 6, 'Receita', 2160.00, 'Venda de robalo (180kg a 12€/kg)', 'Venda'),
    -- Viagem 7 (Cancelada)
    (25, 7, 'Despesa', -450.00, 'Combustível parcial antes do cancelamento', 'Combustível'),
    (26, 7, 'Despesa', -120.00, 'Custos administrativos de cancelamento', 'Outro');

-- ====================================================================
-- 5. ENTIDADE ASSOCIATIVA - TripulanteViagem
-- ====================================================================

-- Povoar tabela TripulanteViagem
INSERT INTO TripulanteViagem (Tripulante, Viagem, Cargo, DataEntrada, DataSaida) VALUES
    -- Viagem 1 (Finalizada)
    (1, 1, 'Capitão', '2024-03-12', '2024-03-17'),
    (3, 1, 'Marinheiro', '2024-03-12', '2024-03-17'),
    (5, 1, 'Maquinista', '2024-03-12', '2024-03-17'),
    (7, 1, 'Cozinheiro', '2024-03-12', '2024-03-17'),
    -- Viagem 2 (Finalizada)
    (2, 2, 'Capitão', '2024-04-05', '2024-04-12'),
    (4, 2, 'Imediato', '2024-04-05', '2024-04-12'),
    (8, 2, 'Engenheiro', '2024-04-05', '2024-04-12'),
    (10, 2, 'Marinheiro', '2024-04-05', '2024-04-12'),
    -- Viagem 3 (Em Curso)
    (2, 3, 'Capitão', '2024-05-20', NULL),
    (5, 3, 'Maquinista', '2024-05-20', NULL),
    (6, 3, 'Mestre de Redes', '2024-05-20', NULL),
    (12, 3, 'Marinheiro', '2024-05-20', NULL),
    -- Viagem 4 (Em Curso)
    (9, 4, 'Capitão', '2024-06-01', NULL),
    (4, 4, 'Imediato', '2024-06-01', NULL),
    (8, 4, 'Engenheiro', '2024-06-01', NULL),
    (10, 4, 'Marinheiro', '2024-06-01', NULL),
    (7, 4, 'Cozinheiro', '2024-06-01', NULL),
    -- Viagem 5 (Finalizada)
    (1, 5, 'Capitão', '2024-02-10', '2024-02-15'),
    (3, 5, 'Marinheiro', '2024-02-10', '2024-02-15'),
    (6, 5, 'Mestre de Redes', '2024-02-10', '2024-02-15'),
    -- Viagem 6 (Finalizada)
    (9, 6, 'Capitão', '2024-01-15', '2024-01-18'),
    (8, 6, 'Engenheiro', '2024-01-15', '2024-01-18'),
    (10, 6, 'Marinheiro', '2024-01-15', '2024-01-18'),
    -- Viagem 7 (Cancelada - tripulação desvinculada no mesmo dia)
    (1, 7, 'Capitão', '2024-07-10', '2024-07-10'),
    (3, 7, 'Marinheiro', '2024-07-10', '2024-07-10');
