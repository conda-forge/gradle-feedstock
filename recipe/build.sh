#!/bin/bash
# stop on error
set -eu -o pipefail

# delete CI variable for build
CI_BAK=${CI}
unset CI

# build gradle
./gradlew installAll -Pgradle_installPath=/tmp/BUILD_GRADLE \
    || ./gradlew installAll -Pgradle_installPath=/tmp/BUILD_GRADLE \
    || ./gradlew installAll -Pgradle_installPath=/tmp/BUILD_GRADLE

# restore variable
CI=${CI_BAK}

# create output folder name
VERSION="${PKG_NAME}-${PKG_VERSION%\.*}"
OUT="${PREFIX}/share/${VERSION}"

# copy the files to /share/${VERSION}
mkdir -p "${OUT}"
cp -R /tmp/BUILD_GRADLE/* "${OUT}/."

# create symlink
ln -s "${OUT}/bin/gradle" "${PREFIX}/bin/gradle"
chmod 755 "${PREFIX}/bin/gradle"
