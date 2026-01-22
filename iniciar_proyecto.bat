@echo off
setlocal
echo ==================================================
echo   DIABETES AI - AUTO REPARACION Y LANZAMIENTO
echo ==================================================

echo.
echo [1/4] Verificando Python...
:: Intentar usar Python 3.11 especificamente si existe el lanzador 'py'
py -3.11 --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Python 3.11 detectado.
    set PYTHON_CMD=py -3.11
    goto :INSTALL
)

:: Si no, probar python comÃºn
python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Python detectado (version predeterminada).
    set PYTHON_CMD=python
    goto :INSTALL
)

echo [ERROR] No se encontro Python. Se requiere Python instalado.
echo Intentando usar 'py' generico...
set PYTHON_CMD=py

:INSTALL
echo.
echo [2/4] Instalando librerias del Backend...
cd backend
%PYTHON_CMD% -m pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo [ERROR] Hubo un problema instalando las dependencias.
    pause
    exit /b
)
cd ..

echo.
echo [3/4] Verificando Frontend...
cd frontend
if not exist node_modules (
    echo Instalando dependencias de Node.js...
    call npm install
)
cd ..

echo.
echo [4/4] Iniciando Servicios...
echo.
echo [BACKEND] Iniciando API...
start "Diabetes API Backend" cmd /k "cd backend && %PYTHON_CMD% -m uvicorn main:app --reload --host 0.0.0.0 --port 8000"

echo [FRONTEND] Iniciando App Web...
cd frontend
start http://localhost:5173
call npm run dev
pause
