import os
from dotenv import load_dotenv
import duckdb

load_dotenv()

DB_PATH=os.getenv("DB_PATH")
DATA_DIR=os.getenv("DATA_DIR")


CSV_FILES={
    "users":f"{DATA_DIR}/users.csv",
    "payments":f"{DATA_DIR}/payments.csv",
    "subscriptions":f"{DATA_DIR}/subscriptions.csv",
    "viewing_activity":f"{DATA_DIR}/viewing_activity.csv"
}

with duckdb.connect(DB_PATH) as con:
    con.execute(f"CREATE SCHEMA IF NOT EXISTS raw")

    for table,path in CSV_FILES.items():
        con.execute(f"""
                    CREATE OR REPLACE TABLE raw.{table}_raw AS
                    SELECT * FROM read_csv_auto('{path}')
        """)
        row_count = con.execute(f"SELECT COUNT(*) FROM raw.{table}_raw ").fetchone()[0]
        print(f"Loaded {row_count} rows in {table}_raw.")