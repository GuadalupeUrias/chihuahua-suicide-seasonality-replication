📋 REPORTE — Diagnóstico inicial (parte 5: notebook de descarga + instrucciones de git)

✅ Trabajo realizado:
- Se creó notebooks/01_download_extract_mortalidad.ipynb con 5 secciones: descarga por streaming, extracción de zips, carga (soporta CSV y DBF), inspección de columnas por año, y guardado en parquet en data/interim/.
- Se añadieron requests, pyarrow, dbfread y jupyter a requirements.txt.
- Se agregaron instrucciones de git completas al README.md (primera vez vs. avances siguientes, recomendación de un commit por etapa, manejo de archivos grandes con .gitignore).

🔍 Hallazgos importantes:
- INEGI no usa una URL predecible por año para sus microdatos (cada archivo tiene un ID interno arbitrario). Por eso el notebook tiene un diccionario YEAR_URLS vacío que el usuario debe completar manualmente (clic derecho → "copiar enlace" en el portal), para cada año 2008-2018.
- El notebook está pensado para correr en la computadora del usuario, no en este entorno (sin acceso a inegi.org.mx desde aquí).

📊 Métricas:
- Notebook validado (13 celdas, sintaxis correcta).
- 11 URLs pendientes de completar por el usuario.

➡️ Próximos pasos:
1. Completar al menos 1-2 URLs en YEAR_URLS (sugerido: 2018 y 2008, para detectar diferencias de formato pronto).
2. Correr el notebook hasta la sección 4 (revisión de columnas) y compartir esa salida para estandarizar nombres de columnas entre años.
3. Hacer el primer commit real del repositorio.
