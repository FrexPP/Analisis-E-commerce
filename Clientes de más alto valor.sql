-- Clientes de más alto valor

-- Con un WITH creo un campo en el que guardo el total que generaron todos los empleados en general.
WITH Ingresos_totales AS (
SELECT SUM(profit) AS Ingreso_total
FROM Order_Details
)
-- Hago la consulta donde selecciono los clientes y lo que generaron cada uno por separado.
SELECT O.CustomerName AS Cliente, 
       CAST(SUM(OD.profit) AS INTEGER) AS Ingreso_generado,
       COUNT(DISTINCT O."Order ID") AS Ordenes_realizadas,
-- Utilizo el campo que creé con WITH para sacar el porcentaje de cada cliente.       
       ROUND((SUM(OD.profit) / IT.Ingreso_total) * 100, 2) ||"%" AS Porcentaje
FROM List_of_Orders O
JOIN Order_Details OD ON O."Order ID" = OD."Order ID"
-- Tengo que unir el total generado de todos los clientes con un CROSS JOIN para que este valor se repita con todos los clientes
CROSS JOIN Ingresos_totales IT
GROUP BY O.CustomerName
ORDER BY Ingreso_generado DESC
LIMIT 10
