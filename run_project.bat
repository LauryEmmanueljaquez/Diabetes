@echo off
echo ==========================================
echo   DIABETES PREDICTION PLATFORM SETUP
echo ==========================================

echo [1/4] Installing Python Backend Dependencies...
cd backend
call pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo.
    echo [WARNING] Error installing Python dependencies. 
    echo Please ensure Python is installed and added to PATH.
    echo.
)
cd ..

echo [2/4] Installing Frontend Dependencies...
cd frontend
if not exist node_modules (
    echo Node modules not found. Installing...
    call npm install
) else (
    echo Node modules found. Skipping install...
)
cd ..

echo [3/4] Starting Services...
echo Starting Backend (Port 8000)...
start "Diabetes API Backend" cmd /k "cd backend && python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000"

echo Starting Frontend (Port 5173)...
cd frontend
start http://localhost:5173
call npm run dev
pause
