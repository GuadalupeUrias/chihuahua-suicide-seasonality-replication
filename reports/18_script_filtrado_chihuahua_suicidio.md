📋 REPORTE — Limpieza/Filtrado (parte 18: script de filtrado Chihuahua + suicidio, listo para correr)

✅ Trabajo realizado:
- Se creó `notebooks/02_limpieza_filtrado.ipynb`, que parte de los 17 años crudos nacionales generados por el notebook 01 (`data/interim/defunciones_{año}_crudo.parquet`) y aplica:
  1. Filtro geográfico: `ENT_RESID == "08"` (Chihuahua, residencia habitual — comparando contra texto, ya que quedó con ceros a la izquierda desde la armonización de tipos del notebook 01).
  2. Filtro de causa con **dos criterios independientes**, tal como se planeó en el cierre de la Etapa 1:
     - `CAUSA_DEF` (CIE-10) en el rango X60-X84, comparando por los primeros 3 caracteres del código de 4 caracteres.
     - Campo armonizado `tipo_defuncion_cod` (= `PRESUNTO` en 2005-2021, = `TIPO_DEFUN` en 2022-2024) `== 3` ("Suicidio", código confirmado idéntico en ambos sistemas).
  3. Comparación explícita de ambos filtros (intersección, y casos donde solo uno de los dos marca "suicidio"), con muestra impresa de las filas discordantes si las hay.
  4. Validación contra el total de 3,572 casos del artículo original (subconjunto 2008-2018).
  5. Guardado del dataset filtrado en `data/processed/defunciones_chihuahua_suicidios_filtrado.parquet` (y, si aplica, un archivo aparte con las filas en discrepancia, para revisión manual).
- Por ahora, el dataset final usa la **intersección** de ambos filtros de causa como criterio (más conservador). Esto queda documentado como una decisión provisional en el propio notebook, a confirmar según lo que salga en la validación cruzada.

🔍 Hallazgos importantes:
- Este notebook está pensado para correr en tu computadora (donde ya tienes `data/interim/` poblado), no en este entorno — igual que el notebook 01.
- No pude ejecutar el filtrado con datos reales porque no tengo acceso a `data/interim/` (no hay conexión directa a tu repositorio ni a tus archivos locales desde aquí); si al correrlo aparece algún nombre de columna distinto al documentado en `docs/DATA_DICTIONARY.md`, compártelo antes de que yo asuma una corrección.
- Riesgo anticipado: si el filtro CIE-10 y el filtro por tipo de defunción no coinciden exactamente, la sección 3.3 del notebook lo muestra explícitamente — es la validación cruzada que decidimos priorizar sobre solo comparar contra el total de 3,572 casos.

📊 Métricas:
- 1 notebook nuevo, 18 celdas, sintaxis validada.
- 2 filtros de causa aplicados de forma independiente + comparación cruzada.
- 0 filas procesadas todavía (pendiente de ejecución con datos reales de tu máquina).

➡️ Próximos pasos:
1. Correr `notebooks/02_limpieza_filtrado.ipynb` completo en tu computadora.
2. Compartir la salida completa, en especial las secciones 3.3 (comparación de filtros) y 4 (validación contra 3,572 casos) — con eso decidimos si la intersección es el criterio correcto o si hay que ajustar.
3. Con el filtrado confirmado, seguimos con la estandarización de variables (7 grupos etarios desde `EDAD_AGRU`, decodificación de `SEXO`/`AREA_UR`/etc.) para cerrar formalmente la Etapa 2 y documentar en `docs/DATA_DICTIONARY.md` cuál quedó como criterio final de filtro de causa.
