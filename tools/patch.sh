#!/bin/sh
# Fix Makefile
sed -i 's/^srcdir := /srcdir := ./g' Makefile
# Disable -Werror
sed -i '/-Werror/d' third_party/dart/tools/gyp/configurations_make.gypi
