# Diccionario de datos — mapeo de variables entre periodos (INEGI, microdatos de mortalidad)

Basado en las columnas reales compartidas por el usuario (sección 4 del notebook `01_download_extract_mortalidad.ipynb`), para los 8 archivos: 2005-2009, 2010-2014, 2015-2019, 2020, 2021, 2022, 2023, 2024.

## ✅ Buena noticia: la columna de año es consistente

`ANIO_OCUR` (año de ocurrencia) existe **idéntica en los 8 archivos**, sin necesidad de mapeo. Ya está confirmada en el notebook.

## Variables núcleo — presentes sin cambio de nombre en TODOS los periodos (2005-2024)

Estas son las que usaremos como columna vertebral del dataset curado:

| Variable INEGI | Significado | Uso en la réplica |
|---|---|---|
| `ENT_RESID` / `MUN_RESID` | Entidad / municipio de **residencia habitual** | Filtro geográfico (Chihuahua = clave 08) — decisión ya tomada de usar residencia, no ocurrencia |
| `ENT_OCURR` / `MUN_OCURR` | Entidad / municipio de **ocurrencia** | Disponible por si se quiere correr el análisis de sensibilidad mencionado en `docs/METHODOLOGY.md` |
| `CAUSA_DEF` | Causa de defunción, código CIE-10 | Filtro principal: X60-X84 |
| `SEXO` | Sexo | Desagregación del artículo |
| `EDAD` | Edad (código INEGI, no año simple — hay que decodificar con el diccionario de datos) | Para construir los 7 grupos etarios |
| `EDAD_AGRU` | Edad ya agrupada por INEGI | ⚠️ Hay que revisar si sus categorías coinciden con los 7 grupos del artículo (10-24, 25-34...) o si INEGI usa una agrupación distinta — pendiente de confirmar con el diccionario de datos |
| `DIA_OCURR` / `MES_OCURR` / `ANIO_OCUR` | Fecha de ocurrencia | Variable temporal principal del análisis de estacionalidad |
| `ESCOLARIDA` | Escolaridad | Reportada en Tabla 1 del artículo |
| `EDO_CIVIL` | Estado civil | Reportada en Tabla 1 |
| `AREA_UR` | Área urbana/rural | Reportada en Tabla 1 (⚠️ no se distingue si es de residencia u ocurrencia solo por el nombre; a confirmar con el diccionario de datos) |
| `OCUPACION` / `COND_ACT`* | Ocupación / condición de actividad económica | *`COND_ACT` no existe en 2005-2009 (ver abajo) |
| `NACIONALID` | Nacionalidad | Disponible, no usada explícitamente en el artículo |
| `NECROPSIA` | Condición de necropsia | Reportada como variable del cubo original |

## ⚠️ Cambio de esquema #1 — alrededor de 2010-2012 (afecta la réplica 2008-2018)

| Variable | 2005-2009 | 2010 en adelante |
|---|---|---|
| `LENGUA` (habla lengua indígena) | ❌ No existe | ✅ Existe desde el archivo 2010-2014 |
| `COND_ACT` (actividad económica) | ❌ No existe | ✅ Existe desde el archivo 2010-2014 |

Esto **coincide** con lo que el artículo advierte (esas variables solo están disponibles desde 2012). Aun cuando el campo `LENGUA`/`COND_ACT` ya existe en el archivo 2010-2014 completo, es posible que para 2010-2011 venga vacío/nulo — **hay que verificarlo con los datos reales**, no solo con la presencia de la columna, cuando carguemos el archivo.

📌 Nota: 2005-2009 sí tiene una variable `PESO` (peso al nacer, relevante para defunciones maternas/infantiles) que no está en periodos posteriores — no aplica a nuestro análisis de suicidio.

## ⚠️ Cambio de esquema #2 — a partir de 2022 (afecta la extensión 2022-2024)

Este es el cambio más importante a documentar:

| Variable hasta 2021 | Variable desde 2022 | Qué significa |
|---|---|---|
| `PRESUNTO` | `TIPO_DEFUN` | **Este es el campo de "tipo de defunción" (accidente/homicidio/suicidio/etc.) que identificamos como control cruzado en el cubo OLAP.** Cambió de nombre. Hay que verificar en cada diccionario de datos que las categorías (valores posibles) sean equivalentes entre `PRESUNTO` y `TIPO_DEFUN`. |
| `VIO_FAMI` (violencia familiar) | Desaparece en 2022, **reaparece** en 2023-2024 | Posible inconsistencia de un solo año (2022) en la fuente — a confirmar, no es algo que nosotras estemos causando |

Además, desde 2022 INEGI agrega bastantes variables nuevas que **no existían antes** y que en su mayoría no son relevantes para este proyecto (relacionadas con nacimientos/defunciones maternas: `SEM_GEST`, `GRAMOS`, `EMBARAZO`... ya existía; `NACESP_CVE`; o con donación de órganos: `DONADOR`, `ENCEFALICA`; o identidad: `AFROMEX`, `CONINDIG`, `CVE_LENGUA`, `ENT_NAC`). No se incluirán en el dataset curado salvo que decidamos enriquecer el análisis de extensión con alguna de ellas.

## Variable de control cruzado (para validar el filtro CIE-10)

Como se documentó en `docs/DATA_SOURCES.md`, usaremos:
- `PRESUNTO` (2005-2021) / `TIPO_DEFUN` (2022-2024) — para verificar que el filtro por `CAUSA_DEF` en X60-X84 identifique la misma cantidad de "presuntos suicidios" que este campo directo.

## Pendiente antes de la limpieza (Etapa 2)

1. **Diccionario de datos (codebook) de al menos un archivo de cada periodo** (2005-2009, 2010-2014, 2015-2019, 2022) — para decodificar los valores numéricos de `SEXO`, `ENT_RESID` (confirmar que Chihuahua = 08), `EDAD`/`EDAD_AGRU`, `PRESUNTO`/`TIPO_DEFUN` (¿qué código = suicidio?), `ESCOLARIDA`, `EDO_CIVIL`, `AREA_UR`.
2. Confirmar si `EDAD_AGRU` ya trae una agrupación utilizable o si hay que construir los 7 grupos del artículo desde `EDAD` (variable numérica/codificada).
3. Verificar en los datos reales (no solo en las columnas) si `LENGUA`/`COND_ACT` vienen vacíos en 2010-2011, consistente con lo que dice el artículo.
