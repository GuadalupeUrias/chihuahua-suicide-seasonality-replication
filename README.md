# chihuahua-suicide-seasonality-replication

## Réplica y extensión: Tendencia y estacionalidad del suicidio en Chihuahua, México (2008-2018)

Proyecto académico de **réplica de investigación científica**, con fines de aprendizaje en curación de datos, análisis estadístico y reproducibilidad.

## Artículo original

Fernández-López, M., Hernández-Montes, R. I., Álvarez Reza, S., & Flores-Olivares, L. A. (2021).
*Tendency and seasonality of suicide in Chihuahua, México. A retrospective analysis from 2008 to 2018.*
Salud Mental, 44(2), 43-52. https://doi.org/10.17711/SM.0185-3325.2021.008

## Objetivo del proyecto

1. **Replicar** los resultados del artículo original usando datos públicos de INEGI (mortalidad) y CONAGUA (temperatura), periodo 2008-2018.
2. **Documentar** el proceso completo de curación de datos (diagnóstico, limpieza, estandarización, validación).
3. **Extender** el análisis más allá de 2018, hasta el año más reciente disponible en INEGI (actualmente hasta 2024). Los datos de mortalidad 2019-2024 se descargan **desde ahora**, junto con los de la réplica, ya que INEGI agrupa varios años en un mismo archivo (ver `docs/DATA_SOURCES.md`) y conviene descargarlos una sola vez.

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

🟢 **Etapa 1 — Diagnóstico inicial: COMPLETA para la fuente de mortalidad** (población y temperatura pendientes)
🔵 **Etapa 2 — Limpieza/Filtrado: siguiente paso**

Reportes generados hasta ahora (ver `reports/`):
1. `01_diagnostico_fuentes.md` — identificación inicial de las 3 fuentes de datos
2. `02_fuentes_exactas_articulo.md` — fuentes exactas confirmadas con el texto completo del artículo
3. `03_mapeo_campos_cubo.md` — renombre del proyecto y mapeo de variables del cubo de INEGI
4. `04_correccion_fuente_microdatos.md` — corrección: usar portal de microdatos, no el cubo OLAP
5. `05_notebook_descarga_git.md` — notebook de descarga automatizada e instrucciones de git
6. `06_estructura_archivos_inegi.md` — corrección de la estructura real de archivos INEGI (consolidados por periodo) y adelanto de años de extensión
7. `07_urls_confirmadas_gitignore.md` — URLs de descarga confirmadas, .gitignore para datos crudos, instrucciones de git en archivo dedicado
8. `08_error_permisos_git_push.md` — solución al error de permisos (403) al hacer git push con la cuenta incorrecta
9. `09_correccion_bug_sintaxis_notebook.md` — corrección de bug de sintaxis en el notebook de descarga (comillas mal escapadas)
10. `10_perfilado_columnas_cambio_esquema.md` — perfilado real de columnas por periodo; detección de cambio de esquema (PRESUNTO→TIPO_DEFUN en 2022)
11. `11_codigos_decodificados_urls_corregidas.md` — códigos reales decodificados (PRESUNTO=Suicidio, EDAD, EDAD_AGRU) y corrección de URLs 2022-2024
12. `12_tipo_defun_confirmado_armonizacion.md` — TIPO_DEFUN confirmado (2022-2024) y tabla de armonización con PRESUNTO (código 4 cambia de significado)
13. `13_diagnostico_distribucion_filas_sospechosa.md` — celda de diagnóstico agregada por distribución sospechosa de filas por año dentro de los archivos consolidados
14. `14_bug_carga_archivos_consolidados_corregido.md` — bug real encontrado y corregido: los .zip consolidados traen un .dbf por año, no uno solo con todos los años
15. `15_correccion_confirmada_mortalidad_lista.md` — corrección confirmada con datos reales; mortalidad nacional 2005-2024 lista para filtrado

## Cómo contribuir datos crudos

Este proyecto requiere datos descargados manualmente de fuentes gubernamentales (ver `docs/DATA_SOURCES.md`), ya que no es posible automatizar su descarga desde este entorno. Usa `notebooks/01_download_extract_mortalidad.ipynb` en tu computadora (completando las URLs por año) para automatizar la descarga y extracción de los microdatos de mortalidad, o descarga manualmente y coloca los archivos sin modificar en `data/raw/`.

## Instrucciones de git

Ver **`GIT_INSTRUCTIONS.md`** (raíz del repo) — incluye configuración de usuario, autenticación, primer push, avances siguientes y manejo de `data/raw/` (ignorado por `.gitignore`, ya que son archivos públicos, pesados y re-descargables).

## Cita

Si usas este repositorio, cita también el artículo original (ver arriba) y, si aplica, la fuente armonizada del INSP-UISP (ver `docs/DATA_SOURCES.md`).

## Licencia de datos

Los datos de INEGI y CONAGUA son de acceso abierto. Este repositorio es de uso académico/educativo.
