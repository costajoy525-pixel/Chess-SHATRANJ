@echo off
setlocal
cd /d "%~dp0"
echo ============================================================================
echo   Shatranj Chess - Universal Windows Fat-JAR ^& Native EXE Builder
echo ============================================================================
echo.
echo Note: Shatranj.exe and Shatranj_Setup.exe in this folder are ALREADY built
echo and ready to run on any Windows PC! Use this script only if you edit the
echo Java source files in chess\src\main\java and want to recompile from source.
echo.

cd /d "%~dp0chess"

set "MVN_CMD="
where mvn >nul 2>&1 && set "MVN_CMD=mvn"

if "%MVN_CMD%"=="" (
    for /d %%D in ("C:\Program Files\JetBrains\IntelliJ*") do (
        if exist "%%D\plugins\maven\lib\maven3\bin\mvn.cmd" (
            set "MVN_CMD=%%D\plugins\maven\lib\maven3\bin\mvn.cmd"
        )
    )
)

if not "%MVN_CMD%"=="" (
    echo [1/2] Building Universal Fat JAR and Windows EXE with Maven...
    call "%MVN_CMD%" clean package -DskipTests
    if exist "target\Shatranj-Chess.jar" (
        copy /Y "target\Shatranj-Chess.jar" "..\Shatranj-Chess.jar" >nul
        echo Updated ..\Shatranj-Chess.jar with bundled Windows JavaFX libraries.
    )
    if exist "target\Shatranj.exe" (
        copy /Y "target\Shatranj.exe" "..\Shatranj.exe" >nul
        echo Updated ..\Shatranj.exe via Launch4j.
    )
) else (
    echo Maven was not found on PATH. Using javac/jar from JDK if available...
    where javac >nul 2>&1
    if %ERRORLEVEL% EQU 0 (
        javac -d target\classes src\main\java\org\example\UniversalSwingChess.java src\main\java\org\example\Launcher.java
        jar cfm target\Shatranj-Chess.jar src\main\resources\META-INF\MANIFEST.MF -C target\classes org
        copy /Y "target\Shatranj-Chess.jar" "..\Shatranj-Chess.jar" >nul
        echo Rebuilt Shatranj-Chess.jar.
    )
)

:: Optional jpackage self-contained Windows bundle if JDK 17+ jpackage is available
where jpackage >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [2/2] Running jpackage to create self-contained Windows app-image...
    if exist "..\dist\Shatranj" rmdir /S /Q "..\dist\Shatranj"
    jpackage --type app-image --name "Shatranj" --input target --main-jar Shatranj-Chess.jar --main-class org.example.Launcher --icon "..\app\Shatranj.ico" --dest "..\dist"
)

echo.
echo Build complete! You can run Shatranj.exe or Shatranj_Setup.exe on any Windows PC.
pause
