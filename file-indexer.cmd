@echo off

rem # Run file indexer (dark theme)
cd dark
call index-dark.cmd

rem # Run file indexer (light theme)
cd ../light
call index-light.cmd
echo.
pause
