--Consulta general para tabla dinámica de Excel

--Hago una consulta con datos que podrían ser interesantes de observar en la tabla dinámica. También traduzco las Categorías.
SELECT O."Order Date" AS Fecha, 
       O.CustomerName AS Cliente, 
       O.City AS Ciudad, 
       CAST(OD.Profit AS INTEGER) AS 'Ganancia/Perdida', 
       CASE
       WHEN OD.Category = 'Furniture' THEN 'Muebles'
       WHEN OD.Category = 'Electronics' THEN 'Electrónica'
       WHEN OD.Category = 'Clothing' THEN 'Ropa'
       END AS Categoria
FROM List_of_Orders O
JOIN Order_Details OD ON O."Order ID" = OD."Order ID"