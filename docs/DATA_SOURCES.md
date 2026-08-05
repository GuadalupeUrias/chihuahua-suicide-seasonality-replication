# Fuentes de datos y guía de descarga

## ⚠️ Nota importante sobre automatización

Este entorno de trabajo (donde corre Claude) tiene acceso de red restringido a un listado corto de dominios (repositorios de paquetes: PyPI, npm, GitHub, etc.). Los portales de INEGI (`inegi.org.mx`) y CONAGUA (`conagua.gob.mx`, `smn.conagua.gob.mx`), así como el repositorio armonizado del INSP (`riisp.insp.mx`), **no están en esa lista blanca**, por lo que no puedo descargar los archivos automáticamente vía scripts en este entorno.

Sí puedo:
- Buscar y localizar las páginas/archivos exactos que necesitas (vía búsqueda web).
- Leer contenido de páginas públicas para verificar metadatos, diccionarios de variables, etc.

No puedo:
- Ejecutar el "Descargador Masivo" de INEGI (requiere ejecutable local).
- Interactuar con portales que requieren registro/login (ej. NADA del INSP) o cubos dinámicos con formularios JavaScript.

**Por eso el flujo de trabajo es:** tú descargas el archivo desde el enlace oficial (2-3 clics) → lo subes al chat → yo lo tomo desde `data/raw/` y continúo con la curación.

---

## 1. Mortalidad — Defunciones por lesiones autoinfligidas intencionalmente (suicidio)

**Fuente primaria:** INEGI, Estadísticas de Defunciones Registradas (EDR / mortalidad general)
Clasificación: CIE-10, causa externa **X60-X84** (lesiones autoinfligidas intencionalmente).

### Opción A (recomendada) — Serie armonizada INSP-UISP
Repositorio: *Defunciones Registradas INEGI, Serie de tiempo de 1990 al 2024*
- URL del catálogo: https://riisp.insp.mx/nada/index.php/catalog/21
- Botón de descarga: "Obtener Microdatos" → https://riisp.insp.mx/nada/index.php/catalog/21/get-microdata
- **Requiere crear una cuenta/registro** en el portal (es un sistema tipo NADA/IHSN). Justificación de uso: "investigación académica / réplica de estudio publicado".
- Ventaja: ya viene estandarizada y homogeneizada entre años (evita el trabajo de armonizar catálogos año a año que cambian en INEGI).
- Descarga el corte 2008-2018 si el sistema lo permite filtrar, o el archivo completo y luego filtramos nosotros.
- Guardar como: `data/raw/inegi_defunciones_1990_2024_insp.csv` (o el formato que entregue: dta/sav/csv)

### Opción B — Directo de INEGI (por año)
Portal de descarga masiva: https://www.inegi.org.mx/programas/edr/
- Ahí eliges cada año (2008 a 2018) → "Microdatos" → csv/dbf.
- Cada archivo es la base nacional completa (todas las causas, todas las entidades); nosotros filtramos después por `ENT_OCURR`/`ENT_REGIS` = Chihuahua (clave 08) y causa CIE-10 en X60-X84.
- Guardar cada archivo como: `data/raw/inegi_defunciones_<AÑO>.csv` (ej. `inegi_defunciones_2008.csv`)

📌 **Variables mínimas que necesitamos conservar** al filtrar (nombres exactos varían por año, los mapearemos en la etapa de estandarización):
- Año y mes de la defunción
- Entidad y municipio de ocurrencia/residencia
- Sexo
- Edad (o grupo de edad)
- Causa de la defunción (código CIE-10)

---

## 2. Denominadores poblacionales (para calcular tasas por 100,000 hab.)

- CONAPO, Proyecciones de la Población de México y de las Entidades Federativas: https://www.gob.mx/conapo
- O INEGI, Censos/Conteos de Población 2010 y 2020 + estimaciones intercensales.
- Necesitamos población de Chihuahua por año (2008-2018), idealmente desagregada por sexo y grupo etario (10-24, 25-34, etc.) para replicar las tasas específicas.
- Guardar como: `data/raw/poblacion_chihuahua_2008_2018.csv`

---

## 3. Temperatura ambiental

**Fuente:** CONAGUA / Servicio Meteorológico Nacional (SMN)
- Portal: https://smn.conagua.gob.mx/es/climatologia/informacion-climatologica/informacion-estadistica-climatologica
- Buscar estación(es) climatológica(s) representativas del estado de Chihuahua (el artículo original no especifica la estación exacta; es una decisión que documentaremos como supuesto).
- Se necesita temperatura **mensual** (o diaria, que luego agregamos a mensual) 2008-2018.
- Guardar como: `data/raw/temperatura_chihuahua_2008_2018.csv`

Alternativa si el portal de CONAGUA es difícil de navegar: NASA POWER (datos climáticos por coordenadas, acceso API abierto) — lo evaluamos si CONAGUA no es viable, documentando el cambio de fuente como una decisión metodológica.

---

## Checklist de archivos esperados en `data/raw/`

- [ ] `inegi_defunciones_*.csv` (uno o varios archivos, según opción A o B)
- [ ] `poblacion_chihuahua_2008_2018.csv`
- [ ] `temperatura_chihuahua_2008_2018.csv`

En cuanto subas el primer archivo, iniciamos el diagnóstico real (perfilado de datos) sobre él.
