@echo off
setlocal enabledelayedexpansion

REM ============================================================
REM Reset del entorno del proyecto (Windows)
REM Borra el venv local y desregistra el kernel de Jupyter mal
REM nombrado, para poder correr setup.bat limpio despues.
REM ============================================================

echo ==^> Desregistrando kernels de Jupyter relacionados con este proyecto...

REM Intenta borrar AMBOS nombres posibles: el correcto y el heredado por error
call venv\Scripts\activate.bat 2>nul
python -m jupyter kernelspec uninstall chihuahua-suicide-seasonality-replication -y 2>nul
call venv\Scripts\deactivate.bat 2>nul

echo ==^> Borrando entorno virtual local (venv)...
if exist venv (
    rmdir /s /q venv
    echo Entorno virtual borrado.
) else (
    echo No se encontro carpeta venv, nada que borrar.
)

echo.
echo ============================================================
echo Limpieza completa. Ahora corre: setup.bat
echo Esto creara el venv y registrara el kernel con el nombre
echo correcto: chihuahua-suicide-seasonality-replication
echo ============================================================
pause
