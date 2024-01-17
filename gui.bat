@echo off

:: Deactivate the virtual environment
call .\venv\Scripts\deactivate.bat

:: Calling external python program to check for local modules
:: python .\setup\check_local_modules.py --no_question

:: Activate the virtual environment
call .\venv\Scripts\activate.bat
set PATH=%PATH%;%~dp0venv\Lib\site-packages\torch\lib

:: Upgrade if needed
python.exe -m pip install --upgrade pip
pip install -U -r requirements-windows.txt

:: If the exit code is 0, run the kohya_gui.py script with the command-line arguments
if %errorlevel% equ 0 (
    REM Check if the batch was started via double-click
    IF /i "%comspec% /c %~0 " equ "%cmdcmdline:"=%" (
        REM echo This script was started by double clicking.
        cmd /k python gradio_demo/app.py %*
    ) ELSE (
        REM echo This script was started from a command prompt.
        python gradio_demo/app.py %*
    )
)