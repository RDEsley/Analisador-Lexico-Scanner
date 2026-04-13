@echo off
cd /d "%~dp0"
call "%~dp0scripts\run-tests.bat"
exit /b %ERRORLEVEL%
