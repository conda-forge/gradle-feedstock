@echo on

:: delete CI variable for build
set CI=

:: create output folder name
VERSION="%PKG_NAME%-%PKG_VERSION%"
OUT="%PREFIX%\share\%VERSION%"
md "%OUT%"

:: build gradle, retrying a couple times to account for network flake
.\gradlew install -Pgradle_installPath="%OUT%" -x docs --stacktrace
.\gradlew install -Pgradle_installPath="%OUT%" -x docs --stacktrace
.\gradlew install -Pgradle_installPath="%OUT%" -x docs --stacktrace
IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%

dir %OUT% || exit 1

:: create wrapper
echo %OUT%\bin\gradle.exe %%* > %LIBRARY_BIN%\gradle.cmd
echo IF %%ERRORLEVEL%% NEQ 0 EXIT /B %%ERRORLEVEL%% >> %LIBRARY_BIN%\gradle.cmd
