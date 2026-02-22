@echo off
setlocal

REM --- Adjust paths as needed ---
set PYTHON_EXE=python
set VENV_DIR=.venv
set APP_DIR=%~dp0

cd /d "%APP_DIR%"

if not exist "%VENV_DIR%\Scripts\python.exe" (
    echo Creating virtual environment...
    %PYTHON_EXE% -m venv "%VENV_DIR%"
)

echo Activating venv...
call "%VENV_DIR%\Scripts\activate.bat"

echo Installing requirements...
pip install --upgrade pip
pip install flask

REM --- Set desired host/port ---
set HOST=127.0.0.1
set PORT=5173

echo Starting app on %HOST%:%PORT% ...
set FLASK_DEBUG=1
"%VENV_DIR%\Scripts\python.exe" app.py

endlocal

pause