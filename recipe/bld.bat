@echo on

:: delete CI variable for build
set CI_BAK=%CI%

set CI=

:: build gradle
./gradlew installAll -Pgradle_installPath=./tmp/BUILD_GRADLE ^
    || ./gradlew installAll -Pgradle_installPath=./tmp/BUILD_GRADLE ^
    || ./gradlew installAll -Pgradle_installPath=./tmp/BUILD_GRADLE

:: restore variable
set CI=%CI_BAK%

:: create output folder name
VERSION="%PKG_NAME%-%PKG_VERSION%"
OUT="%PREFIX%\share\%VERSION%"

:: copy the files to /share/%VERSION%
md "%OUT%"
copy .\tmp\BUILD_GRADLE\* "%OUT%\."

:: create wrapper
echo %OUT%\bin\gradle.exe %%* > %LIBRARY_BIN%\gradle.cmd
echo IF %%ERRORLEVEL%% NEQ 0 EXIT /B %%ERRORLEVEL%% >> %LIBRARY_BIN%\gradle.cmd
