# Réplica y extensión: Tendencia y estacionalidad del suicidio en Chihuahua, México (2008-2018)

Proyecto académico de **réplica de investigación científica**, con fines de aprendizaje en curación de datos, análisis estadístico y reproducibilidad.

## Artículo original

Fernández-López, M., Hernández-Montes, R. I., Álvarez Reza, S., & Flores-Olivares, L. A. (2021).
*Tendency and seasonality of suicide in Chihuahua, México. A retrospective analysis from 2008 to 2018.*
Salud Mental, 44(2), 43-52. https://doi.org/10.17711/SM.0185-3325.2021.008

## Objetivo del proyecto

1. **Replicar** los resultados del artículo original usando datos públicos de INEGI (mortalidad) y CONAGUA (temperatura).
2. **Documentar** el proceso completo de curación de datos (diagnóstico, limpieza, estandarización, validación).
3. **Extender** el análisis: actualizar la serie a años recientes y/o probar variables adicionales.

## Diseño del estudio original (resumen metodológico)

| Elemento | Descripción |
|---|---|
| Población | Defunciones por lesiones autoinfligidas intencionalmente (CIE-10 X60-X84), Chihuahua |
| Periodo | 2008-2018 |
| Fuente de mortalidad | INEGI, Estadísticas de Defunciones Registradas |
| Fuente de temperatura | Ambiental, usada como variable predictora |
| Análisis 1 | Tasa de suicidio (por 100,000 hab.), tendencia y estacionalidad vía modelo de series de tiempo |
| Análisis 2 | Modelo Poisson: número de suicidios ~ temperatura |
| Desagregación | Sexo, grupo etario (10-24, 25-34, entre otros) |

## Estructura del repositorio

```
replica-suicidio-chihuahua/
├── data/
│   ├── raw/          # Datos originales sin modificar (INEGI, CONAGUA) — NO se edita a mano
│   ├── interim/       # Datos en proceso de limpieza/transformación
│   └── processed/     # Dataset(s) curado(s) final(es), listos para análisis
├── scripts/            # Scripts de limpieza, transformación, validación y modelado
├── notebooks/          # Notebooks exploratorios (si se usan)
├── docs/
│   ├── DATA_SOURCES.md        # Fuentes de datos: dónde y cómo se obtuvieron
│   ├── DATA_DICTIONARY.md     # Diccionario de variables del dataset curado
│   └── METHODOLOGY.md         # Notas metodológicas y decisiones de réplica
├── reports/             # Reportes de curación por etapa (formato 📋 REPORTE)
├── outputs/             # Tablas y figuras finales
└── README.md
```

## Estado actual del proyecto

🔵 **Etapa 1 — Diagnóstico inicial: EN CURSO**

Ver `reports/` para el detalle de cada etapa completada.

## Cómo contribuir datos crudos

Este proyecto requiere datos descargados manualmente de fuentes gubernamentales (ver `docs/DATA_SOURCES.md`), ya que no es posible automatizar su descarga desde este entorno. Coloca los archivos descargados sin modificar en `data/raw/`, respetando el nombre sugerido en `docs/DATA_SOURCES.md`.

## Cita

Si usas este repositorio, cita también el artículo original (ver arriba) y, si aplica, la fuente armonizada del INSP-UISP (ver `docs/DATA_SOURCES.md`).

## Licencia de datos

Los datos de INEGI y CONAGUA son de acceso abierto. Este repositorio es de uso académico/educativo.
