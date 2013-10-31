// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/**
 * A sample GL application.
 */
library flashingbox;

import 'dart:html';
import 'dart:web_gl';

RenderingContext gl = null;

num r;
num g;
num b;

log(message) => window.console.log(message);

void main([int w, int h, int f]) {
  if (w == null) w = window.innerWidth;
  if (h == null) h = window.innerHeight;
  var canvas = new CanvasElement(width: w, height: h);
  document.body.nodes.add(canvas);

  gl = canvas.getContext("experimental-webgl");
  r = 0;
  g = 0;
  b = 0;
  resize(w, h);
  window.requestAnimationFrame(update);
  log("Done setup");
}

void resize(int width, int height) {
  gl.viewport(0, 0, width, height);
}

void update(when) {
  gl.clearColor(r, g, b, 1.0);
  gl.clear(RenderingContext.COLOR_BUFFER_BIT | RenderingContext.DEPTH_BUFFER_BIT);
  r = r + 0.1;
  if (r > 1) {
    r = 0;
    g = g + 0.1;
  }
  if (g > 1) {
    g = 0;
    b = b + 0.1;
  }
  if (b > 1) {
    b = 0;
  }
  window.requestAnimationFrame(update);
}

