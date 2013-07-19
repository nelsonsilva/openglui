#!/usr/bin/env python
#
# Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

import os
import sys
import platform

def NormJoin(path1, path2):
  return os.path.normpath(os.path.join(path1, path2))

src = NormJoin(os.path.dirname(sys.argv[0]), os.pardir)
dart_src = os.path.join(src, 'third_party', 'dart')
project_src = '.'
gyp_pylib = os.path.join(dart_src, 'third_party', 'gyp', 'pylib')


# Add gyp to the imports and if needed get it from the third_party location
# inside the standalone dart gclient checkout.
try:
  import gyp
except ImportError, e:
  sys.path.append(os.path.abspath(gyp_pylib))
  import gyp


if __name__ == '__main__':
  # Make our own location absolute as it is stored in Makefiles.
  sys.argv[0] = os.path.abspath(sys.argv[0])

  args = [
    '--depth', project_src,
    '-I', 'third_party/dart/tools/gyp/common.gypi']

  if platform.system() == 'Linux':

    # We need to fiddle with toplevel-dir to work around a GYP bug
    # that breaks building v8 from compiler/dart.gyp.
    args += ['--toplevel-dir', os.curdir]
    args += ['--generator-output', project_src]
  else:
    # On at least the Mac, the toplevel-dir should be where the
    # sources are. Otherwise, Xcode won't show sources correctly.
    args += ['--toplevel-dir', project_src]

  if sys.platform == 'win32':
    # Generate Visual Studio 2008 compatible files by default.
    if not os.environ.get('GYP_MSVS_VERSION'):
      args.extend(['-G', 'msvs_version=2008'])

  # Change into the dart directory as we want the project to be rooted here.
  # Also, GYP is very sensitive to exacly from where it is being run.
  os.chdir(src)

  args += ['all.gyp']

  # Generate the projects.
  sys.exit(gyp.main(args))
