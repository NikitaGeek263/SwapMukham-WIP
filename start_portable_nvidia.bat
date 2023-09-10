@echo off
set pypath=home = %~dp0python
set venvpath=_ENV=%~dp0venv
if exist venv (powershell -command "$text = (gc venv\pyvenv.cfg) -replace 'home = .*', $env:pypath; $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($False);[System.IO.File]::WriteAllLines('venv\pyvenv.cfg', $text, $Utf8NoBomEncoding);$text = (gc venv\scripts\activate.bat) -replace '_ENV=.*', $env:venvpath; $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($False);[System.IO.File]::WriteAllLines('venv\scripts\activate.bat', $text, $Utf8NoBomEncoding);")

for /d %%i in (tmp\tmp*,tmp\pip*) do rd /s /q "%%i" 2>nul || ("%%i" && exit /b 1) & del /q tmp\tmp* > nul 2>&1 & rd /s /q pip\cache 2>nul

set appdata=tmp
set userprofile=tmp
set temp=tmp
set PATH=git\cmd;python;venv\scripts;ffmpeg;tensorrt;tensorrt\lib;tensorrt\bin;cuda;cuda\lib;cuda\bin

set CUDA_MODULE_LOADING=LAZY
set CUDA_PATH=cuda

call venv\Scripts\activate.bat
python -m pip uninstall onnxruntime-directml -y
python -m pip install onnxruntime-gpu
python app.py --max_threads 8 --autolaunch
pause

REM Сборка от Neurogen https://t.me/neurogen_news

REM --max_threads 8 - количество потоков видеокарты. Для слабых карт рекомендую начинать от 2 потоков
REM --autolaunch - Автозапуск в браузере
REM --prefer_text_widget - Использовать путь к видео, а не форму загрузки. Обходит ограничение в 300 мегабайт.
REM  --cpu - Работать только на cpu
REM 

