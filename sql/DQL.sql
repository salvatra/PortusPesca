SELECT ID, PortoOrigem, PortoDestino, Estado FROM Viagem;


SELECT ID, PortoOrigem, PortoDestino, Estado 
FROM Viagem 
WHERE Estado = 'Em Curso';


SELECT 
    T.Nome, 
    TV.Cargo, 
    T.Estado 
FROM Tripulante AS T
INNER JOIN TripulanteViagem AS TV 
    ON T.ID = TV.Tripulante
WHERE 
    T.ID = 1 
    AND TV.DataSaida IS NULL;


SELECT 
    T.Nome, 
    TV.Cargo, 
    V.ID AS ViagemID, 
    V.PortoOrigem, 
    V.PortoDestino, 
    V.DataPartida
FROM Tripulante AS T
INNER JOIN TripulanteViagem AS TV 
    ON T.ID = TV.Tripulante
INNER JOIN Viagem AS V 
    ON TV.Viagem = V.ID
WHERE 
    T.ID = 1;


SELECT 
    Viagem,
    SUM(CASE WHEN Tipo = 'Receita' THEN Valor ELSE 0 END) AS SomaReceitas,
    SUM(CASE WHEN Tipo = 'Despesa' THEN ABS(Valor) ELSE 0 END) AS SomaDespesas,
    SUM(Valor) AS Lucro -- Assume-se que despesas estão registadas como valores negativos
FROM Financeiro
GROUP BY Viagem;


SELECT 
    ZP.Nome AS NomeZona, 
    C.NomeComum, 
    SUM(C.Quantidade) AS TotalKg, 
    COUNT(C.ID) AS NumRegistos
FROM Captura AS C
INNER JOIN ZonaPesca AS ZP 
    ON C.ZonaPesca = ZP.ID
GROUP BY 
    ZP.Nome, 
    C.NomeComum;


SELECT
   V.ID AS ViagemID,
   E.Nome AS NomeNavio,
   V.DataPartida,
   T.Nome AS NomeTripulante,
   TV.Cargo,
   C.NomeComum AS Especie,
   C.Quantidade,
   ZP.Nome AS NomeZona
FROM Viagem AS V
INNER JOIN Embarcacao AS E
   ON V.Embarcacao = E.ID
INNER JOIN TripulanteViagem AS TV
   ON V.ID = TV.Viagem
INNER JOIN Tripulante AS T
   ON TV.Tripulante = T.ID
INNER JOIN Captura AS C
   ON V.ID = C.Viagem
INNER JOIN ZonaPesca AS ZP
   ON C.ZonaPesca = ZP.ID
WHERE
   V.ID = 1;
