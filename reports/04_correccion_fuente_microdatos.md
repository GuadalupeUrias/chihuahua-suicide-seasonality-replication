📋 REPORTE — Diagnóstico inicial (parte 4: corrección de herramienta de extracción)

✅ Trabajo realizado:
- Se identificó que el cubo OLAP de INEGI está diseñado para tabulación cruzada (conteos agregados), no para exportar microdatos fila por fila; por eso al exportarlo con muchas variables sin criterios definidos solo entrega totales.
- Se localizó el portal correcto para microdatos: https://www.inegi.org.mx/programas/edr/ → pestaña "Microdatos", con archivos por año (DEFUN08...DEFUN18) y su diccionario de datos (codebook).
- Se actualizaron docs/DATA_SOURCES.md y docs/METHODOLOGY.md reflejando este cambio de herramienta, aclarando que la tabla de totales del cubo no se desperdicia: se usa como control de calidad cruzado.

🔍 Hallazgos importantes:
- Los archivos de microdatos son bases nacionales completas (todas las causas, las 32 entidades), por lo que pueden pesar bastante.
- Se documentó una salida por si algún archivo es demasiado grande para subir al chat: filtrar solo por entidad = Chihuahua en Excel antes de subir (sin tocar causa), registrado como excepción justificada por tamaño de archivo, no como desviación de la réplica.

📊 Métricas:
- 11 archivos de microdatos + 11 diccionarios de datos esperados (uno por año, 2008-2018).

➡️ Próximos pasos:
1. Guardar la tabla de totales ya generada en el cubo como control.
2. Descargar al menos un año de microdatos (sugerido: 2018) para probar tamaño y estructura antes de descargar los 11.
