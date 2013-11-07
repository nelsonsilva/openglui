// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include "openglui/common/image_cache.h"

#include <ctype.h>
#include <string.h>
#include "core/SkStream.h"
#include "openglui/common/canvas_context.h"
#include "openglui/common/resource.h"

ImageCache* ImageCache::instance_ = NULL;

extern CanvasContext* Context2D(int handle);

ImageCache::ImageCache(const char* resource_path)
    : images(), resource_path_(resource_path) {
}

const SkBitmap* ImageCache::GetImage_(const char* src_url) {
  if (strncmp(src_url, "context2d://", 12) == 0) {
    int handle = atoi(src_url + 12);
    CanvasContext* otherContext = Context2D(handle);
    return otherContext->GetBitmap();
  } else if (images.find(src_url) == images.end()) {
    SkBitmap* bm = Load(src_url);
    if (bm != NULL) {
      images[src_url] = bm;
    }
    return bm;
  } else {
    return images[src_url];
  }
}

int ImageCache::GetWidth_(const char* src_url) {
  const SkBitmap* image = GetImage(src_url);
  if (image == NULL) return 0;
  return image->width();
}

int ImageCache::GetHeight_(const char* src_url) {
  const SkBitmap* image = GetImage(src_url);
  if (image == NULL) return 0;
  return image->height();
}

SkBitmap* ImageCache::Load(const char* src_url) {
  SkBitmap *bm = NULL;
  Resource* resource = MakePlatformResource(src_url);
  if (resource->Open() != 0) {
    LOGE("Image not found at: %s\n", src_url);
    return NULL;
  }
  size_t length;
  char* buffer = new char[length = resource->length()];
  resource->Read(buffer, length);
  resource->Close();

  SkMemoryStream stream(buffer, length, false);
  // We could use DecodeFile and pass the path, but by creating the
  // SkStream here we can produce better error log messages.
  bm = new SkBitmap();
  if (!SkImageDecoder::DecodeStream(&stream, bm)) {
    LOGE("Image decode of %s failed", src_url);
    return NULL;
  } else {
    LOGI("Decode image %s: width=%d,height=%d",
        src_url, bm->width(), bm->height());
  }

  delete[] buffer;
  return bm;
}

