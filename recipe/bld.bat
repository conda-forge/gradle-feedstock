@echo on

:: delete CI variable for build
set CI=

dir

set GRADLE_ARGS=install -Pgradle_installPath=.\tmp\BUILD_GRADLE -x docs --stacktrace

:: build gradle, retrying a couple times to account for network flake
.\gradlew %GRADLE_ARGS% ^
    || .\gradlew %GRADLE_ARGS% ^
    || .\gradlew %GRADLE_ARGS%

dir .\tmp\BUILD_GRADLE

:: create output folder name
VERSION="%PKG_NAME%-%PKG_VERSION%"
OUT="%PREFIX%\share\%VERSION%"

:: copy the files to /share/%VERSION%
md "%OUT%"
copy .\tmp\BUILD_GRADLE\* "%OUT%\."

:: create wrapper
echo %OUT%\bin\gradle.exe %%* > %LIBRARY_BIN%\gradle.cmd
echo IF %%ERRORLEVEL%% NEQ 0 EXIT /B %%ERRORLEVEL%% >> %LIBRARY_BIN%\gradle.cmd
