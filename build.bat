@echo off
REM Atalho na raiz -> scripts\build.bat
cd /d "%~dp0"
call "%~dp0scripts\build.bat"
exit /b %ERRORLEVEL%
