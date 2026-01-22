@echo off
setlocal
echo ==================================================
echo   DIABETES AI - AUTO REPAIR AND LAUNCH
echo ==================================================

echo.
echo [1/4] Checking Python Installation...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python no encontrado en el sistema.
    echo Intentando detectar si fue instalado recientemente...
    :: Refresh env vars trick for current session is hard in batch without tools.
    echo.
    echo POR FAVOR:
    echo 1. Si ya instalaste Python, reinicia tu computadora o cierra y abre este script.
    echo 2. Si no, descargalo de python.org o Microsoft Store.
    echo.
    echo Intentaremos usar 'py' launcher por si acaso...
    py --version >nul 2>&1
    if %errorlevel% neq 0 (
        echo [CRITICAL] No se pudo encontrar Python. El backend no puede iniciar.
        pause
        exit /b
    ) else (
        echo [OK] Usando 'py' launcher.
        set PYTHON_CMD=py
    )
) else (
    echo [OK] Python detectado.
    set PYTHON_CMD=python
)

echo.
echo [2/4] Installing Libraries (Backend)...
cd backend
%PYTHON_CMD% -m pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo [WARNING] Fallo la instalacion de pip. Intentando instalar pip...
    %PYTHON_CMD% -m ensurepip
    %PYTHON_CMD% -m pip install -r requirements.txt
)
cd ..

echo.
echo [3/4] Checking Frontend...
cd frontend
if not exist node_modules (
    echo Installing node modules...
    call npm install
)
cd ..

echo.
echo [4/4] Starting Services...
echo.
echo [BACKEND] Iniciando API en puerto 8000...
start "Diabetes API Backend" cmd /k "cd backend && %PYTHON_CMD% -m uvicorn main:app --reload --host 0.0.0.0 --port 8000"

echo [FRONTEND] Iniciando App React...
cd frontend
start http://localhost:5173
call npm run dev
pause
