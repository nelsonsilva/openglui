// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#ifndef OPENGLUI_ANDROID_ANDROID_GRAPHICS_HANDLER_H_
#define OPENGLUI_ANDROID_ANDROID_GRAPHICS_HANDLER_H_

#include <android_native_app_glue.h>
#include "openglui/common/graphics_handler.h"

class AndroidGraphicsHandler : public GraphicsHandler {
  public:
    AndroidGraphicsHandler(android_app* application,
                           const char* resource_path);

    int32_t Start();
    void Stop();

  private:
    android_app* application_;
    EGLDisplay display_;
    EGLSurface surface_;
    EGLContext context_;
};

#endif  // OPENGLUI_ANDROID_ANDROID_GRAPHICS_HANDLER_H_

