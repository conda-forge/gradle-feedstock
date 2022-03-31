@echo on

:: delete CI variable for build
set CI=

:: create output folder
set VERSION=%PKG_NAME%-%PKG_VERSION%
set OUT=%PREFIX%\share\%VERSION%

:: build gradle, retrying a couple times to account for network flake
.\gradlew install -Pgradle_installPath=%VERSION% -x docs --stacktrace
:: .\gradlew install -Pgradle_installPath=%VERSION% -x docs --stacktrace
:: .\gradlew install -Pgradle_installPath=%VERSION% -x docs --stacktrace

dir %VERSION%

md %PREFIX%\share

copy %VERSION% %OUT%

dir %OUT%

:: create wrapper
echo %OUT%\bin\gradle.exe %%* > %LIBRARY_BIN%\gradle.cmd
echo IF %%ERRORLEVEL%% NEQ 0 EXIT /B %%ERRORLEVEL%% >> %LIBRARY_BIN%\gradle.cmd
