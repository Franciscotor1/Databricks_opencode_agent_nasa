from databricks.connect import DatabricksSession

try:
    spark = (
        DatabricksSession.builder
        .profile("DEFAULT")
        .serverless(True)
        .getOrCreate()
    )
    df = spark.range(5)
    df.show()
    print("¡Conexión de Databricks Connect exitosa!")
except Exception as e:
    print(f"Error al conectar con Databricks: {e}")
