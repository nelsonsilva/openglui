#!/bin/bash

mkdir -p "dart"
pushd "dart"

gclient config https://dart.googlecode.com/svn/branches/bleeding_edge/deps/standalone.deps
gclient sync

popd

exit 0


