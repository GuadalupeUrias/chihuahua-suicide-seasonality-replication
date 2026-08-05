📋 REPORTE — Diagnóstico inicial (parte 7: URLs confirmadas, .gitignore de datos crudos, git en archivo dedicado)

✅ Trabajo realizado:
- Se incorporaron al notebook (notebooks/01_download_extract_mortalidad.ipynb) las 8 URLs reales de descarga proporcionadas por el usuario, confirmando que los archivos son .dbf comprimidos en .zip (el notebook ya soportaba ese formato).
- Se activó .gitignore para que data/raw/ y data/interim/ NO se suban al repositorio (antes estaba comentado/opcional); se conserva únicamente el .gitkeep de cada carpeta.
- Se creó GIT_INSTRUCTIONS.md como archivo dedicado en la raíz del repo, incluyendo configuración de usuario (user.name/user.email) y opciones de autenticación (token HTTPS vs. SSH) para el push, además de las instrucciones ya existentes.
- Se actualizó README.md para apuntar a GIT_INSTRUCTIONS.md en vez de repetir las instrucciones ahí.

🔍 Hallazgos importantes:
- Las URLs de 2022, 2023 y 2024 apuntan a una carpeta "/2021/" en el sitio de INEGI; se dejó anotado en el notebook como posible particularidad del sitio (reutilización de carpeta), no como error del usuario, con indicación de verificar si el archivo descargado no corresponde al año esperado.
- Con .gitignore activo, cualquier archivo ya agregado a git antes de esta configuración seguiría rastreado; se documentó en GIT_INSTRUCTIONS.md qué hacer en ese caso.

📊 Métricas:
- 8/8 URLs de datos incorporadas al notebook.
- 0 archivos de datos crudos destinados a versionarse en git (por diseño).

➡️ Próximos pasos:
1. Correr el notebook con las URLs ya cargadas hasta la sección 4 (columnas) y compartir la salida.
2. Hacer el primer commit siguiendo GIT_INSTRUCTIONS.md, incluyendo la configuración de usuario si aún no la tienes en esta máquina.
