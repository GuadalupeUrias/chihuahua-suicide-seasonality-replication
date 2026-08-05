📋 REPORTE — Diagnóstico inicial (parte 13: distribución sospechosa de filas por año)

✅ Trabajo realizado:
- Se insertó una celda de diagnóstico nueva (sección 4.5) en el notebook, antes del filtrado por año, que imprime: tipo de dato de la columna de año, valores únicos sin filtrar, conteo por valor más frecuente, y total de filas del archivo consolidado.

🔍 Hallazgos importantes:
- El usuario reportó que, dentro de cada archivo consolidado (2005-2009, 2010-2014, 2015-2019), solo el último año de cada bloque tiene un número de filas realista (500,000+), mientras que los años anteriores tienen apenas cientos o miles de filas (ej. 231 para 2010, 300 para 2011, 629 para 2012, pero 618,097 para 2014).
- Esto no es plausible como cifra real de defunciones nacionales por año, así que antes de asumir que es un problema en la lógica de filtrado (comparación de string), hay que descartar un problema de tipo de dato en la columna ANIO_OCUR al leer el .dbf con dbfread (ej. valores con espacios, en float, o en bytes).
- El usuario mencionó tener a la mano los totales ya descargados del cubo OLAP de INEGI, lo cual servirá como referencia de comparación una vez que se resuelva el diagnóstico.

📊 Métricas: N/A (diagnóstico de calidad de datos, no de conteos aún confiables).

➡️ Próximos pasos:
1. Correr la nueva celda de diagnóstico (sección 4.5) y compartir la salida completa.
2. Con esa salida, decidir si el problema es de tipo de dato (se corrige el filtro) o si es un patrón real de la fuente (se documenta como hallazgo, no como error).
3. Una vez resuelto, comparar contra los totales del cubo OLAP para validar.
