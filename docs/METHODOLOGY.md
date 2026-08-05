# Notas metodológicas de la réplica

Este documento registra las decisiones metodológicas tomadas durante la réplica, especialmente cuando el artículo original no especifica un detalle exacto (fuente de estación climática, tratamiento de valores faltantes, etc.). Cada decisión debe quedar aquí con su justificación.

## Ambigüedades detectadas en el artículo original (a resolver o documentar como supuesto)

1. **Estación(es) climática(s):** el artículo no especifica qué estación(es) de CONAGUA se usaron para la variable "temperatura ambiental". → Decisión pendiente (etapa de diagnóstico).
2. **Fuente exacta de denominadores poblacionales:** no se detalla si usaron proyecciones de CONAPO, censos INEGI o estimaciones propias. → Decisión pendiente.
3. **Definición de grupos etarios completos:** el resumen menciona 10-24 y 25-34 años con incremento significativo, pero no lista todos los grupos etarios analizados. → Se replicarán los mencionados explícitamente y se documentará cualquier grupo adicional que agreguemos en la extensión.
4. **Software/paquete usado para el modelo de series de tiempo** (ej. `forecast` en R, `statsmodels` en Python) no se especifica. → Usaremos Python (statsmodels) por defecto, documentando que puede haber pequeñas diferencias numéricas frente al software original.

## Plan de extensión (una vez completada la réplica)

- Actualizar la serie más allá de 2018 (sujeto a disponibilidad de datos).
- Explorar variables climáticas adicionales (humedad, precipitación).
- Comparar métodos de series de tiempo (ej. STL vs. descomposición clásica vs. SARIMA).

## Registro de decisiones (se va llenando conforme avancemos)

| Fecha | Decisión | Justificación | Etapa |
|---|---|---|---|
| — | — | — | — |
