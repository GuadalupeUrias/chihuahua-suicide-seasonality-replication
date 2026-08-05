📋 REPORTE — Diagnóstico inicial (parte 10: perfilado real de columnas por periodo)

✅ Trabajo realizado:
- Se comparon programáticamente (con Python, no a ojo) las columnas de los 8 archivos: 2005-2009, 2010-2014, 2015-2019, 2020, 2021, 2022, 2023, 2024.
- Se confirmó que la columna de año de ocurrencia (ANIO_OCUR) es idéntica en los 8 archivos; se completó YEAR_COLUMN_BY_GROUP en el notebook con este valor confirmado (ya no queda ningún TODO pendiente ahí).
- Se creó docs/DATA_DICTIONARY.md con: (a) las variables núcleo presentes sin cambio en todos los periodos, (b) el cambio de esquema de ~2010-2012 (LENGUA y COND_ACT no existen en 2005-2009), y (c) el cambio de esquema más importante: en 2022 el campo PRESUNTO (tipo de defunción: accidente/suicidio/homicidio) se renombra a TIPO_DEFUN, y aparecen ~15 variables nuevas no relacionadas con este análisis (relacionadas a nacimientos, donación de órganos, identidad étnica).

🔍 Hallazgos importantes:
- La ausencia de LENGUA y COND_ACT en 2005-2009 coincide exactamente con lo que el artículo original advierte (disponibles solo desde 2012) — es una validación cruzada positiva de que estamos en la fuente correcta.
- PRESUNTO → TIPO_DEFUN es un cambio de nombre que hay que tener en cuenta al escribir el script de limpieza/estandarización (Etapa 2), o el filtro de "tipo de defunción = suicidio" se rompería silenciosamente al llegar a 2022.
- VIO_FAMI (violencia familiar) desaparece solo en el archivo de 2022 y reaparece en 2023-2024 — posible inconsistencia de la fuente en ese año específico, no algo generado por nosotras; queda anotado para no confundirlo con un error de limpieza propio.
- EDAD_AGRU (edad ya agrupada por INEGI) existe en todos los periodos, pero no sabemos aún si sus categorías coinciden con los 7 grupos etarios del artículo — pendiente de verificar con el diccionario de datos.

📊 Métricas:
- 8/8 archivos con columna de año confirmada (100%).
- 2 cambios de esquema documentados entre periodos.
- ~15 variables nuevas identificadas desde 2022, de las cuales 0 se planean incluir en el dataset curado por ahora.

➡️ Próximos pasos:
1. Descargar/compartir el diccionario de datos (codebook) de al menos un archivo por periodo (2005-2009, 2010-2014, 2015-2019, 2022) para decodificar SEXO, ENT_RESID, EDAD/EDAD_AGRU, PRESUNTO/TIPO_DEFUN, ESCOLARIDA, EDO_CIVIL, AREA_UR.
2. Con eso, empezamos formalmente el script de estandarización (Etapa 2), incluyendo el mapeo PRESUNTO→TIPO_DEFUN.
3. Correr el notebook completo (ya sin TODOs pendientes salvo las URLs de diccionarios de datos, opcionales) para generar los parquet por año en data/interim/.
