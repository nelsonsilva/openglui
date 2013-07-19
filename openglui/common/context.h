// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#ifndef OPENGLUI_COMMON_CONTEXT_H_
#define OPENGLUI_COMMON_CONTEXT_H_

#include "openglui/common/graphics_handler.h"
#include "openglui/common/input_handler.h"
#include "openglui/common/sound_handler.h"
#include "openglui/common/timer.h"
#include "openglui/common/vm_glue.h"

struct Context {
  GraphicsHandler* graphics_handler;
  InputHandler* input_handler;
  SoundHandler* sound_handler;
  Timer* timer;
  VMGlue* vm_glue;
};

#endif  // OPENGLUI_COMMON_CONTEXT_H_

