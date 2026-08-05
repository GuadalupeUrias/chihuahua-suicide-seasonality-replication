# Instrucciones de git — chihuahua-suicide-seasonality-replication

## 0. Configurar el usuario con el que vas a hacer commits/push

Antes de tu primer commit, git necesita saber con qué nombre y correo firmar tus cambios. Tienes dos formas:

### Opción A — Solo para este repositorio (recomendado si usas distintos usuarios en distintos proyectos)
Ejecuta esto **dentro de la carpeta del repo ya clonado**:
```bash
cd chihuahua-suicide-seasonality-replication
git config user.name "Tu Nombre"
git config user.email "tu_correo@ejemplo.com"
```

### Opción B — Para todos tus repositorios en esta computadora
```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu_correo@ejemplo.com"
```

Usa el mismo correo que tengas registrado en GitHub/GitLab (o el que corresponda), para que los commits queden vinculados a tu cuenta.

Puedes verificar qué quedó configurado con:
```bash
git config user.name
git config user.email
```

### Autenticación al hacer `git push`
Desde 2021, GitHub ya no acepta contraseña normal por HTTPS. Cuando hagas `git push` te va a pedir credenciales; tienes dos caminos:
- **HTTPS + token de acceso personal**: en vez de tu contraseña, usas un *Personal Access Token* que generas en GitHub → Settings → Developer settings → Personal access tokens. Lo pegas cuando te pida contraseña (la primera vez; después puede quedar guardado en el sistema).
- **SSH**: generas una llave SSH (`ssh-keygen`), la agregas a tu cuenta de GitHub, y clonas/usas el repo con la URL `git@github.com:usuario/repo.git` en vez de `https://...`. No te vuelve a pedir credenciales.

Si es la primera vez que configuras git en esta máquina, te recomiendo SSH — es configuración de una sola vez y evita estar generando tokens.

---

## 1. Primera vez (repo local aún no existe)
```bash
git clone <URL-de-tu-repo-remoto> chihuahua-suicide-seasonality-replication
cd chihuahua-suicide-seasonality-replication

# configura tu usuario (ver sección 0 si no lo has hecho)
git config user.name "Tu Nombre"
git config user.email "tu_correo@ejemplo.com"

# Descomprime el .zip que te compartí y copia TODO su contenido aquí (sobrescribiendo si aplica)
git add .
git commit -m "Etapa 1: estructura del proyecto, fuentes de datos y notebook de descarga"
git push origin main   # usa 'master' si tu rama por defecto se llama así
```

## 2. Avances siguientes (ya tienes el repo local)
```bash
cd chihuahua-suicide-seasonality-replication
# Descomprime el nuevo .zip y copia/sobrescribe los archivos actualizados
git status                 # revisa qué cambió antes de subir
git add .
git commit -m "Descripción breve del avance (ej. Etapa 2: limpieza de microdatos)"
git push origin main
```

## 3. Sobre los datos crudos (`data/raw/`)
`.gitignore` ya está configurado para **no subir nada** de `data/raw/` ni `data/interim/` al repositorio (solo se conserva el archivo `.gitkeep` que mantiene la carpeta en el repo, vacía). Esto es intencional:
- Los archivos de INEGI son pesados (bases nacionales completas).
- Son de acceso público y fácilmente re-descargables — cualquiera puede reproducirlos siguiendo `docs/DATA_SOURCES.md` y corriendo `notebooks/01_download_extract_mortalidad.ipynb`.
- Si algún día decides sí versionarlos (por ejemplo con Git LFS, para archivos grandes), coméntame y ajustamos el `.gitignore`.

Si `git status` te muestra archivos dentro de `data/raw/` como "untracked" a pesar de esto, revisa que el `.gitignore` esté en la raíz del repo (no dentro de otra carpeta) y que no los hayas agregado ya con `git add` antes de que existiera el `.gitignore`.

## 4. Recomendaciones generales
- Un commit por cada entrega/reporte (coincide con los archivos en `reports/`) — así el historial documenta el proceso, que es justo el punto de un ejercicio de reproducibilidad.
- Revisa `git log --oneline` de vez en cuando para verificar que el historial cuente la historia del proyecto tal como fue avanzando.
- Si GitHub llega a bloquear un push por un archivo grande que se coló antes de tener el `.gitignore` bien configurado, dímelo — hay que sacarlo del historial con `git filter-repo` o similar, no basta con borrarlo y hacer un commit nuevo.
