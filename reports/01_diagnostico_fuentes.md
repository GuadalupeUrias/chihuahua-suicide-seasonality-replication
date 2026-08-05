📋 REPORTE — Diagnóstico inicial (parte 1: identificación de fuentes)

✅ Trabajo realizado:
- Se revisó el artículo original (DOI 10.17711/SM.0185-3325.2021.008) y se extrajo el diseño metodológico (periodo, variables, modelos).
- Se identificaron las fuentes de datos necesarias: INEGI (mortalidad), CONAPO/INEGI (población), CONAGUA (temperatura).
- Se localizó una alternativa armonizada (INSP-UISP) que integra la serie de defunciones 1990-2024 ya estandarizada, para evitar reconciliar catálogos INEGI año a año.
- Se verificó (mediante prueba de red) que este entorno no tiene acceso directo a los dominios de INEGI, CONAGUA ni riisp.insp.mx, por lo que la descarga de datos crudos debe hacerla el usuario.
- Se creó la estructura base del repositorio y documentación (README, DATA_SOURCES, METHODOLOGY, .gitignore, requirements.txt).

🔍 Hallazgos importantes:
- El artículo no especifica la estación climatológica usada para "temperatura ambiental" ni la fuente exacta de denominadores poblacionales — quedan registrados como supuestos a resolver en docs/METHODOLOGY.md.
- El portal armonizado del INSP (riisp.insp.mx) requiere registro/cuenta para descargar microdatos; el portal de INEGI permite descarga directa por año sin registro, pero entrega la base nacional completa (hay que filtrar Chihuahua + CIE-10 X60-X84 nosotros mismos).
- Restricción técnica: no puedo automatizar la descarga de estos datos desde este entorno (sin acceso de red a esos dominios). Necesito que subas los archivos crudos al chat.

📊 Métricas:
- Fuentes de datos identificadas: 3 (mortalidad, población, temperatura)
- Archivos aún pendientes de obtener: 3/3
- Años a cubrir: 11 (2008-2018)

➡️ Próximos pasos:
1. Descargar al menos el archivo de mortalidad (opción A o B en docs/DATA_SOURCES.md) y subirlo al chat.
2. En cuanto reciba el primer archivo, hago el perfilado real de datos (completitud, tipos, duplicados, cobertura Chihuahua) — segunda parte del Diagnóstico inicial.
3. En paralelo puedes ir descargando población y temperatura.
