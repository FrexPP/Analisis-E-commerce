-- TOP 3 Sub-Categorías que más ingresos generaron por temporada

-- Con la primer consulta del WITH creo un CTE donde separo las ganancias por temporada y por cada Sub-Categoría.
WITH Ventas_temporada AS (
SELECT CASE
       WHEN substr(O."Order Date",4,2) IN ('10','11','12') THEN 'Primavera'
       WHEN substr(O."Order Date",4,2) IN ('01','02','03') THEN 'Verano'
       WHEN substr(O."Order Date",4,2) IN ('04','05','06') THEN 'Otoño'
       WHEN substr(O."Order Date",4,2) IN ('07','08','09') THEN 'Invierno'
       END AS Temporada,
       OD."Sub-Category" AS Sub_categoria,
       SUM(OD.Quantity) AS Unidades,
       SUM(OD.Profit) AS Monto
FROM List_of_Orders O
JOIN Order_Details OD ON O."Order ID" = OD."Order ID"
GROUP BY Temporada, Sub_categoria),
-- En el segundo CTE asigno los TOPS por temporada (Donde si llega a empatar por monto, desempata por unidades vendidas).
Ranking_temporada AS (
SELECT Temporada,
       Sub_categoria,
       Unidades,
       Monto,
       ROW_NUMBER() OVER (
       PARTITION BY Temporada
       ORDER BY Monto DESC, Unidades DESC) AS Ranking
FROM Ventas_temporada)
-- Hago la consulta final dejando solo hasta el TOP 3 por temporada.
SELECT Temporada, Sub_categoria, CAST(Monto AS INTEGER) AS Monto, Unidades,
       "TOP #"|| Ranking AS TOPS FROM Ranking_temporada
WHERE Ranking <= 3