import pandas as pd
from sqlalchemy import create_engine

ruta_archivo = "mental-illnesses-prevalence.csv"
df = pd.read_csv(ruta_archivo)

df = df.dropna()

df = df.rename(columns={
    "Entity": "pais",
    "Code": "codigo_pais",
    "Year": "anio"
})

df["anio"] = df["anio"].astype(int)

df = df[df["anio"] >= 2000]

columnas_prevalencia = df.columns[3:]
df["promedio_prevalencia"] = df[columnas_prevalencia].mean(axis=1)

df_final = df[["pais", "codigo_pais", "anio", "promedio_prevalencia"]]

df_final.to_csv("mental_health_powerbi.csv", index=False)

"""
engine = create_engine(
    "mysql+pymysql://usuario:password@localhost:3306/salud_mental"
)

df_final.to_sql(
    name="prevalencia_salud_mental",
    con=engine,
    if_exists="replace",
    index=False
)
"""
