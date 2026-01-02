#!/bin/bash
set -ev

J2OBJC_VERSION="3.1"
J2OBJC_SOURCE_URL="https://github.com/google/j2objc/archive/refs/tags/${J2OBJC_VERSION}.zip"
J2OBJC_ARCHIVE="j2objc-${J2OBJC_VERSION}.zip"

if [[ -d dist ]]; then
  exit
fi

echo "Fetching J2ObjC v${J2OBJC_VERSION} sources from ${J2OBJC_SOURCE_URL}"
curl -L -o ${J2OBJC_ARCHIVE} ${J2OBJC_SOURCE_URL}
unzip -o -q ${J2OBJC_ARCHIVE}

J2OBJC_PATH=j2objc-${J2OBJC_VERSION}

pushd ${J2OBJC_PATH}
make dist
popd

mkdir dist
mv  $J2OBJC_PATH/dist/* dist
rm -rf ${J2OBJC_PATH} ${J2OBJC_ARCHIVE}

touch dist/VERSION
echo $J2OBJC_VERSION > dist/VERSION
