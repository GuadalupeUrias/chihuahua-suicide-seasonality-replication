📋 REPORTE — Diagnóstico inicial (parte 6: estructura real de archivos INEGI y adelanto de años de extensión)

✅ Trabajo realizado:
- Se corrigió el supuesto de "un archivo por año": INEGI agrupa los microdatos en archivos consolidados por periodo (2005-2009, 2010-2014, 2015-2019) y a partir de 2020/2021 entrega un archivo por año.
- Se actualizó docs/DATA_SOURCES.md con la tabla real de 8 archivos a descargar (3 consolidados + 5 individuales 2020-2024).
- Se reescribió notebooks/01_download_extract_mortalidad.ipynb: ahora usa un diccionario FILE_GROUPS (en vez de un año por URL), y agrega un paso nuevo para separar cada archivo consolidado en años individuales, usando la columna de año que se identifique en cada archivo (paso manual guiado, ya que no sabemos aún el nombre exacto de esa columna en cada periodo).
- Se actualizó el README.md para reflejar que los años de extensión (2019-2024) se descargan desde esta misma etapa, ya que compartimos archivo con los años de la réplica.

🔍 Hallazgos importantes:
- Descargar los 8 archivos cubre tanto la réplica (2008-2018) como la extensión (hasta 2024), sin necesidad de volver a descargar nada después.
- El archivo 2015-2019 ya incluye 2019, que es el primer año "extra" más allá del artículo original.
- Sigue pendiente identificar el nombre exacto de la columna de año en cada archivo (se hace al momento de correr el notebook, viendo la salida real de columnas).

📊 Métricas:
- 8 archivos de datos + 8 diccionarios de datos esperados (antes se estimaban 11 archivos individuales).
- Periodo total cubierto: 2005-2024 (aunque solo 2008-2024 es de interés real para el proyecto).

➡️ Próximos pasos:
1. Descargar los 8 archivos y completar FILE_GROUPS en el notebook.
2. Correr hasta la sección 4 (columnas) y compartir la salida para identificar juntas el nombre de la columna de año en cada archivo y completar YEAR_COLUMN_BY_GROUP.
