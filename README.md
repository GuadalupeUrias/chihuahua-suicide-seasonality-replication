# chihuahua-suicide-seasonality-replication

## Réplica y extensión: Tendencia y estacionalidad del suicidio en Chihuahua, México (2008-2018)

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
| Población de estudio | Defunciones por lesiones autoinfligidas intencionalmente (CIE-10 X60-X84), Chihuahua |
| Periodo | 2008-2018 (3,572 suicidios reportados en total) |
| Fuente de mortalidad | INEGI, estadísticas de mortalidad / registros vitales |
| Fuente de población (denominador) | CONAPO, proyecciones con base en censos 2005 y 2010 |
| Fuente de temperatura | SMN/CONAGUA, Información Estadística Climatológica (promedio diario → mensual, nivel estatal) |
| Grupos etarios (7) | 10-24, 25-34, 35-44, 45-54, 55-64, 65-74, 75+ |
| Otras variables recolectadas | Escolaridad, estado civil, residencia urbano/rural, método de suicidio, hablante de lengua indígena, actividad económica (estas 3 últimas solo desde 2012) |
| Análisis 1 | Tasa de suicidio (por 100,000 hab.), tendencia (serie de tiempo) y estacionalidad (prueba Dickey-Fuller, factor de estacionalidad) |
| Análisis 2 | Modelo Poisson: número de suicidios ~ temperatura (por sexo) |
| Análisis 3 | Análisis de correspondencia múltiple (sexo, grupo etario, estado civil, método; y por separado: lengua indígena, actividad económica, escolaridad, método) |
| Análisis 4 | Correlación de Spearman entre tasa de suicidio y grupo etario; regresión lineal de tendencia por grupo etario |
| Prueba de autocorrelación | Ljung-Box |
| Nivel de confianza | 95% en todas las pruebas |

## Estructura del repositorio

```
chihuahua-suicide-seasonality-replication/
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

Este proyecto requiere datos descargados manualmente de fuentes gubernamentales (ver `docs/DATA_SOURCES.md`), ya que no es posible automatizar su descarga desde este entorno. Usa `notebooks/01_download_extract_mortalidad.ipynb` en tu computadora (completando las URLs por año) para automatizar la descarga y extracción de los microdatos de mortalidad, o descarga manualmente y coloca los archivos sin modificar en `data/raw/`.

## Instrucciones de git

Este repositorio se generó fuera de git (en el entorno de Claude) y se entrega como .zip en cada avance. Así lo integras a tu repo remoto vacío:

### Primera vez (repo local aún no existe)
```bash
git clone <URL-de-tu-repo-remoto> chihuahua-suicide-seasonality-replication
cd chihuahua-suicide-seasonality-replication
# Descomprime el .zip que te compartí y copia TODO su contenido aquí (sobrescribiendo si aplica)
git add .
git commit -m "Etapa 1: estructura del proyecto, fuentes de datos y notebook de descarga"
git push origin main   # usa 'master' si tu rama por defecto se llama así
```

### Avances siguientes (ya tienes el repo local)
```bash
cd chihuahua-suicide-seasonality-replication
# Descomprime el nuevo .zip y copia/sobrescribe los archivos actualizados
git status                 # revisa qué cambió antes de subir
git add .
git commit -m "Descripción breve del avance (ej. Etapa 2: limpieza de microdatos)"
git push origin main
```

### Recomendaciones
- Haz un commit por cada etapa completada (coincide con los reportes 📋 en `reports/`), no uno solo gigante al final — así el historial documenta el proceso, que es justo el punto de un ejercicio de reproducibilidad.
- Si vas a subir los datos crudos (`data/raw/`) al repo, ten cuidado con el tamaño — GitHub bloquea archivos individuales mayores a 100 MB. Si algún archivo de INEGI pesa más, actívalo en `.gitignore` (ya está la línea comentada, lista para usar) y en su lugar documenta en `docs/DATA_SOURCES.md` dónde conseguirlo.
- Revisa `git log --oneline` de vez en cuando para verificar que el historial cuente la historia del proyecto tal como fue avanzando.

## Cita

Si usas este repositorio, cita también el artículo original (ver arriba) y, si aplica, la fuente armonizada del INSP-UISP (ver `docs/DATA_SOURCES.md`).

## Licencia de datos

Los datos de INEGI y CONAGUA son de acceso abierto. Este repositorio es de uso académico/educativo.
