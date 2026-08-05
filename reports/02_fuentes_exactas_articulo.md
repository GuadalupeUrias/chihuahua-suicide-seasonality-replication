📋 REPORTE — Diagnóstico inicial (parte 2: fuentes exactas, apegadas al artículo original)

✅ Trabajo realizado:
- Se obtuvo el texto completo del artículo (no solo el abstract), donde los autores detallan su método con precisión.
- Se reescribió docs/DATA_SOURCES.md eliminando cualquier alternativa: ahora describe solo las 3 fuentes exactas que los autores citan, con pasos directos de descarga.
- Se actualizaron README.md y docs/METHODOLOGY.md con el detalle completo del método original.

🔍 Hallazgos importantes:
- Mortalidad: INEGI, sección de defunciones accidentales y violentas, CIE-10 X60-X84. El enlace citado en el artículo (2001) ya no existe; se usó el cubo dinámico vigente equivalente.
- Población: los autores confirman explícitamente CONAPO, con base en censos 2005 y 2010.
- Temperatura: SMN/CONAGUA, promedio diario a mensual, a nivel estatal (los propios autores reconocen esto como limitación, no llegaron a nivel municipal).
- 7 grupos etarios exactos: 10-24, 25-34, 35-44, 45-54, 55-64, 65-74, 75+.
- Variables de lengua indígena, actividad económica y método de suicidio solo existen desde 2012 en la fuente.
- Cifra de control para validar la descarga: 3,572 suicidios totales en el periodo 2008-2018.
- Único punto que sigue sin poder resolverse con certeza: qué estación(es) climatológica(s) exactas promediaron para el dato "estatal" — limitación reconocida por el propio estudio.

📊 Métricas:
- 3/3 fuentes con instrucciones únicas y directas (antes tenían variantes A/B).

➡️ Próximos pasos:
1. Descargar el archivo de mortalidad siguiendo los pasos exactos de docs/DATA_SOURCES.md (sección 1).
2. Verificar que el total cuadre cerca de 3,572 registros como primer chequeo de calidad.
