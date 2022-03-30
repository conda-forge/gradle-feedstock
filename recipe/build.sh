#!/bin/bash
# stop on error
set -eux -o pipefail

# delete CI variable for build
unset CI

GRADLE_ARGS="install -Pgradle_installPath=./tmp/BUILD_GRADLE -x docs --stacktrace"

# build gradle, retrying a couple times to account for network flake
./gradlew $GRADLE_ARGS \
    || ./gradlew $GRADLE_ARGS \
    || ./gradlew $GRADLE_ARGS

# create output folder name
VERSION="${PKG_NAME}-${PKG_VERSION}"
OUT="${PREFIX}/share/${VERSION}"

# copy the files to /share/${VERSION}
mkdir -p "${OUT}"
cp -R ./tmp/BUILD_GRADLE/* "${OUT}/."

# create symlink
ln -s "${OUT}/bin/gradle" "${PREFIX}/bin/gradle"
chmod 755 "${PREFIX}/bin/gradle"
