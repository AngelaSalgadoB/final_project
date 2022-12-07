import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.engine import Engine


def get_connection(host_name, user_name, user_password) -> Engine:
    connection = create_engine("mysql+pymysql://{user}:{pw}@{host}"
                               .format(host=host_name, user=user_name, pw=user_password))
    return connection


def create_database(database_name: str, connection: Engine) -> None:
    create_query = f'CREATE DATABASE IF NOT EXISTS {database_name};'
    connection.execute(create_query)


def use_database(connection: Engine, database_name)-> Engine:
    return create_engine("{url}/{db}".format(url=connection.engine.url, db=database_name))


def csv_to_database(connection: Engine, csv_input_path: str, table_name: str, delimiter: str = ',', if_exists='replace')-> None:
    data_input_csv = pd.read_csv(csv_input_path, delimiter=delimiter)
    data_input_csv.to_sql(con=connection, name=table_name,
                          if_exists=if_exists, index=False)
