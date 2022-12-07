from constants import HOST_NAME, USER_NAME, USER_PASSWORD, DATA_BASE_NAME , INPUT_CSV_PATH, TABLE_NAME
from functions import get_connection,create_database,use_database,csv_to_database

server_connection = get_connection(HOST_NAME, USER_NAME, USER_PASSWORD)
connection =use_database(server_connection,DATA_BASE_NAME)

def initialize():
    connection =get_connection(HOST_NAME, USER_NAME, USER_PASSWORD)
    create_database(database_name=DATA_BASE_NAME, connection=connection)
    connection= use_database(connection=connection, database_name=DATA_BASE_NAME)
    csv_to_database(connection=connection, csv_input_path=INPUT_CSV_PATH , table_name= TABLE_NAME)
    

