-- Objetivo de ganancias

-- Con un WITH hago dos CTE donde saco el total por categoría de cada una (Objetivo/Ganancia real).
WITH Total_ventas AS (
SELECT Category,
       SUM(Profit) AS Ventas
FROM Order_Details
GROUP BY Category),
Total_objetivo AS (
SELECT Category,
       SUM(Target) AS Objetivo
FROM Sales_target
GROUP BY Category)
-- Hago la consulta final donde traduzo al español las categorías y saco la diferencia porcentual que tuvieron estos.
SELECT CASE
       WHEN V.Category = 'Clothing' THEN 'Ropa'
       WHEN V.Category = 'Electronics' THEN 'Electrónica'
       WHEN V.Category = 'Furniture' THEN 'Muebles'
       END AS Categoria,    
       CAST(O.Objetivo AS INTEGER) AS Objetivo,
       CAST(V.Ventas AS INTEGER) AS Ventas,
       ROUND(((V.Ventas - O.Objetivo) / O.Objetivo) * 100,2) ||"%" AS Diferencia_porcentual
FROM Total_ventas V
JOIN Total_objetivo O ON V.Category = O.Category