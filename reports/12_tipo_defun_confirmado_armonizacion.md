📋 REPORTE — Diagnóstico inicial (parte 12: TIPO_DEFUN confirmado, tabla de armonización)

✅ Trabajo realizado:
- Se guardó el segundo PDF de referencia (Descripción de la base de datos 2022, INEGI) en docs/inegi_source_docs/.
- Se actualizó docs/DATA_DICTIONARY.md con los códigos reales de TIPO_DEFUN y una tabla de armonización explícita contra PRESUNTO.

🔍 Hallazgos importantes:
- Confirmado: código 3 = "Suicidio" tanto en PRESUNTO (2005-2021) como en TIPO_DEFUN (2022-2024). El filtro de control cruzado (== 3) es válido en todo el rango 2008-2024 sin necesidad de casos especiales.
- ⚠️ Hallazgo crítico: el código 4 CAMBIÓ de significado entre las dos variables. En PRESUNTO, 4 = "Se ignora". En TIPO_DEFUN, 4 = "Enfermedad (Muerte natural)". Si el script de limpieza tratara ambos campos como directamente intercambiables sin mapeo explícito, cualquier filtro que dependiera del código 4 (o de "todos los códigos del 1 al 5") produciría resultados incorrectos para 2022-2024 sin lanzar ningún error visible — es exactamente el tipo de bug silencioso que un buen proceso de curación debe anticipar.
- TIPO_DEFUN parece aplicar a todas las defunciones (incluye la categoría de muerte natural), mientras que PRESUNTO parecía limitarse al apartado de accidentales y violentas. La variable no solo cambió de nombre, ampliaron su alcance.
- Se identificó una variable de control adicional disponible desde 2022: NATVIOLE (defunción de tipo accidental o violenta, sí/no) — útil como filtro complementario, aunque no sustituye a TIPO_DEFUN==3 para identificar suicidios específicamente.

📊 Métricas:
- 2/2 variables de control cruzado (PRESUNTO, TIPO_DEFUN) con códigos totalmente decodificados.
- 1 riesgo de bug silencioso identificado y documentado antes de escribir una sola línea del script de limpieza.

➡️ Próximos pasos:
1. Ya tenemos toda la información necesaria (fuentes, estructura de archivos, códigos, mapeos de edad y tipo de defunción) para comenzar a redactar el script real de limpieza y estandarización — Etapa 2.
2. Sugerido: antes de escribir el script completo, correr el notebook 01 para obtener al menos un año cargado en data/interim/ y validar contra los datos reales que los códigos documentados aquí coinciden con lo que aparece en el archivo.
