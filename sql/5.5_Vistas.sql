DELIMITER //
CREATE VIEW TodasEmbarcacoes AS
    SELECT * FROM Embarcacao;
//
DELIMITER ;



DELIMITER //
CREATE VIEW ViagensEmCurso AS
    SELECT 
        V.ID AS ViagemID,
        E.Tipo AS TipoEmbarcacao,
        E.Nome AS NomeEmbarcacao,
        V.PortoOrigem,
        V.PortoDestino,
        V.DataPartida,
        V.Descricao
    FROM Viagem AS V
    INNER JOIN Embarcacao AS E 
        ON V.Embarcacao = E.ID
    WHERE 
        V.Estado = 'Em Curso';
//
DELIMITER ;



DELIMITER //
CREATE VIEW DetalhesCapturas AS
    SELECT 
        C.ID AS CapturaID,
        C.NomeComum AS Especie,
        C.Quantidade,
        Z.Nome AS ZonaPesca,
        V.ID AS ViagemID,
        V.DataPartida
    FROM Captura AS C
    INNER JOIN ZonaPesca AS Z 
        ON C.ZonaPesca = Z.ID
    INNER JOIN Viagem AS V 
        ON C.Viagem = V.ID;
//
DELIMITER ;