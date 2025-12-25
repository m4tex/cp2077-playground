@echo off

:: Check if running as admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo You must run the script with admin privileges, exiting...
    pause
    exit /b 1
)

:: leave cmds/
cd /d "%~dp0\.."

:: If an argument is given, skip to symlinking using the given path
if not "%~1"=="" if not "%~2"=="" (
    set cpPath="%~1"
    set "pluginPath=%~1\red4ext\plugins\%~2"
    goto Symlink
)

:: Auto setup of project files and dependencies, note: Currently you need to install required game mods yourself

echo Continue only if you have installed RED4ext for Cyberpunk 2077
pause

set /p projectName="Enter project name (playground): "

if "%projectName%"=="" (
    set projectName=playground
)

set /p cpPath="Insert full path to the Cyberpunk 2077 game folder: "

if "%cpPath%"=="" (
    echo No path specified, exiting...
    exit /b 1
)

:: Replace backslashes with forward slashes
set "cpPathFS=%cpPath:\=/%"
set "pluginPath=%cpPath%\red4ext\plugins\%projectName%"

echo Cloning submodules...
git submodule update --init --recursive

:: echo Bootstrapping vcpkg...
:: call .\vcpkg\bootstrap-vcpkg.bat >nul

:: echo Installing vcpkg packages...
:: .\vcpkg\vcpkg.exe install >nul

echo Setting up redscript logging...

if not exist "%pluginPath%\.." (
    echo Couldn't find RED4ext, aborting
    exit /b 1
)

if not exist "%cpPath%/r6/scripts" (
    mkdir "%cpPath%/r6/scripts"
)

"C:\Windows\System32\xcopy.exe" "%~dp0\Logs.reds" "%cpPath%/r6/scripts" /Y /Q >nul

:Symlink
echo Symlinking all resources

if not exist "%pluginPath%" (
    mkdir "%pluginPath%"
)

:: Symlink all res files/directories
for %%f in (res\*) do (
    if exist "%pluginPath%\%%~nxf" del /Q "%pluginPath%\%%~nxf"
    mklink "%pluginPath%\%%~nxf" "%%~ff"
    if errorlevel 1 echo Failed to create file symlink: %%~nxf
)

:: Directories
for /D %%f in (res\*) do (
   if exist "%pluginPath%\%%~nxf" rmdir /S /Q "%pluginPath%\%%~nxf"
   mklink /D "%pluginPath%\%%~nxf" "%%~ff"
   if errorlevel 1 echo Failed to create directory symlink: %%~nxf
)

if not exist cmake mkdir cmake

if exist cmake if not exist cmake/UserConfig.cmake (
    echo Setting up CMake variables
    echo set(PLUGINS_DIR "%cpPathFS%/red4ext/plugins" CACHE PATH "Path to RED4Ext plugins folder") > .\cmake\UserConfig.cmake
    echo set(CFG_PROJECT_NAME "%projectName%" CACHE PATH "Path to RED4Ext plugins folder") >> .\cmake\UserConfig.cmake
)

echo Creating symlink.bat
echo "%%~dp0setup.bat" "%cpPath%" "%projectName%" > .\cmds\symlink.bat

echo DONE! You may close this window.

pause
