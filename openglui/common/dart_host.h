// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#ifndef OPENGLUI_COMMON_DART_HOST_H_
#define OPENGLUI_COMMON_DART_HOST_H_

#include "openglui/common/context.h"
#include "openglui/common/graphics_handler.h"
#include "openglui/common/input_handler.h"
#include "openglui/common/lifecycle_handler.h"
#include "openglui/common/sound_handler.h"
#include "openglui/common/timer.h"
#include "openglui/common/vm_glue.h"
#include "include/dart_api.h"

class DartHost : public LifeCycleHandler {
 public:
  explicit DartHost(Context* context);
  virtual ~DartHost();

  int32_t OnStart();
  void OnSaveState(void** data, size_t* size);
  void OnConfigurationChanged();
  void OnLowMemory();
  int32_t Activate();
  void Deactivate();
  void Pause();
  int32_t Resume();
  void FreeAllResources();
  int32_t OnStep();

 private:
  void Clear();

  GraphicsHandler* graphics_handler_;
  InputHandler* input_handler_;
  SoundHandler* sound_handler_;
  Timer* timer_;
  VMGlue* vm_glue_;
  bool has_context_;
  bool started_;
  bool active_;
};

#endif  // OPENGLUI_COMMON_DART_HOST_H_

