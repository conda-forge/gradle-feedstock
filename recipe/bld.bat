@echo on

:: delete CI variable for build
set CI=

:: create output folder
set VERSION=%PKG_NAME%-%PKG_VERSION%
set OUT=%PREFIX%\share\%VERSION%

:: build gradle
call .\gradlew install -Pgradle_installPath=%OUT% -x docs --stacktrace

dir %OUT%
dir %OUT%\bin
dir %OUT%\lib

:: create wrapper
echo %OUT%\bin\gradle.exe %%* > %LIBRARY_BIN%\gradle.cmd
echo IF %%ERRORLEVEL%% NEQ 0 EXIT /B %%ERRORLEVEL%% >> %LIBRARY_BIN%\gradle.cmd
