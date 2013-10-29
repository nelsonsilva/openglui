#!/bin/bash

function usage {
  echo "usage: $0 [ --help ] [ --android ] [ --arm | --x86] [ --debug ] [--clean] [<Dart directory>]"
  echo
  echo "Sync up Skia and build"
  echo
  echo " --android: Build for Android"
  echo " --x86 : Build for Intel"
  echo " --arm : Cross-compile for ARM (implies --android)"
  echo " --debug : Build a debug version"
  echo
}

DO_ANDROID=0
TARGET_ARCH=x86
CLEAN=0
BUILD=Release
BASE_DIR=.

while [ ! -z "$1" ] ; do
  case $1 in
    "-h"|"-?"|"-help"|"--help")
      usage
      exit 1
    ;;
    "--android")
      DO_ANDROID=1
    ;;
    "--arm")
      TARGET_ARCH=arm
      DEVICE_ID=arm_v7
      DO_ANDROID=1
    ;;
    "--x86")
      TARGET_ARCH=x86
    ;;
    "--clean")
      CLEAN=1
    ;;
    "--debug")
      BUILD=Debug
    ;;
    "--release")
      BUILD=Release
    ;;
    *)
      if [ ! -d "$1" ]
      then
        echo "Unrecognized argument: $1"
        usage
        exit 1
      fi
      DART_DIR="$1"
    ;;
  esac
  shift
done

export SKIA_OUT="out"

pushd "$BASE_DIR/third_party/skia"

if [ ${DO_ANDROID} != 0 ] ; then
  echo "Building for Android ${TARGET_ARCH}"

  export ANDROID_SDK_ROOT=`readlink -f ../android_tools/sdk`
  export GSUTIL_LOCATION=`readlink -f ../gsutil`

  echo "Using SDK ${ANDROID_SDK_ROOT}"
  if [ ${CLEAN} != 0 ] ; then
    ./platform_tools/android/bin/android_make -d $TARGET_ARCH -j clean
  else
    echo env -i BUILDTYPE=$BUILD ANDROID_SDK_ROOT="${ANDROID_SDK_ROOT}" PATH="${PATH}:${GSUTIL_LOCATION}" DEVICE_ID="${DEVICE_ID}" ../android/bin/android_make BUILDTYPE=$BUILD -d $TARGET_ARCH -j --debug=j
    env -i BUILDTYPE=$BUILD ANDROID_SDK_ROOT="${ANDROID_SDK_ROOT}" PATH="${PATH}:${GSUTIL_LOCATION}" DEVICE_ID="${DEVICE_ID}" ./platform_tools/android/bin/android_make BUILDTYPE=$BUILD -d $TARGET_ARCH -j --debug=j
  fi

else

  echo "Building for desktop in `pwd`"
  # Desktop build. Requires svn client and Python.

  # Note that on Linux these packages should be installed first:
  #
  # libfreetype6
  # libfreetype6-dev
  # libpng12-0, libpng12-dev
  # libglu1-mesa-dev
  # mesa-common-dev
  # freeglut3-dev

  SKIA_INSTALLDIR=`pwd`

  python gyp_skia

  pushd $SKIA_OUT

  if [ ${CLEAN} != 0 ] ; then
    echo 'Cleaning'
    make clean
  else
    # Dart sets BUILDTYPE to DebugX64 which breaks Skia build.
    make BUILDTYPE=$BUILD
  fi
  cd ..

fi

popd
# TODO(gram) We should really propogate the make exit code here.
exit 0


