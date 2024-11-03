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

# Conectarse a la base de datos usando la configuracion
try:
    conn = pyodbc.connect(connection_string)
    print("Conexión exitosa")

    # Conectarse a la base de datos
    cursor = conn.cursor()

    # Ejecutar el Store Procedure sin parametros
    stored_procedure = 'SP_Carga_Dim_Cliente'

    param = 123456789 # Valor del parametro bigint
    cursor.execute(f'EXEC {stored_procedure} ?', param)
    # cursor.execute(f'EXEC {stored_procedure}')

    # Confirmar ejecución
    conn.commit()
    print('Stored procedure SP_Carga_Dim_Cliente ejecutado con éxito.')

except pyodbc.Error as e:
    print(f'Error al conectar o ejecutar el stored procedure SP_Carga_Dim_Cliente: {e}')

finally:
    # Asegurarse de cerrar la conexion
    if 'cursor' in locals():
        cursor.close()
    if 'conn' in locals():
        conn.close()