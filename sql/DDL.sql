DROP DATABASE IF EXISTS PortusPesca;
CREATE DATABASE PortusPesca CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE PortusPesca;


CREATE TABLE Embarcacao (
    ID VARCHAR(8) PRIMARY KEY, 
    Nome VARCHAR(150),
    Tipo VARCHAR(50) NOT NULL, 
    Altura DECIMAL(10,2),
    Largura DECIMAL(10,2),
    Comprimento DECIMAL(10,2),
    CapCarga DECIMAL(10,2) NOT NULL
);


CREATE TABLE EmbarcacaoPortosAut (
    Embarcacao VARCHAR(8) NOT NULL,
    Porto VARCHAR(100) NOT NULL,
    PRIMARY KEY (Embarcacao, Porto),
    FOREIGN KEY (Embarcacao) REFERENCES Embarcacao(ID) ON DELETE CASCADE
);


CREATE TABLE Tripulante (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    CedulaMarinha VARCHAR(30) NOT NULL UNIQUE,
    Nome VARCHAR(150) NOT NULL,
    DataNascimento DATE NOT NULL,
    Salario DECIMAL(10,2) NOT NULL,
    ContactoEmergencia VARCHAR(20),
    Email VARCHAR(150),
    Estado ENUM('Ativo', 'Inativo') NOT NULL DEFAULT 'Ativo',
    Rua VARCHAR(150),
    Numero INT,
    CodPostal INT,
    Localidade VARCHAR(150)
);


CREATE TABLE Nacionalidade (
    Tripulante INT NOT NULL,
    Nacionalidade VARCHAR(50) NOT NULL,
    PRIMARY KEY (Tripulante, Nacionalidade),
    FOREIGN KEY (Tripulante) REFERENCES Tripulante(ID) ON DELETE CASCADE
);


CREATE TABLE Viagem (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Embarcacao VARCHAR(8) NOT NULL,
    PortoOrigem VARCHAR(50) NOT NULL,
    PortoDestino VARCHAR(50),
    Descricao TEXT,
    DataPartida DATETIME NOT NULL,
    DataChegada DATETIME,
    Estado ENUM('Em Curso', 'Finalizada', 'Cancelada') NOT NULL DEFAULT 'Em Curso',
    
    FOREIGN KEY (Embarcacao) REFERENCES Embarcacao(ID) ON DELETE RESTRICT
);


CREATE TABLE Financeiro (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Viagem INT NOT NULL,
    Tipo ENUM('Receita', 'Despesa') NOT NULL,
    Valor DECIMAL(10,2) NOT NULL,
    Descricao TEXT,
    Categoria VARCHAR(50) NOT NULL,
    
    FOREIGN KEY (Viagem) REFERENCES Viagem(ID) ON DELETE CASCADE
);


CREATE TABLE ZonaPesca (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Descricao TEXT,
    Latitude DECIMAL(10,8) NOT NULL,
    Longitude DECIMAL(10,8) NOT NULL
);


CREATE TABLE Captura (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Viagem INT NOT NULL,
    ZonaPesca INT NOT NULL,
    NomeComum VARCHAR(100) NOT NULL,
    NomeCientifico VARCHAR(150),
    Quantidade DECIMAL(10,2) NOT NULL,
    
    FOREIGN KEY (Viagem) REFERENCES Viagem(ID) ON DELETE CASCADE,
    FOREIGN KEY (ZonaPesca) REFERENCES ZonaPesca(ID) ON DELETE RESTRICT
);


CREATE TABLE TripulanteViagem (
    Tripulante INT NOT NULL,
    Viagem INT NOT NULL,
    Cargo ENUM('Capitão', 'Imediato', 'Oficial de Navegação', 'Engenheiro', 'Mestre de Redes', 'Maquinista', 'Cozinheiro', 'Marinheiro') NOT NULL,
    DataEntrada DATE NOT NULL,
    DataSaida DATE,
    
    PRIMARY KEY (Tripulante, Viagem),
    FOREIGN KEY (Tripulante) REFERENCES Tripulante(ID) ON DELETE RESTRICT,
    FOREIGN KEY (Viagem) REFERENCES Viagem(ID) ON DELETE CASCADE
);


CREATE TABLE ViagemZonaPesca (
    Viagem INT NOT NULL,
    ZonaPesca INT NOT NULL,

    PRIMARY KEY (Viagem, ZonaPesca),
    FOREIGN KEY (Viagem) REFERENCES Viagem(ID) ON DELETE CASCADE,
    FOREIGN KEY (ZonaPesca) REFERENCES ZonaPesca(ID) ON DELETE RESTRICT
);
