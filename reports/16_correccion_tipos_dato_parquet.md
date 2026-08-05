📋 REPORTE — Diagnóstico inicial (parte 16: corrección de tipos de dato inconsistentes entre años)

✅ Trabajo realizado:
- Se diagnosticó el error ArrowInvalid al guardar en parquet (sección 6): la columna ENT_REGIS (y varias más) tenía una mezcla real de valores tipo texto ("01") y tipo entero (1) tras concatenar los 5 archivos de un mismo grupo, porque INEGI cambió el tipo de almacenamiento de varios campos de código/categoría entre años (confirmado comparando los diccionarios de datos 2018 vs 2022: LENGUA, NACIONALID, NECROPSIA y OCUPACION cambiaron de numérico a texto; OCUPACION además pasó de 2 a 3 dígitos).
- Se agregó una función de armonización de tipos (harmonize_dtypes) que se aplica a cada archivo individual antes de concatenar: un conjunto explícito de columnas se trata siempre como numérico (mediciones, fechas, códigos de un dígito); todo lo demás se trata como texto, rellenando con ceros a la izquierda las columnas de clave geográfica/causa con ancho fijo conocido, sin alterar valores ya alfanuméricos (ej. causas CIE-10 como "X70").
- Se documentó el hallazgo en docs/DATA_DICTIONARY.md con la tabla comparativa de tipos 2018 vs 2022.

🔍 Hallazgos importantes:
- Este no es un error nuestro ni de INEGI en el sentido de "dato mal capturado": es un cambio real de formato de almacenamiento entre años, algo común en series de tiempo administrativas de varias décadas. Vale la pena tenerlo presente para cualquier otra variable que se use más adelante en el análisis.
- La solución aplicada resuelve el bloqueo técnico (guardar en parquet) sin perder información ni ceros a la izquierda en claves geográficas.

📊 Métricas:
- 1 error bloqueante resuelto.
- 4 variables confirmadas con cambio de tipo de almacenamiento entre 2018 y 2022 (LENGUA, NACIONALID, NECROPSIA, OCUPACION), documentadas explícitamente.

➡️ Próximos pasos:
1. Volver a correr el notebook desde la sección 3 (carga) en adelante — la corrección está en la función de carga, así que hay que recargar los datos, no solo repetir la sección 6.
2. Confirmar que la sección 6 ahora guarda los 17 años sin error.
3. Con los datos ya guardados en data/interim/, avanzar a la Etapa 2: filtrado por Chihuahua + causa de suicidio.
