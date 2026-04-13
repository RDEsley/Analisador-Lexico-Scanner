@echo off
REM Atalho na raiz: contorna ExecutionPolicy do PowerShell (nao use .\scripts\build.ps1 direto se scripts estiverem bloqueados).
cd /d "%~dp0"
call "%~dp0scripts\build.bat"
exit /b %ERRORLEVEL%
