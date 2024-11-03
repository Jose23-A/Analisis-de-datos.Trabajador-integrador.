import pyodbc
import csv
import os
import configparser

# Crear una instancia de ConfigParser
config = configparser.ConfigParser()

# Leer el archivo de configuracion
config.read('config.ini')

# Acceder a los datos de la configuración

db_config = {
    'driver': config['database']['driver'],
    'server': config['database']['server'],
    'database': config['database']['database'],
    'uid': config['database']['uid'],
    'pwd': config['database']['pwd']
}

# Configura la conexión a la base de datos SQL Server 'DRIVER={ODBC Driver 17 for SQL Server};'

# Contruir la cadena de conexion
connection_string = (
    f"DRIVER={db_config['driver']};"
    f"SERVER={db_config['server']};"
    f"DATABASE={db_config['database']};"
    f"UID={db_config['uid']};"
    f"PWD={db_config['pwd']};"
)

# Archivos a procesar
csv_files = ['ventas.csv']

# Conectarse a la base de datos usando la configuracion
try:
    conn = pyodbc.connect(connection_string)
    print("Conexión exitosa")

    cursor = conn.cursor()

    # Construye la ruta completa al archivo csv
    script_dir = os.path.dirname(__file__) #Obtiene el directorio del script actual
    csv_file_path = os.path.join(script_dir, 'database', 'ventas.csv')

    # Trunca la tabla STG_Ventas
    cursor.execute("TRUNCATE TABLE STG_Fact_Ventas")
    print("Tabla STG_Fact_Ventas truncada.")

    #Lee los datos del archivo CSV
    for file_name in csv_files:
        csv_files_path = os.path.join(script_dir, 'database', file_name)

        # Lee los datos del archivo csv
        with open(csv_file_path, mode='r', encoding='utf-8') as file:
            csv_reader = csv.reader(file)
            header = next(csv_reader) # Salta el encabezado
            
            # Inserta los datos en la tabla STG_Ventas
            for row in csv_reader:
                # Verifica si la fila tiene datos faltantes
                if any(not field for field in row):
                    # Inserta la fila en la tabla de datos faltantes
                    cursor.execute("""
                        INSERT INTO STG_Fact_Ventas_Datos_Faltantes (FechaVenta, CodigoProducto, Producto, Cantidad, PrecioVenta, CodigoCliente, Cliente, CodigoTienda, Tienda)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                    """, row)
                else:
                    # Inserta la fila en la tabla principal
                    cursor.execute("""
                        INSERT INTO STG_Fact_Ventas (FechaVenta, CodigoProducto, Producto, Cantidad, PrecioVenta, CodigoCliente, Cliente, CodigoTienda, Tienda)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                    """, row)
                 
    # Confirma los cambios y cierra la conexión
    conn.commit()
    cursor.close()
    conn.close()

    print("Datos insertados exitosamente")

except Exception as e:
    print(f'Error al conectarse a la base de datos: {e}')