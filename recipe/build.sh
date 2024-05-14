#!/bin/bash
# stop on error
set -eux -o pipefail

# delete CI variable for build
unset CI

# create output folder
VERSION="${PKG_NAME}-${PKG_VERSION}"
OUT="${PREFIX}/share/${VERSION}"

echo $JAVA_HOME
# build gradle
./gradlew install -Pgradle_installPath=${OUT} -x docs --stacktrace --debug

ls $OUT
ls $OUT/bin
ls $OUT/lib

# create symlink
ln -s "${OUT}/bin/gradle" "${PREFIX}/bin/gradle"
chmod 755 "${PREFIX}/bin/gradle"
