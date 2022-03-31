#!/bin/bash
# stop on error
set -eux -o pipefail

# delete CI variable for build
unset CI

# create output folder
VERSION="${PKG_NAME}-${PKG_VERSION}"
OUT="${PREFIX}/share/${VERSION}"

# build gradle, retrying a couple times to account for network flake
GRADLE_ARGS="install -Pgradle_installPath=${OUT} -x docs --stacktrace"
./gradlew $GRADLE_ARGS \
    || ./gradlew $GRADLE_ARGS \
    || ./gradlew $GRADLE_ARGS

# create symlink
ln -s "${OUT}/bin/gradle" "${PREFIX}/bin/gradle"
chmod 755 "${PREFIX}/bin/gradle"
