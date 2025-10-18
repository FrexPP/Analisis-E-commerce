import pandas as pd
import sqlite3
import os

# Conecto o creo una base de datos y guardo la ruta en donde estan los archivos csv.
conn = sqlite3.connect("Tienda E-commerce.db")
ruta = "C:/Users/franf/OneDrive/Desktop/archive"
archivos = os.listdir(ruta)
# Itero en la carpeta donde estan los csv y selecciono solamente este tipo de archivos. 
for archivo in archivos:
    if archivo.endswith(".csv"):
        # Creo el nombre que va a tener la tabla, creo el dataframe y creo la tabla en la base de datos.
        nombre_tabla = archivo.replace(".csv", "")
        df = pd.read_csv(os.path.join(ruta, archivo))
        df.to_sql(nombre_tabla, conn, if_exists="replace", index=False)
    print(f"Archivo {archivo} cargado correctamente a la base de datos.")
# Cierro la conexión a la base de datos.
conn.close()