#!/bin/bash
# stop on error
set -eux -o pipefail

# delete CI variable for build
unset CI

# create output folder
VERSION="${PKG_NAME}-${PKG_VERSION}"
OUT="${PREFIX}/share/${VERSION}"

# build gradle
./gradlew install --project-prop gradle_installPath=${OUT} --project-prop finalRelease=true -x docs --stacktrace

# create symlink
ln -s "${OUT}/bin/gradle" "${PREFIX}/bin/gradle"
chmod 755 "${PREFIX}/bin/gradle"
