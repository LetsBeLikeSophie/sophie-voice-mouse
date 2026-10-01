@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Sophie Voice Mouse

python --version >nul 2>nul
if errorlevel 1 (
  echo.
  echo  Python is not installed. / Python이 설치되어 있지 않아요.
  echo  Install it from the page that opens, and tick "Add python.exe to PATH".
  echo  설치 첫 화면에서 "Add python.exe to PATH" 를 꼭 체크하세요.
  echo  Then double-click this file again. / 설치 후 이 파일을 다시 더블클릭하세요.
  echo.
  start https://www.python.org/downloads/
  pause
  exit /b
)

if not exist ".installed" (
  echo.
  echo  First run: installing dependencies, this takes a few minutes...
  echo  처음 실행이라 필요한 프로그램을 설치하는 중이에요. 몇 분 걸려요...
  echo.
  python -m pip install -r requirements.txt
  if errorlevel 1 (
    echo.
    echo  Installation failed. See the messages above. / 설치 중 문제가 생겼어요.
    pause
    exit /b
  )
  echo ok> .installed
)

python sophie_voice_mouse.py %*
pause
