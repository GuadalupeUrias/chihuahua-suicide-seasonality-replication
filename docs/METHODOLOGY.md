# Notas metodológicas de la réplica

Este documento registra las decisiones metodológicas tomadas durante la réplica. Se basa en el texto completo del artículo (sección "Method"), no solo en el abstract, para apegarnos lo más posible a lo que hicieron los autores originales.

## Método original, confirmado con el texto completo

- **Mortalidad:** INEGI, estadísticas de mortalidad (referencia INEGI, 2001), causa CIE-10 X60-X84, en el apartado de defunciones accidentales y violentas.
- **Población (denominador de tasas):** proyecciones de CONAPO, con base en los censos de 2005 y 2010.
- **Temperatura:** promedio diario por estación meteorológica, agregado a promedio mensual; fuente SMN/CONAGUA (Información Estadística Climatológica). Usada a **nivel estatal**, no municipal.
- **Grupos etarios (7):** 10-24, 25-34, 35-44, 45-54, 55-64, 65-74, 75+.
- **Variables con disponibilidad limitada:** hablante de lengua indígena, actividad económica y método de suicidio solo están disponibles desde 2012 en la fuente de INEGI; el resto desde 2008.
- **Análisis estadístico:**
  - Serie de tiempo univariada de la tasa de suicidio 2008-2018, con prueba de Ljung-Box (autocorrelación).
  - Factor de estacionalidad (%) y prueba de Dickey-Fuller.
  - Regresión Poisson: número de suicidios ~ temperatura, por sexo.
  - Análisis de correspondencia múltiple (dos análisis separados, con distintas variables).
  - Correlación de Spearman entre tasa de suicidio y grupo etario.
  - Regresión lineal de tendencia por grupo etario.
  - Todas las pruebas con intervalo de confianza del 95%.

## Único punto que el propio artículo deja sin especificar (limitación reconocida por los autores, no ambigüedad nuestra)

- **Qué estación(es) climatológica(s) específicas se promediaron** para obtener el dato "estatal" de temperatura. Los autores mencionan esto como limitación propia del estudio ("temperatures were obtained at the state rather than the municipal level"), sin detallar cuántas ni cuáles estaciones. No es reproducible con certeza absoluta; documentaremos la agregación que nosotros usemos (ej. promedio de todas las estaciones SMN disponibles en Chihuahua) como nuestra propia decisión, señalando que es la mejor aproximación posible a lo que ellos describen.

## Decisiones nuestras (donde el cubo actual de INEGI nos obliga a elegir algo que el artículo no especifica)

- **Geografía del numerador (defunciones): "residencia habitual" vs. "ocurrencia" vs. "registro".** El cubo actual de INEGI ofrece las tres. El artículo solo dice "obtained ... in the state of Chihuahua", sin aclarar cuál usaron. Elegimos **residencia habitual**, porque es la práctica estándar en epidemiología para que el numerador (muertes) y el denominador (población de CONAPO, que es por residencia) describan a la misma población, evitando distorsiones por personas que fallecieron fuera de su estado de residencia. Queda pendiente, si el usuario lo solicita, correr un análisis de sensibilidad con "entidad de ocurrencia" para comparar.
- **Método de suicidio:** el cubo no tiene un campo directo de "método"; se reconstruirá a partir de los códigos CIE-10 específicos dentro de X60-X84 (ver mapeo en `docs/DATA_SOURCES.md`).
- **Herramienta de extracción:** se usa el portal de **microdatos** (`inegi.org.mx/programas/edr/` → pestaña Microdatos), no el cubo OLAP, porque el cubo solo entrega tabulaciones agregadas y no permite exportar una fila por defunción con todas las variables juntas. El cubo se conserva únicamente como fuente de totales de control/validación cruzada.

## Software

El artículo no especifica el software/paquete estadístico usado. Usaremos Python (pandas, statsmodels, scipy) por defecto, documentando que puede haber pequeñas diferencias numéricas frente al software original (posiblemente SPSS, a juzgar por la terminología "LCS/LCI" en las figuras, típica de esa salida).

## Plan de extensión (una vez completada la réplica)

- Actualizar la serie más allá de 2018 (sujeto a disponibilidad de datos).
- Explorar variables climáticas adicionales (humedad, precipitación).
- Comparar métodos de series de tiempo (ej. STL vs. descomposición clásica vs. SARIMA).

## Registro de decisiones (se va llenando conforme avancemos)

| Fecha | Decisión | Justificación | Etapa |
|---|---|---|---|
| — | — | — | — |
