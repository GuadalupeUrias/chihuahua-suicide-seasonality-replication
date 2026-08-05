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

---

## ✅ Códigos confirmados (fuente: INEGI, "Estadística de defunciones generales — Descripción de la base de datos nacional 2018", DEFUN18.dbf)

Este documento describe la tabla `DEFUN18.dbf`, que corresponde al archivo consolidado 2015-2019. Los mismos códigos aplican razonablemente bien a 2005-2014 (misma variable `PRESUNTO`, mismas categorías `EDAD_AGRU`); para 2022-2024 falta confirmar si `TIPO_DEFUN` usa los mismos códigos que `PRESUNTO` (pendiente, ver más abajo).

### 🎯 `PRESUNTO` — el campo más importante para validar el filtro de suicidio

| Código | Significado |
|---|---|
| 1 | Accidente |
| 2 | Homicidio |
| **3** | **Suicidio** |
| 4 | Se ignora |
| 5 | Operaciones legales y de guerra |
| 8 | No aplica para muerte natural |

Esto nos da un **segundo filtro independiente y directo** para identificar suicidios (`PRESUNTO == 3`), además del filtro por `CAUSA_DEF` en X60-X84. En la Etapa 2 aplicaremos ambos y compararemos que coincidan — es la validación cruzada más sólida que podemos tener, mejor incluso que solo comparar contra el total de 3,572 del artículo.

### `SEXO`
| Código | Significado |
|---|---|
| 1 | Hombre |
| 2 | Mujer |
| 9 | No especificado |

### `EDAD` — ⚠️ variable codificada, NO es la edad directa en años
Es un número de 4 dígitos donde el primer dígito indica la unidad de tiempo:
| Rango | Unidad | Ejemplo |
|---|---|---|
| 1001-1023 | Horas | 1005 = 5 horas |
| 1098 | Horas no especificadas | |
| 2001-2029 | Días | 2010 = 10 días |
| 2098 | Días no especificados | |
| 3001-3011 | Meses | 3006 = 6 meses |
| 3098 | Meses no especificados | |
| **4001-4120** | **Años** | **4025 = 25 años** |
| 4998 | Años no especificados | |

Para nuestro análisis (población 10+ años), nos interesan casi exclusivamente los códigos **4001-4120** → **edad en años = código − 4000**. Cualquier registro con código en horas/días/meses (recién nacidos) queda fuera del análisis de suicidio por construcción (no debería tener `PRESUNTO = 3` de todos modos, pero lo documentamos como regla de limpieza).

### `EDAD_AGRU` — ya viene agrupada por INEGI, en grupos quinquenales (no coincide directo con los 7 grupos del artículo)
| Código | Grupo INEGI | Código | Grupo INEGI |
|---|---|---|---|
| 01 | Menores de 1 año | 16 | 55-59 |
| 02 | 1 año | 17 | 60-64 |
| 03 | 2 años | 18 | 65-69 |
| 04 | 3 años | 19 | 70-74 |
| 05 | 4 años | 20 | 75-79 |
| 06 | 5-9 | 21 | 80-84 |
| 07 | 10-14 | 22 | 85-89 |
| 08 | 15-19 | 23 | 90-94 |
| 09 | 20-24 | 24 | 95-99 |
| 10 | 25-29 | 25-29 | 100-120 (por quinquenio) |
| 11 | 30-34 | 30 | No especificada |
| 12 | 35-39 | | |
| 13 | 40-44 | | |
| 14 | 45-49 | | |
| 15 | 50-54 | | |

**Mapeo a los 7 grupos del artículo** (a implementar en Etapa 2):
| Grupo del artículo | Códigos `EDAD_AGRU` a combinar |
|---|---|
| 10-24 | 07, 08, 09 |
| 25-34 | 10, 11 |
| 35-44 | 12, 13 |
| 45-54 | 14, 15 |
| 55-64 | 16, 17 |
| 65-74 | 18, 19 |
| 75+ | 20, 21, 22, 23, 24, 25, 26, 27, 28, 29 |

### `AREA_UR`
| Código | Significado |
|---|---|
| 1 | Urbana |
| 2 | Rural |
| 9 | No especificada |

Confirmado: es variable recodificada a partir del tamaño de localidad de **residencia habitual** (rural = localidades tipo 1-3, urbana = tipo 4-17) — consistente con nuestra decisión de trabajar con residencia habitual.

### `ESCOLARIDA`
1=Sin escolaridad, 2=Preescolar, 3=Primaria incompleta, 4=Primaria completa, 5=Secundaria incompleta, 6=Secundaria completa, 7=Bachillerato incompleto, 8=Bachillerato completo, 9=Profesional, 10=Posgrado, 88=No aplica (menores de 3 años), 99=No especificado.

### `EDO_CIVIL`
1=Soltero(a), 2=Divorciado(a), 3=Viudo(a), 4=Unión libre, 5=Casado(a), 6=Separado(a), 8=No aplica (menores de 12 años), 9=No especificado.

### `LENGUA` / `COND_ACT`
Ambas: 1=Sí, 2=No, 8=No aplica (menores de 3 o 5 años según el caso), 9=Se ignora.

### `NECROPSIA`
1=Sí, 2=No, 9=No especificada.

### Geografía (`ENT_RESID`, `ENT_OCURR`, `ENT_REGIS`, etc.)
Clave de 2 dígitos según catálogo geoestadístico de INEGI (`CATEMLDE18.dbf`, no incluido en este PDF, solo la estructura). Por convención nacional estándar de INEGI, **Chihuahua = clave 08** — lo usamos como válido, pero si al cargar los datos aparece algún registro con clave 08 que no corresponda a Chihuahua, hay que revisarlo (no tenemos el catálogo completo todavía para verificarlo con certeza absoluta).

## ⚠️ Pendiente: códigos de `TIPO_DEFUN` (2022-2024)

El documento compartido es de 2018 (`DEFUN18.dbf`), por lo que describe `PRESUNTO`, no `TIPO_DEFUN` (que aparece desde 2022). Necesitamos el mismo tipo de documento pero de un año ≥2022 para confirmar si `TIPO_DEFUN` usa los mismos códigos (1=Accidente, 2=Homicidio, 3=Suicidio...) o si INEGI los reordenó/amplió al renombrar el campo.

