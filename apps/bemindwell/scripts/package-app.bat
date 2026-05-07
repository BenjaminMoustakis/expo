@echo off
REM BeMindWell App Packaging Script for Windows
REM This script creates a distributable zipfile of the BeMindWell app

setlocal enabledelayedexpansion

echo.
echo ====================================
echo BeMindWell App Packaging Script
echo ====================================
echo.

REM Get the current directory
set "SCRIPT_DIR=%~dp0"
set "APP_DIR=%SCRIPT_DIR%.."
set "OUTPUT_DIR=%APP_DIR%\dist"

REM Create timestamp for the zip file
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c%%a%%b)
for /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b)
set "TIMESTAMP=%mydate%_%mytime%"
set "ZIP_NAME=BeMindWell_v1.0.0_%TIMESTAMP%.zip"

echo Preparing to package BeMindWell...
echo    App directory: %APP_DIR%
echo    Output directory: %OUTPUT_DIR%
echo    Package name: %ZIP_NAME%
echo.

REM Create output directory if it doesn't exist
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

REM Create temporary directory for staging
set "TEMP_DIR=%TEMP%\bemindwell_package_%RANDOM%"
set "STAGE_DIR=%TEMP_DIR%\bemindwell"
mkdir "%STAGE_DIR%"

echo Copying application files...

REM Copy directories
xcopy /E /I /Q "%APP_DIR%\app" "%STAGE_DIR%\app" 2>nul
xcopy /E /I /Q "%APP_DIR%\assets" "%STAGE_DIR%\assets" 2>nul
xcopy /E /I /Q "%APP_DIR%\components" "%STAGE_DIR%\components" 2>nul
xcopy /E /I /Q "%APP_DIR%\constants" "%STAGE_DIR%\constants" 2>nul
xcopy /E /I /Q "%APP_DIR%\credentials" "%STAGE_DIR%\credentials" 2>nul
xcopy /E /I /Q "%APP_DIR%\hooks" "%STAGE_DIR%\hooks" 2>nul
xcopy /E /I /Q "%APP_DIR%\scripts" "%STAGE_DIR%\scripts" 2>nul
xcopy /E /I /Q "%APP_DIR%\.vscode" "%STAGE_DIR%\.vscode" 2>nul

REM Copy configuration files
copy "%APP_DIR%\app.json" "%STAGE_DIR%\" 2>nul
copy "%APP_DIR%\eas.json" "%STAGE_DIR%\" 2>nul
copy "%APP_DIR%\package.json" "%STAGE_DIR%\" 2>nul
copy "%APP_DIR%\tsconfig.json" "%STAGE_DIR%\" 2>nul
copy "%APP_DIR%\eslint.config.js" "%STAGE_DIR%\" 2>nul
copy "%APP_DIR%\.gitignore" "%STAGE_DIR%\" 2>nul
copy "%APP_DIR%\.npmignore" "%STAGE_DIR%\" 2>nul
copy "%APP_DIR%\README.md" "%STAGE_DIR%\" 2>nul

echo Files copied successfully
echo.

REM Create SETUP.md
echo Creating SETUP.md...
(
echo # BeMindWell - Quick Setup Guide
echo.
echo ## Quick Start
echo.
echo 1. Extract the archive
echo 2. Run: npm install
echo 3. Run: npm start
echo.
echo See README.md for full documentation.
) > "%STAGE_DIR%\SETUP.md"

echo.
echo Creating zip archive...

REM Check if PowerShell is available for creating zip
where powershell >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    powershell -Command "Compress-Archive -Path '%STAGE_DIR%' -DestinationPath '%OUTPUT_DIR%\%ZIP_NAME%' -Force"
) else (
    echo ERROR: PowerShell is required to create the zip file.
    echo Please install PowerShell or use a third-party zip tool.
    pause
    exit /b 1
)

REM Clean up temporary directory
rmdir /S /Q "%TEMP_DIR%"

echo.
echo ============================================
echo Package created successfully!
echo.
echo Location: %OUTPUT_DIR%\%ZIP_NAME%
echo ============================================
echo.
echo The BeMindWell app is ready for distribution!
echo.
echo Next steps:
echo 1. Share the zip file with your team
echo 2. Extract and run 'npm install'
echo 3. Configure credentials for App Store and Google Play
echo 4. Build and publish your app!
echo.

pause
