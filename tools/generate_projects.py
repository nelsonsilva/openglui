#!/usr/bin/env python
#
# Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

import os
import subprocess
import sys

def execute(args):
  process = subprocess.Popen(args)
  process.wait()
  return process.returncode

def main():

  args = ['python', 'openglui/third_party/dart/third_party/gyp/gyp_main.py',
  '--depth=openglui', '-Iopenglui/tools/gyp/all.gypi']

  if sys.platform == 'win32':
    # Generate Visual Studio 2008 compatible files by default.
    if not os.environ.get('GYP_MSVS_VERSION'):
      args.extend(['-G', 'msvs_version=2008'])

  args += ['openglui/openglui.gyp']

  # Generate the projects.
  sys.exit(execute(args))

if __name__ == '__main__':
  main()