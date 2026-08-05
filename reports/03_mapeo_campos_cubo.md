📋 REPORTE — Diagnóstico inicial (parte 3: renombre del proyecto y mapeo de campos del cubo)

✅ Trabajo realizado:
- Se renombró el proyecto/directorio a chihuahua-suicide-seasonality-replication (antes replica-suicidio-chihuahua), actualizando todas las referencias internas.
- Se mapeó cada campo real disponible en el cubo OLAP de INEGI contra lo que necesita la réplica (tabla completa en docs/DATA_SOURCES.md).
- Se confirmó la tabla correcta a usar dentro del cubo: "Defunciones accidentales y violentas".
- Se documentaron dos decisiones propias donde el artículo no es explícito y el cubo obliga a elegir: (1) usar "entidad de residencia habitual" en vez de "ocurrencia"/"registro", para que el numerador de muertes sea consistente con el denominador de población de CONAPO; (2) derivar "método de suicidio" a partir de los códigos CIE-10 específicos dentro de X60-X84, ya que no existe como campo directo.

🔍 Hallazgos importantes:
- El cubo cubre casi todas las variables que el artículo reporta haber usado (escolaridad, estado civil, lengua indígena, actividad económica, urbano/rural, sexo, edad, mes/año de ocurrencia).
- No existe un campo de "método de suicidio" directamente en el cubo.
- La decisión de usar "residencia habitual" queda registrada como supuesto documentado, no como algo que los autores originales especificaron.

📊 Métricas:
- 12 de ~13 variables disponibles en el cubo mapeadas a necesidades de la réplica.

➡️ Próximos pasos:
1. Confirmar con el usuario el uso de "residencia habitual".
2. Proceder a la descarga real de los datos.
