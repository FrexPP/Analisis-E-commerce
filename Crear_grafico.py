import pandas as pd
import sqlite3
import matplotlib.pyplot as plt

# Conecto a la base de datos y hago la consulta SQL que voy a utilizar.
with sqlite3.connect("Tienda E-commerce.db") as conn:
    query = """
    SELECT CASE
       WHEN Category = 'Furniture' THEN 'Muebles'
       WHEN Category = 'Electronics' THEN 'Electrónica'
       WHEN Category = 'Clothing' THEN 'Ropa'
       END AS Categoria,
       CAST(SUM(Profit) AS INTEGER) AS Monto
       FROM "Order Details"
    GROUP BY Categoria
    """
    # Creo el dataframe directamente con la consulta SQL.
    df = pd.read_sql_query(query, conn)

# Creo el Gráfico con los datos del dataframe.
df.set_index("Categoria")["Monto"].plot(kind="pie",
figsize=[8,8],
autopct='%1.1f%%',
legend=True,
ylabel="",
title="Total por Categoría")

# Ejecuto el Gráfico. 
plt.show()