# Fuentes de datos (idénticas a las del artículo original)

Este documento describe **únicamente** las fuentes que los autores reportan haber usado en la sección "Method" del artículo (texto completo consultado, no solo el abstract). No se presentan alternativas: el objetivo es apegarnos a la réplica.

## ⚠️ Nota sobre automatización

Este entorno donde corre Claude no tiene acceso de red a `inegi.org.mx`, `conagua.gob.mx`/`smn.conagua.gob.mx` (verificado directamente). Por eso las descargas las debes hacer tú siguiendo los pasos exactos de abajo, y subir los archivos al chat; yo continúo desde ahí.

---

## 1. Mortalidad (variable dependiente: suicidios)

**Fuente citada por los autores:** Instituto Nacional de Estadística y Geografía (INEGI), estadísticas de mortalidad (INEGI, 2001), repositorio/consulta de registros vitales.

> Cita textual del artículo: *"Data collection involved obtaining the number of intentional self-inflicted injuries through an examination of the detailed causes of the ICD-10 (X60 to X84) in the accidental and violent deaths section of mortality rates."*

- **Portal actual equivalente** (el enlace original de 2001 ya no existe): Cubo dinámico de Mortalidad General de INEGI
  https://www.inegi.org.mx/sistemas/olap/Proyectos/bd/continuas/mortalidad/MortalidadGeneral.asp
- **Código de causa a filtrar:** CIE-10 **X60 a X84** ("Lesiones autoinfligidas intencionalmente"), dentro del apartado de defunciones accidentales y violentas.
- **Entidad:** Chihuahua (clave 08)
- **Periodo:** 2008 a 2018

### Selección exacta en el cubo (confirmada con los campos reales disponibles, agosto 2026)

**Tabla a consultar:** ✅ *Defunciones accidentales y violentas* (coincide literalmente con la frase del artículo "the accidental and violent deaths section of mortality rates"). No uses "Defunciones registradas" (esa es la tabla general, sin el detalle de violencia/accidentes).

**Variables a marcar**, agrupadas como aparecen en el cubo:

| Grupo del cubo | Variable a marcar | Para qué la usamos |
|---|---|---|
| Características de la defunción | **Entidad y municipio de residencia habitual** | Para que el numerador (suicidios) sea consistente con el denominador de población de CONAPO, que es por residencia, no por lugar de ocurrencia del hecho. *(Ver nota metodológica abajo — es una decisión nuestra, el artículo no lo especifica).* |
| Características de la defunción | **Año de ocurrencia** | El artículo dice explícitamente "month and year of **occurrence**" |
| Características de la defunción | **Mes de ocurrencia** | Idem |
| Características de la defunción | **Causas detalladas CIE** | Para filtrar X60-X84 (en código, no en el cubo — ver más abajo) |
| Características de la persona fallecida | **Sexo** | Variable de desagregación principal |
| Características de la persona fallecida | **Edad** | La agruparemos nosotras en los 7 grupos etarios del artículo |
| Características de la persona fallecida | **Nivel de escolaridad** | Reportada en Tabla 1 del artículo |
| Características de la persona fallecida | **Estado conyugal** | Reportada en Tabla 1 (estado civil) |
| Características de la persona fallecida | **Condición de habla lengua indígena** | Reportada desde 2012 en el artículo |
| Características de la persona fallecida | **Condición de actividad económica** | Reportada desde 2012 en el artículo |
| Características de la persona fallecida | **Área urbana - rural de residencia habitual** | Reportada en Tabla 1 (urbano/rural) |
| Muertes accidentales y violentas | **Tipo de defunción** | Filtro de control cruzado: debe existir una categoría "Suicidio" o "Lesión autoinfligida"; nos sirve para verificar que el filtro por CIE-10 esté bien hecho |

📌 **No aparece en el cubo** un campo explícito de "método de suicidio" (ahorcamiento, arma de fuego, envenenamiento, etc.) — esto se deriva de los **códigos CIE-10 específicos** dentro de X60-X84 (ej. X70 = ahorcamiento, X72-X74 = arma de fuego, X60-X69 = envenenamiento, X78 = objeto cortante, X80 = salto de altura). Lo reconstruiremos nosotras a partir de "Causas detalladas CIE" — lo registro como decisión metodológica.

📌 **Decisión pendiente de confirmar contigo:** "Entidad y municipio de **residencia habitual**" vs. "**de ocurrencia**" vs. "**de registro**" — el artículo no lo aclara. Usar *residencia habitual* es la práctica estándar en epidemiología para calcular tasas (así el numerador y el denominador de población hablan de la misma población), y así lo dejo como supuesto documentado en `docs/METHODOLOGY.md`. Si prefieres que probemos con "de ocurrencia" para comparar, dímelo y lo dejamos como análisis de sensibilidad.

### ⚠️ Corrección importante: el cubo OLAP no sirve para esto — usa el portal de microdatos

Si intentas exportar el cubo con muchas variables marcadas y sin "criterios" (filtros), INEGI solo te devuelve **totales agregados**, nunca una fila por defunción. Esto es una limitación de diseño de los cubos OLAP (sirven para tabulación cruzada, no para extracción de microdatos), no un error tuyo.

**Portal correcto (microdatos, una fila = una defunción):**
https://www.inegi.org.mx/programas/edr/ → pestaña **"Microdatos"**

### Pasos exactos
1. Entra a https://www.inegi.org.mx/programas/edr/
2. Ve a la pestaña **Microdatos**.
3. Vas a encontrar un archivo de datos por año (nombrados algo como `DEFUN08`, `DEFUN09`, ... `DEFUN18` — el patrón es `DEFUN` + los 2 últimos dígitos del año). Descarga **cada año de 2008 a 2018** (11 archivos), en formato CSV o DBF.
4. Descarga también el **"Diccionario de Datos"** (codebook) de cada año — es indispensable, porque el microdato viene con **códigos numéricos**, no texto (ej. sexo = 1/2, entidad = clave de 2 dígitos, causa = código CIE-10), y esos códigos pueden cambiar ligeramente de un año a otro.
5. Sube los archivos (dato + diccionario) tal como los descargues.

📌 **Sobre el tamaño:** estos archivos son bases **nacionales completas** (todas las causas, las 32 entidades), así que pueden pesar bastante (posiblemente decenas de MB por año). Si al subirlos aquí algún archivo resulta demasiado grande:
- Intenta primero con **un solo año** (ej. 2018) para probar si el tamaño es manejable.
- Si es muy grande, ábrelo en Excel/Google Sheets y filtra solo por **entidad de residencia habitual = Chihuahua (clave 08)** antes de subirlo — seguimos dejando todas las causas sin filtrar, solo reducimos por entidad para bajar el peso del archivo. Esa sí sería una excepción justificada (filtrado manual únicamente por tamaño de archivo, documentada en `docs/METHODOLOGY.md`), no un filtrado de causa.

### El cubo OLAP no se desperdicia — lo usamos como control de calidad
Guarda igualmente la tabla de **totales** que ya generaste en el cubo (ej. suicidios por año/mes en Chihuahua) como `data/raw/inegi_cubo_totales_control.csv`. Nos sirve después para verificar que, al filtrar el microdato nosotras (X60-X84, Chihuahua, residencia habitual), lleguemos a los mismos totales — es una validación cruzada útil.

### Notebook de descarga automatizada
En vez de descargar y subir cada archivo manualmente al chat, usa `notebooks/01_download_extract_mortalidad.ipynb`. Corre **en tu computadora** (no en el entorno de Claude, que no tiene acceso a inegi.org.mx). Tú completas ahí el diccionario de URLs por año (obtenidas manualmente del portal, ya que INEGI no usa una URL predecible) y el notebook descarga, descomprime, carga y guarda cada año como parquet en `data/interim/`. Después me compartes esos archivos (son mucho más ligeros que los .zip originales) o me pegas la salida de columnas para que sigamos con la estandarización juntas.

### Variables que el artículo reporta haber extraído (resumen)
- Mes y año de ocurrencia
- Sexo
- Edad, agrupada en 7 grupos etarios: **10-24, 25-34, 35-44, 45-54, 55-64, 65-74, 75 y más**
- Escolaridad, estado civil, lugar de residencia (urbano/rural), método de suicidio (derivado del CIE), hablante de lengua indígena, condición de actividad económica
  - ⚠️ Los autores señalan que **hablante de lengua indígena, actividad económica y método** solo están disponibles a partir de **2012**; las demás variables están disponibles desde 2008.
- Total esperado de registros en el periodo completo: **3,572 suicidios** (dato reportado en el artículo) — nos sirve como cifra de control al final de la limpieza.

---

## 2. Población (denominador para tasas por 100,000 hab.)

**Fuente citada por los autores:** Consejo Nacional de Población (CONAPO), proyecciones de población, con base en los censos de 2005 y 2010.

> Cita textual: *"...based on population projections by the Consejo Nacional de Población [CONAPO, National Population Council] using the 2005 and 2010 population censuses."*

### Pasos exactos
1. Entra al portal de CONAPO: https://www.gob.mx/conapo
2. Busca "Proyecciones de la Población de México y de las Entidades Federativas" (o "Índices de Población").
3. Filtra por entidad **Chihuahua**, años 2008-2018, desagregado por **sexo y grupo quinquenal de edad** (para poder construir los mismos 7 grupos etarios del artículo).
4. Guarda el archivo como: `data/raw/conapo_poblacion_chihuahua_2008_2018.csv`

---

## 3. Temperatura ambiental (variable predictora)

**Fuente citada por los autores:** Servicio Meteorológico Nacional (SMN) / CONAGUA, base de datos de "Información Estadística Climatológica".

> Cita textual: *"This study also considered the daily average temperature record by weather station, which in turn was averaged per month to be used as a covariate... Temperature data were obtained from the Servicio Meteorológico Nacional [National Meteorological Service] from the statistical climate information database."*

- URL exacta citada por los autores (referencia CONAGUA, 2020):
  https://smn.conagua.gob.mx/es/climatologia/informacion-climatologica/informacion-estadistica-climatologica

### Pasos exactos
1. Entra a la URL de arriba.
2. Busca la temperatura **promedio diaria** por estación climatológica, disponible para el estado de Chihuahua, 2008-2018.
3. Los autores promedian la temperatura diaria a **nivel mensual**, y aclaran en sus limitaciones que trabajaron a **nivel estatal, no municipal** (no especifican cuántas ni cuáles estaciones promediaron para llegar al dato estatal — esto lo dejan como limitación propia del estudio, no algo que puedan replicar con precisión).
4. Guarda el archivo tal como lo descargues (por estación) como: `data/raw/conagua_temperatura_<estacion>_2008_2018.csv`. Si logras encontrar ya un promedio estatal mensual, mejor, guárdalo como `data/raw/conagua_temperatura_chihuahua_estatal_2008_2018.csv`.

📌 Este es el único punto donde, aunque sigamos la fuente exacta que ellos citan, **no podremos reproducir con certeza absoluta el mismo método de agregación estatal** porque no lo detallan. Lo registraremos como supuesto documentado en `docs/METHODOLOGY.md` (no es una desviación nuestra, es una limitación que el propio artículo reconoce).

---

## Checklist de archivos esperados en `data/raw/`

- [ ] `inegi_suicidios_chihuahua_2008_2018.csv` (mortalidad, INEGI)
- [ ] `conapo_poblacion_chihuahua_2008_2018.csv` (población, CONAPO)
- [ ] `conagua_temperatura_*_2008_2018.csv` (temperatura, SMN/CONAGUA)

En cuanto subas el primer archivo (idealmente el de mortalidad, es la variable principal), iniciamos el perfilado real de datos.
