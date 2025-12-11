DROP DATABASE IF EXISTS PortusPesca;
CREATE DATABASE PortusPesca CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE PortusPesca;


CREATE TABLE embarcacao (
    id VARCHAR(20) PRIMARY KEY, -- Matrícula tipo PT-1234
    nome VARCHAR(150),
    tipo VARCHAR(50) NOT NULL, -- Arrastão, Traineira, etc.
    dim_altura DECIMAL(10,2),
    dim_largura DECIMAL(10,2),
    dim_comprimento DECIMAL(10,2),
    cap_carga DECIMAL(10,2) NOT NULL
);


CREATE TABLE embarcacao_porto_autorizado (
    embarcacao_id VARCHAR(20) NOT NULL,
    porto VARCHAR(100) NOT NULL,
    PRIMARY KEY (embarcacao_id, porto),
    FOREIGN KEY (embarcacao_id) REFERENCES embarcacao(id) ON DELETE CASCADE
);


CREATE TABLE tripulante (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cedula_marinha VARCHAR(30) NOT NULL UNIQUE,
    nome VARCHAR(150) NOT NULL,
    data_nascimento DATE NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    contacto_emergencia VARCHAR(20), -- Não é INT por causa dos country codes tipo +351 para pt
    email VARCHAR(150),
    estado ENUM('Ativo', 'Inativo') NOT NULL DEFAULT 'Ativo',
    morada_rua VARCHAR(150),
    morada_numero INT,
    morada_cod_postal VARCHAR(20),
    morada_localidade VARCHAR(150)
);


CREATE TABLE tripulante_nacionalidade (
    tripulante_id INT NOT NULL,
    nacionalidade VARCHAR(50) NOT NULL,
    PRIMARY KEY (tripulante_id, nacionalidade),
    FOREIGN KEY (tripulante_id) REFERENCES tripulante(id) ON DELETE CASCADE
);


CREATE TABLE zona_pesca (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao TEXT,
    lat DECIMAL(10,8) NOT NULL,
    lon DECIMAL(10,8) NOT NULL
);


CREATE TABLE viagem (
    id INT AUTO_INCREMENT PRIMARY KEY,
    embarcacao_id VARCHAR(20) NOT NULL,
    porto_origem VARCHAR(50) NOT NULL,
    porto_destino VARCHAR(50),
    descricao TEXT,
    data_partida DATETIME NOT NULL,
    data_chegada DATETIME,
    estado ENUM('Em Curso', 'Finalizada', 'Cancelada') NOT NULL DEFAULT 'Em Curso',
    -- Saldo é derivado, não guardamos fisicamente, calculamos (!!!) com VIEW/função_que_vamos-ter
    
    FOREIGN KEY (embarcacao_id) REFERENCES embarcacao(id) ON DELETE RESTRICT
);


CREATE TABLE financeiro (
    id INT AUTO_INCREMENT PRIMARY KEY,
    viagem_id INT NOT NULL,
    tipo ENUM('Receita', 'Despesa') NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    descricao TEXT,
    categoria VARCHAR(50) NOT NULL, -- tipo combustível, venda, etc.
    
    FOREIGN KEY (viagem_id) REFERENCES viagem(id) ON DELETE CASCADE
);


CREATE TABLE captura (
    id INT AUTO_INCREMENT PRIMARY KEY,
    viagem_id INT NOT NULL,
    zona_id INT NOT NULL,
    nome_comum VARCHAR(100) NOT NULL,
    nome_cientifico VARCHAR(150),
    quantidade DECIMAL(10,2) NOT NULL,
    
    FOREIGN KEY (viagem_id) REFERENCES viagem(id) ON DELETE CASCADE,
    FOREIGN KEY (zona_id) REFERENCES zona_pesca(id) ON DELETE RESTRICT
);


CREATE TABLE tripulante_viagem (
    tripulante_id INT NOT NULL,
    viagem_id INT NOT NULL,
    cargo ENUM('Capitão', 'Imediato', 'Oficial de Navegação', 'Engenheiro', 'Mestre de Redes', 'Maquinista', 'Cozinheiro', 'Marinheiro') NOT NULL,
    data_entrada DATE NOT NULL,
    data_saida DATE,
    
    PRIMARY KEY (tripulante_id, viagem_id),
    FOREIGN KEY (tripulante_id) REFERENCES tripulante(id) ON DELETE RESTRICT,
    FOREIGN KEY (viagem_id) REFERENCES viagem(id) ON DELETE CASCADE
);


CREATE TABLE viagem_zona_pesca (
    viagem_id INT NOT NULL,
    zona_id INT NOT NULL,
    hora_entrada DATETIME,
    hora_saida DATETIME,
    
    PRIMARY KEY (viagem_id, zona_id),
    FOREIGN KEY (viagem_id) REFERENCES viagem(id) ON DELETE CASCADE,
    FOREIGN KEY (zona_id) REFERENCES zona_pesca(id) ON DELETE RESTRICT
);