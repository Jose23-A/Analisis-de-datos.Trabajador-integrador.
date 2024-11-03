import pyodbc
import configparser

#Crear una instancia de ConfigParser
config = configparser.ConfigParser()

#Leer el archivo de configuracion 
config.read('config.ini')

# Acceder a los datos de la configuración

db_config = {
    'driver': config['database']['driver'],
    'server': config['database']['server'],
    'database': config['database']['database'],
    'uid': config['database']['uid'],
    'pwd': config['database']['pwd']
}

#Configura la conexion a la base de datos SQL Server 'DRIVER={ODBC Driver 17 for SQL Server}'

# Contruir la cadena de conexion
connection_string = (
    f"DRIVER={db_config['driver']};"
    f"SERVER={db_config['server']};"
    f"DATABASE={db_config['database']};"
    f"UID={db_config['uid']};"
    f"PWD={db_config['pwd']};"
)

try:
    # Conexión a la base de datos
    conn = pyodbc.connect(connection_string)
    cursor = conn.cursor()

    # Ejecutar la stored procedure para el año 2024
    stored_procedure = 'Sp_Genera_Dim_Tiempo'
    param = 2024  # Año a cargar
    cursor.execute(f'EXEC {stored_procedure} ?', param)

    # Confirmar la ejecución
    conn.commit()
    print('Stored procedure ejecutada con éxito.')

except pyodbc.Error as e:
    print(f'Error al conectar o ejecutar el stored procedure: {e}')

finally:
    # Cerrar la conexión
    if 'conn' in locals():
        cursor.close()
        conn.close()
        print('Conexión cerrada.')
