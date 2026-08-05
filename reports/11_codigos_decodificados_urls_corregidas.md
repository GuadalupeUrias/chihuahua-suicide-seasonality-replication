📋 REPORTE — Diagnóstico inicial (parte 11: códigos reales decodificados + URLs corregidas)

✅ Trabajo realizado:
- Se corrigieron en el notebook las URLs de 2022, 2023 y 2024 (ahora cada una apunta a su propia carpeta de año, según las URLs corregidas que compartió el usuario).
- Se guardó el PDF "Descripción de la base de datos nacional 2018" (INEGI) en docs/inegi_source_docs/ como referencia permanente del proyecto.
- Se enriqueció docs/DATA_DICTIONARY.md con los códigos reales de: PRESUNTO, SEXO, EDAD (decodificación de la unidad de tiempo embebida en el número), EDAD_AGRU (grupos quinquenales de INEGI + su mapeo a los 7 grupos del artículo), AREA_UR, ESCOLARIDA, EDO_CIVIL, LENGUA, COND_ACT, NECROPSIA.

🔍 Hallazgos importantes:
- PRESUNTO = 3 significa "Suicidio" directamente. Esto nos da un segundo filtro independiente (además de CAUSA_DEF en X60-X84) para identificar suicidios — la validación cruzada más sólida disponible, mejor que solo comparar contra el total de 3,572 casos del artículo.
- EDAD es una variable codificada, no la edad directa: el primer dígito indica la unidad (horas/días/meses/años). Para personas de 10+ años, el código va de 4001 a 4120, y la edad real = código − 4000. Esto había que descubrirlo antes de intentar construir los grupos etarios, o el filtrado habría fallado silenciosamente.
- EDAD_AGRU ya viene agrupada por INEGI, pero en grupos quinquenales (5 en 5 años), no en los 7 grupos más amplios del artículo (10-24, 25-34...). Se documentó la tabla de mapeo exacta para combinarlos en la Etapa 2.
- AREA_UR se confirma que está basada en residencia habitual (no ocurrencia), consistente con la decisión ya tomada.
- Pendiente: el documento compartido es específico de 2018 (variable PRESUNTO); para 2022-2024 el campo se llama TIPO_DEFUN y no sabemos todavía si usa los mismos códigos — se necesita el mismo tipo de documento pero de un año 2022+ para confirmarlo.

📊 Métricas:
- 8/8 URLs de descarga corregidas.
- 9 variables con códigos reales documentados (antes 0).
- 1 variable de validación cruzada de alta confianza identificada (PRESUNTO=3).

➡️ Próximos pasos:
1. Correr el notebook con las URLs corregidas.
2. Si es posible, conseguir el documento equivalente de descripción de base de datos para 2022 o posterior, para decodificar TIPO_DEFUN.
3. Con esto ya tenemos lo suficiente para empezar a redactar el script de limpieza/estandarización real (Etapa 2).
