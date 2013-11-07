// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library web_gl;

import 'dart:html';

/*
const int ACTIVE_ATTRIBUTES = RenderingContext.ACTIVE_ATTRIBUTES;
const int ACTIVE_TEXTURE = RenderingContext.ACTIVE_TEXTURE;
const int ACTIVE_UNIFORMS = RenderingContext.ACTIVE_UNIFORMS;
const int ALIASED_LINE_WIDTH_RANGE = RenderingContext.ALIASED_LINE_WIDTH_RANGE;
const int ALIASED_POINT_SIZE_RANGE = RenderingContext.ALIASED_POINT_SIZE_RANGE;
const int ALPHA = RenderingContext.ALPHA;
const int ALPHA_BITS = RenderingContext.ALPHA_BITS;
const int ALWAYS = RenderingContext.ALWAYS;*/
const int ARRAY_BUFFER = RenderingContext.ARRAY_BUFFER;/*
const int ARRAY_BUFFER_BINDING = RenderingContext.ARRAY_BUFFER_BINDING;
const int ATTACHED_SHADERS = RenderingContext.ATTACHED_SHADERS;*/
const int BACK = RenderingContext.BACK;
const int BLEND = RenderingContext.BLEND;/*
const int BLEND_COLOR = RenderingContext.BLEND_COLOR;
const int BLEND_DST_ALPHA = RenderingContext.BLEND_DST_ALPHA;
const int BLEND_DST_RGB = RenderingContext.BLEND_DST_RGB;
const int BLEND_EQUATION = RenderingContext.BLEND_EQUATION;
const int BLEND_EQUATION_ALPHA = RenderingContext.BLEND_EQUATION_ALPHA;
const int BLEND_EQUATION_RGB = RenderingContext.BLEND_EQUATION_RGB;
const int BLEND_SRC_ALPHA = RenderingContext.BLEND_SRC_ALPHA;
const int BLEND_SRC_RGB = RenderingContext.BLEND_SRC_RGB;
const int BLUE_BITS = RenderingContext.BLUE_BITS;
const int BOOL = RenderingContext.BOOL;
const int BOOL_VEC2 = RenderingContext.BOOL_VEC2;
const int BOOL_VEC3 = RenderingContext.BOOL_VEC3;
const int BOOL_VEC4 = RenderingContext.BOOL_VEC4;
const int BROWSER_DEFAULT_WEBGL = RenderingContext.BROWSER_DEFAULT_WEBGL;
const int BUFFER_SIZE = RenderingContext.BUFFER_SIZE;
const int BUFFER_USAGE = RenderingContext.BUFFER_USAGE;
const int BYTE = RenderingContext.BYTE;*/
const int CCW = RenderingContext.CCW;/*
const int CLAMP_TO_EDGE = RenderingContext.CLAMP_TO_EDGE;
const int COLOR_ATTACHMENT0 = RenderingContext.COLOR_ATTACHMENT0;*/
const int COLOR_BUFFER_BIT = RenderingContext.COLOR_BUFFER_BIT;/*
const int COLOR_CLEAR_VALUE = RenderingContext.COLOR_CLEAR_VALUE;
const int COLOR_WRITEMASK = RenderingContext.COLOR_WRITEMASK;*/
const int COMPILE_STATUS = RenderingContext.COMPILE_STATUS;
const int COMPRESSED_TEXTURE_FORMATS = RenderingContext.COMPRESSED_TEXTURE_FORMATS;/*
const int CONSTANT_ALPHA = RenderingContext.CONSTANT_ALPHA;
const int CONSTANT_COLOR = RenderingContext.CONSTANT_COLOR;
const int CONTEXT_LOST_WEBGL = RenderingContext.CONTEXT_LOST_WEBGL;*/
const int CULL_FACE = RenderingContext.CULL_FACE;/*
const int CULL_FACE_MODE = RenderingContext.CULL_FACE_MODE;
const int CURRENT_PROGRAM = RenderingContext.CURRENT_PROGRAM;
const int CURRENT_VERTEX_ATTRIB = RenderingContext.CURRENT_VERTEX_ATTRIB;
const int CW = RenderingContext.CW;
const int DECR = RenderingContext.DECR;
const int DECR_WRAP = RenderingContext.DECR_WRAP;*/
const int DELETE_STATUS = RenderingContext.DELETE_STATUS;/*
const int DEPTH_ATTACHMENT = RenderingContext.DEPTH_ATTACHMENT;
const int DEPTH_BITS = RenderingContext.DEPTH_BITS;*/
const int DEPTH_BUFFER_BIT = RenderingContext.DEPTH_BUFFER_BIT;/*
const int DEPTH_CLEAR_VALUE = RenderingContext.DEPTH_CLEAR_VALUE;
const int DEPTH_COMPONENT = RenderingContext.DEPTH_COMPONENT;
const int DEPTH_COMPONENT16 = RenderingContext.DEPTH_COMPONENT16;
const int DEPTH_FUNC = RenderingContext.DEPTH_FUNC;
const int DEPTH_RANGE = RenderingContext.DEPTH_RANGE;
const int DEPTH_STENCIL = RenderingContext.DEPTH_STENCIL;
const int DEPTH_STENCIL_ATTACHMENT = RenderingContext.DEPTH_STENCIL_ATTACHMENT;*/
const int DEPTH_TEST = RenderingContext.DEPTH_TEST;/*
const int DEPTH_WRITEMASK = RenderingContext.DEPTH_WRITEMASK;
const int DITHER = RenderingContext.DITHER;
const int DONT_CARE = RenderingContext.DONT_CARE;
const int DST_ALPHA = RenderingContext.DST_ALPHA;
const int DST_COLOR = RenderingContext.DST_COLOR;*/
const int DYNAMIC_DRAW = RenderingContext.DYNAMIC_DRAW;
const int ELEMENT_ARRAY_BUFFER = RenderingContext.ELEMENT_ARRAY_BUFFER;/*
const int ELEMENT_ARRAY_BUFFER_BINDING = RenderingContext.ELEMENT_ARRAY_BUFFER_BINDING;
const int EQUAL = RenderingContext.EQUAL;
const int FASTEST = RenderingContext.FASTEST;*/
const int FLOAT = RenderingContext.FLOAT;/*
const int FLOAT_MAT2 = RenderingContext.FLOAT_MAT2;
const int FLOAT_MAT3 = RenderingContext.FLOAT_MAT3;
const int FLOAT_MAT4 = RenderingContext.FLOAT_MAT4;
const int FLOAT_VEC2 = RenderingContext.FLOAT_VEC2;
const int FLOAT_VEC3 = RenderingContext.FLOAT_VEC3;
const int FLOAT_VEC4 = RenderingContext.FLOAT_VEC4;*/
const int FRAGMENT_SHADER = RenderingContext.FRAGMENT_SHADER;/*
const int FRAMEBUFFER = RenderingContext.FRAMEBUFFER;
const int FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = RenderingContext.FRAMEBUFFER_ATTACHMENT_OBJECT_NAME;
const int FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = RenderingContext.FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE;
const int FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = RenderingContext.FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE;
const int FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = RenderingContext.FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL;
const int FRAMEBUFFER_BINDING = RenderingContext.FRAMEBUFFER_BINDING;
const int FRAMEBUFFER_COMPLETE = RenderingContext.FRAMEBUFFER_COMPLETE;
const int FRAMEBUFFER_INCOMPLETE_ATTACHMENT = RenderingContext.FRAMEBUFFER_INCOMPLETE_ATTACHMENT;
const int FRAMEBUFFER_INCOMPLETE_DIMENSIONS = RenderingContext.FRAMEBUFFER_INCOMPLETE_DIMENSIONS;
const int FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = RenderingContext.FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT;
const int FRAMEBUFFER_UNSUPPORTED = RenderingContext.FRAMEBUFFER_UNSUPPORTED;
const int FRONT = RenderingContext.FRONT;
const int FRONT_AND_BACK = RenderingContext.FRONT_AND_BACK;
const int FRONT_FACE = RenderingContext.FRONT_FACE;*/
const int FUNC_ADD = RenderingContext.FUNC_ADD;/*
const int FUNC_REVERSE_SUBTRACT = RenderingContext.FUNC_REVERSE_SUBTRACT;
const int FUNC_SUBTRACT = RenderingContext.FUNC_SUBTRACT;
const int GENERATE_MIPMAP_HINT = RenderingContext.GENERATE_MIPMAP_HINT;
const int GEQUAL = RenderingContext.GEQUAL;
const int GREATER = RenderingContext.GREATER;
const int GREEN_BITS = RenderingContext.GREEN_BITS;
const int HALF_FLOAT_OES = OesTextureHalfFloat.HALF_FLOAT_OES;*/
const int HIGH_FLOAT = RenderingContext.HIGH_FLOAT;
const int HIGH_INT = RenderingContext.HIGH_INT;/*
const int INCR = RenderingContext.INCR;
const int INCR_WRAP = RenderingContext.INCR_WRAP;
const int INT = RenderingContext.INT;
const int INT_VEC2 = RenderingContext.INT_VEC2;
const int INT_VEC3 = RenderingContext.INT_VEC3;
const int INT_VEC4 = RenderingContext.INT_VEC4;
const int INVALID_ENUM = RenderingContext.INVALID_ENUM;
const int INVALID_FRAMEBUFFER_OPERATION = RenderingContext.INVALID_FRAMEBUFFER_OPERATION;
const int INVALID_OPERATION = RenderingContext.INVALID_OPERATION;
const int INVALID_VALUE = RenderingContext.INVALID_VALUE;
const int INVERT = RenderingContext.INVERT;
const int KEEP = RenderingContext.KEEP;*/
const int LEQUAL = RenderingContext.LEQUAL;/*
const int LESS = RenderingContext.LESS;
const int LINEAR = RenderingContext.LINEAR;
const int LINEAR_MIPMAP_LINEAR = RenderingContext.LINEAR_MIPMAP_LINEAR;
const int LINEAR_MIPMAP_NEAREST = RenderingContext.LINEAR_MIPMAP_NEAREST;
const int LINES = RenderingContext.LINES;
const int LINE_LOOP = RenderingContext.LINE_LOOP;
const int LINE_STRIP = RenderingContext.LINE_STRIP;
const int LINE_WIDTH = RenderingContext.LINE_WIDTH;*/
const int LINK_STATUS = RenderingContext.LINK_STATUS;
const int LOW_FLOAT = RenderingContext.LOW_FLOAT;
const int LOW_INT = RenderingContext.LOW_INT;/*
const int LUMINANCE = RenderingContext.LUMINANCE;
const int LUMINANCE_ALPHA = RenderingContext.LUMINANCE_ALPHA;
const int MAX_COMBINED_TEXTURE_IMAGE_UNITS = RenderingContext.MAX_COMBINED_TEXTURE_IMAGE_UNITS;*/
const int MAX_CUBE_MAP_TEXTURE_SIZE = RenderingContext.MAX_CUBE_MAP_TEXTURE_SIZE;/*
const int MAX_FRAGMENT_UNIFORM_VECTORS = RenderingContext.MAX_FRAGMENT_UNIFORM_VECTORS;
const int MAX_RENDERBUFFER_SIZE = RenderingContext.MAX_RENDERBUFFER_SIZE;*/
const int MAX_TEXTURE_IMAGE_UNITS = RenderingContext.MAX_TEXTURE_IMAGE_UNITS;
const int MAX_TEXTURE_SIZE = RenderingContext.MAX_TEXTURE_SIZE;/*
const int MAX_VARYING_VECTORS = RenderingContext.MAX_VARYING_VECTORS;
const int MAX_VERTEX_ATTRIBS = RenderingContext.MAX_VERTEX_ATTRIBS;*/
const int MAX_VERTEX_TEXTURE_IMAGE_UNITS = RenderingContext.MAX_VERTEX_TEXTURE_IMAGE_UNITS;
const int MAX_VERTEX_UNIFORM_VECTORS = RenderingContext.MAX_VERTEX_UNIFORM_VECTORS;/*
const int MAX_VIEWPORT_DIMS = RenderingContext.MAX_VIEWPORT_DIMS;*/
const int MEDIUM_FLOAT = RenderingContext.MEDIUM_FLOAT;
const int MEDIUM_INT = RenderingContext.MEDIUM_INT;/*
const int MIRRORED_REPEAT = RenderingContext.MIRRORED_REPEAT;
const int NEAREST = RenderingContext.NEAREST;
const int NEAREST_MIPMAP_LINEAR = RenderingContext.NEAREST_MIPMAP_LINEAR;
const int NEAREST_MIPMAP_NEAREST = RenderingContext.NEAREST_MIPMAP_NEAREST;
const int NEVER = RenderingContext.NEVER;
const int NICEST = RenderingContext.NICEST;
const int NONE = RenderingContext.NONE;
const int NOTEQUAL = RenderingContext.NOTEQUAL;
const int NO_ERROR = RenderingContext.NO_ERROR;*/
const int ONE = RenderingContext.ONE;/*
const int ONE_MINUS_CONSTANT_ALPHA = RenderingContext.ONE_MINUS_CONSTANT_ALPHA;
const int ONE_MINUS_CONSTANT_COLOR = RenderingContext.ONE_MINUS_CONSTANT_COLOR;
const int ONE_MINUS_DST_ALPHA = RenderingContext.ONE_MINUS_DST_ALPHA;
const int ONE_MINUS_DST_COLOR = RenderingContext.ONE_MINUS_DST_COLOR;*/
const int ONE_MINUS_SRC_ALPHA = RenderingContext.ONE_MINUS_SRC_ALPHA;/*
const int ONE_MINUS_SRC_COLOR = RenderingContext.ONE_MINUS_SRC_COLOR;
const int OUT_OF_MEMORY = RenderingContext.OUT_OF_MEMORY;
const int PACK_ALIGNMENT = RenderingContext.PACK_ALIGNMENT;
const int POINTS = RenderingContext.POINTS;
const int POLYGON_OFFSET_FACTOR = RenderingContext.POLYGON_OFFSET_FACTOR;*/
const int POLYGON_OFFSET_FILL = RenderingContext.POLYGON_OFFSET_FILL;/*
const int POLYGON_OFFSET_UNITS = RenderingContext.POLYGON_OFFSET_UNITS;
const int RED_BITS = RenderingContext.RED_BITS;
const int RENDERBUFFER = RenderingContext.RENDERBUFFER;
const int RENDERBUFFER_ALPHA_SIZE = RenderingContext.RENDERBUFFER_ALPHA_SIZE;
const int RENDERBUFFER_BINDING = RenderingContext.RENDERBUFFER_BINDING;
const int RENDERBUFFER_BLUE_SIZE = RenderingContext.RENDERBUFFER_BLUE_SIZE;
const int RENDERBUFFER_DEPTH_SIZE = RenderingContext.RENDERBUFFER_DEPTH_SIZE;
const int RENDERBUFFER_GREEN_SIZE = RenderingContext.RENDERBUFFER_GREEN_SIZE;
const int RENDERBUFFER_HEIGHT = RenderingContext.RENDERBUFFER_HEIGHT;
const int RENDERBUFFER_INTERNAL_FORMAT = RenderingContext.RENDERBUFFER_INTERNAL_FORMAT;
const int RENDERBUFFER_RED_SIZE = RenderingContext.RENDERBUFFER_RED_SIZE;
const int RENDERBUFFER_STENCIL_SIZE = RenderingContext.RENDERBUFFER_STENCIL_SIZE;
const int RENDERBUFFER_WIDTH = RenderingContext.RENDERBUFFER_WIDTH;
const int RENDERER = RenderingContext.RENDERER;
const int REPEAT = RenderingContext.REPEAT;
const int REPLACE = RenderingContext.REPLACE;
const int RGB = RenderingContext.RGB;
const int RGB565 = RenderingContext.RGB565;
const int RGB5_A1 = RenderingContext.RGB5_A1;
const int RGBA = RenderingContext.RGBA;
const int RGBA4 = RenderingContext.RGBA4;
const int SAMPLER_2D = RenderingContext.SAMPLER_2D;
const int SAMPLER_CUBE = RenderingContext.SAMPLER_CUBE;
const int SAMPLES = RenderingContext.SAMPLES;
const int SAMPLE_ALPHA_TO_COVERAGE = RenderingContext.SAMPLE_ALPHA_TO_COVERAGE;
const int SAMPLE_BUFFERS = RenderingContext.SAMPLE_BUFFERS;
const int SAMPLE_COVERAGE = RenderingContext.SAMPLE_COVERAGE;
const int SAMPLE_COVERAGE_INVERT = RenderingContext.SAMPLE_COVERAGE_INVERT;
const int SAMPLE_COVERAGE_VALUE = RenderingContext.SAMPLE_COVERAGE_VALUE;
const int SCISSOR_BOX = RenderingContext.SCISSOR_BOX;
const int SCISSOR_TEST = RenderingContext.SCISSOR_TEST;
const int SHADER_TYPE = RenderingContext.SHADER_TYPE;
const int SHADING_LANGUAGE_VERSION = RenderingContext.SHADING_LANGUAGE_VERSION;
const int SHORT = RenderingContext.SHORT;*/
const int SRC_ALPHA = RenderingContext.SRC_ALPHA;/*
const int SRC_ALPHA_SATURATE = RenderingContext.SRC_ALPHA_SATURATE;
const int SRC_COLOR = RenderingContext.SRC_COLOR;*/
const int STATIC_DRAW = RenderingContext.STATIC_DRAW;/*
const int STENCIL_ATTACHMENT = RenderingContext.STENCIL_ATTACHMENT;
const int STENCIL_BACK_FAIL = RenderingContext.STENCIL_BACK_FAIL;
const int STENCIL_BACK_FUNC = RenderingContext.STENCIL_BACK_FUNC;
const int STENCIL_BACK_PASS_DEPTH_FAIL = RenderingContext.STENCIL_BACK_PASS_DEPTH_FAIL;
const int STENCIL_BACK_PASS_DEPTH_PASS = RenderingContext.STENCIL_BACK_PASS_DEPTH_PASS;
const int STENCIL_BACK_REF = RenderingContext.STENCIL_BACK_REF;
const int STENCIL_BACK_VALUE_MASK = RenderingContext.STENCIL_BACK_VALUE_MASK;
const int STENCIL_BACK_WRITEMASK = RenderingContext.STENCIL_BACK_WRITEMASK;
const int STENCIL_BITS = RenderingContext.STENCIL_BITS;*/
const int STENCIL_BUFFER_BIT = RenderingContext.STENCIL_BUFFER_BIT;/*
const int STENCIL_CLEAR_VALUE = RenderingContext.STENCIL_CLEAR_VALUE;
const int STENCIL_FAIL = RenderingContext.STENCIL_FAIL;
const int STENCIL_FUNC = RenderingContext.STENCIL_FUNC;
const int STENCIL_INDEX = RenderingContext.STENCIL_INDEX;
const int STENCIL_INDEX8 = RenderingContext.STENCIL_INDEX8;
const int STENCIL_PASS_DEPTH_FAIL = RenderingContext.STENCIL_PASS_DEPTH_FAIL;
const int STENCIL_PASS_DEPTH_PASS = RenderingContext.STENCIL_PASS_DEPTH_PASS;
const int STENCIL_REF = RenderingContext.STENCIL_REF;
const int STENCIL_TEST = RenderingContext.STENCIL_TEST;
const int STENCIL_VALUE_MASK = RenderingContext.STENCIL_VALUE_MASK;
const int STENCIL_WRITEMASK = RenderingContext.STENCIL_WRITEMASK;
const int STREAM_DRAW = RenderingContext.STREAM_DRAW;
const int SUBPIXEL_BITS = RenderingContext.SUBPIXEL_BITS;
const int TEXTURE = RenderingContext.TEXTURE;
const int TEXTURE0 = RenderingContext.TEXTURE0;
const int TEXTURE1 = RenderingContext.TEXTURE1;
const int TEXTURE10 = RenderingContext.TEXTURE10;
const int TEXTURE11 = RenderingContext.TEXTURE11;
const int TEXTURE12 = RenderingContext.TEXTURE12;
const int TEXTURE13 = RenderingContext.TEXTURE13;
const int TEXTURE14 = RenderingContext.TEXTURE14;
const int TEXTURE15 = RenderingContext.TEXTURE15;
const int TEXTURE16 = RenderingContext.TEXTURE16;
const int TEXTURE17 = RenderingContext.TEXTURE17;
const int TEXTURE18 = RenderingContext.TEXTURE18;
const int TEXTURE19 = RenderingContext.TEXTURE19;
const int TEXTURE2 = RenderingContext.TEXTURE2;
const int TEXTURE20 = RenderingContext.TEXTURE20;
const int TEXTURE21 = RenderingContext.TEXTURE21;
const int TEXTURE22 = RenderingContext.TEXTURE22;
const int TEXTURE23 = RenderingContext.TEXTURE23;
const int TEXTURE24 = RenderingContext.TEXTURE24;
const int TEXTURE25 = RenderingContext.TEXTURE25;
const int TEXTURE26 = RenderingContext.TEXTURE26;
const int TEXTURE27 = RenderingContext.TEXTURE27;
const int TEXTURE28 = RenderingContext.TEXTURE28;
const int TEXTURE29 = RenderingContext.TEXTURE29;
const int TEXTURE3 = RenderingContext.TEXTURE3;
const int TEXTURE30 = RenderingContext.TEXTURE30;
const int TEXTURE31 = RenderingContext.TEXTURE31;
const int TEXTURE4 = RenderingContext.TEXTURE4;
const int TEXTURE5 = RenderingContext.TEXTURE5;
const int TEXTURE6 = RenderingContext.TEXTURE6;
const int TEXTURE7 = RenderingContext.TEXTURE7;
const int TEXTURE8 = RenderingContext.TEXTURE8;
const int TEXTURE9 = RenderingContext.TEXTURE9;
const int TEXTURE_2D = RenderingContext.TEXTURE_2D;
const int TEXTURE_BINDING_2D = RenderingContext.TEXTURE_BINDING_2D;
const int TEXTURE_BINDING_CUBE_MAP = RenderingContext.TEXTURE_BINDING_CUBE_MAP;
const int TEXTURE_CUBE_MAP = RenderingContext.TEXTURE_CUBE_MAP;
const int TEXTURE_CUBE_MAP_NEGATIVE_X = RenderingContext.TEXTURE_CUBE_MAP_NEGATIVE_X;
const int TEXTURE_CUBE_MAP_NEGATIVE_Y = RenderingContext.TEXTURE_CUBE_MAP_NEGATIVE_Y;
const int TEXTURE_CUBE_MAP_NEGATIVE_Z = RenderingContext.TEXTURE_CUBE_MAP_NEGATIVE_Z;
const int TEXTURE_CUBE_MAP_POSITIVE_X = RenderingContext.TEXTURE_CUBE_MAP_POSITIVE_X;
const int TEXTURE_CUBE_MAP_POSITIVE_Y = RenderingContext.TEXTURE_CUBE_MAP_POSITIVE_Y;
const int TEXTURE_CUBE_MAP_POSITIVE_Z = RenderingContext.TEXTURE_CUBE_MAP_POSITIVE_Z;
const int TEXTURE_MAG_FILTER = RenderingContext.TEXTURE_MAG_FILTER;
const int TEXTURE_MIN_FILTER = RenderingContext.TEXTURE_MIN_FILTER;
const int TEXTURE_WRAP_S = RenderingContext.TEXTURE_WRAP_S;
const int TEXTURE_WRAP_T = RenderingContext.TEXTURE_WRAP_T;*/
const int TRIANGLES = RenderingContext.TRIANGLES;
const int TRIANGLE_FAN = RenderingContext.TRIANGLE_FAN;
const int TRIANGLE_STRIP = RenderingContext.TRIANGLE_STRIP;/*
const int UNPACK_ALIGNMENT = RenderingContext.UNPACK_ALIGNMENT;
const int UNPACK_COLORSPACE_CONVERSION_WEBGL = RenderingContext.UNPACK_COLORSPACE_CONVERSION_WEBGL;
const int UNPACK_FLIP_Y_WEBGL = RenderingContext.UNPACK_FLIP_Y_WEBGL;
const int UNPACK_PREMULTIPLY_ALPHA_WEBGL = RenderingContext.UNPACK_PREMULTIPLY_ALPHA_WEBGL;
const int UNSIGNED_BYTE = RenderingContext.UNSIGNED_BYTE;
const int UNSIGNED_INT = RenderingContext.UNSIGNED_INT;*/
const int UNSIGNED_SHORT = RenderingContext.UNSIGNED_SHORT;/*
const int UNSIGNED_SHORT_4_4_4_4 = RenderingContext.UNSIGNED_SHORT_4_4_4_4;
const int UNSIGNED_SHORT_5_5_5_1 = RenderingContext.UNSIGNED_SHORT_5_5_5_1;
const int UNSIGNED_SHORT_5_6_5 = RenderingContext.UNSIGNED_SHORT_5_6_5;*/
const int VALIDATE_STATUS = RenderingContext.VALIDATE_STATUS;
const int VENDOR = RenderingContext.VENDOR;/*
const int VERSION = RenderingContext.VERSION;
const int VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = RenderingContext.VERTEX_ATTRIB_ARRAY_BUFFER_BINDING;
const int VERTEX_ATTRIB_ARRAY_ENABLED = RenderingContext.VERTEX_ATTRIB_ARRAY_ENABLED;
const int VERTEX_ATTRIB_ARRAY_NORMALIZED = RenderingContext.VERTEX_ATTRIB_ARRAY_NORMALIZED;
const int VERTEX_ATTRIB_ARRAY_POINTER = RenderingContext.VERTEX_ATTRIB_ARRAY_POINTER;
const int VERTEX_ATTRIB_ARRAY_SIZE = RenderingContext.VERTEX_ATTRIB_ARRAY_SIZE;
const int VERTEX_ATTRIB_ARRAY_STRIDE = RenderingContext.VERTEX_ATTRIB_ARRAY_STRIDE;
const int VERTEX_ATTRIB_ARRAY_TYPE = RenderingContext.VERTEX_ATTRIB_ARRAY_TYPE;*/
const int VERTEX_SHADER = RenderingContext.VERTEX_SHADER;/*
const int VIEWPORT = RenderingContext.VIEWPORT;
const int ZERO = RenderingContext.ZERO;
*/

class RenderingContext extends CanvasRenderingContext {
  RenderingContext(canvas) : super(canvas);
  
  // TODO(nfgs) - Should we get this from the extension ?!
  static const int ARRAY_BUFFER = 0x8892;
  static const int BACK = 0x0405;
  static const int BLEND = 0x0BE2;
  static const int CCW = 0x0901;
  static const int COLOR_BUFFER_BIT = 0x00004000;
  static const int COMPILE_STATUS = 0x8B81;
  static const int COMPRESSED_TEXTURE_FORMATS = 0x86A3;
  static const int CULL_FACE = 0x0B44;
  static const int DELETE_STATUS = 0x8B80;
  static const int DEPTH_BUFFER_BIT = 0x00000100;
  static const int DEPTH_TEST = 0x0B71;
  static const int DYNAMIC_DRAW = 0x88E8;
  static const int ELEMENT_ARRAY_BUFFER = 0x8893;
  static const int FLOAT = 0x1406;
  static const int FRAGMENT_SHADER = 0x8B30;
  static const int FUNC_ADD = 0x8006;
  static const int HIGH_FLOAT = 0x8DF2;
  static const int HIGH_INT = 0x8DF5;
  static const int LEQUAL = 0x0203;
  static const int LINK_STATUS = 0x8B82;
  static const int LOW_FLOAT = 0x8DF0;
  static const int LOW_INT = 0x8DF3;
  static const int MAX_CUBE_MAP_TEXTURE_SIZE = 0x851C;
  static const int MAX_TEXTURE_IMAGE_UNITS = 0x8872;
  static const int MAX_TEXTURE_SIZE = 0x0D33;
  static const int MAX_VERTEX_TEXTURE_IMAGE_UNITS = 0x8B4C;
  static const int MAX_VERTEX_UNIFORM_VECTORS = 0x8DFB;
  static const int MEDIUM_FLOAT = 0x8DF1;
  static const int MEDIUM_INT = 0x8DF4;
  static const int ONE = 1;
  static const int ONE_MINUS_SRC_ALPHA = 0x0303;
  static const int POLYGON_OFFSET_FILL = 0x8037;
  static const int SRC_ALPHA = 0x0302;
  static const int STATIC_DRAW = 0x88E4;
  static const int STENCIL_BUFFER_BIT = 0x00000400;
  static const int TRIANGLES = 0x0004;
  static const int TRIANGLE_FAN = 0x0006;
  static const int TRIANGLE_STRIP = 0x0005;
  static const int VALIDATE_STATUS = 0x8B83;
  static const int VERTEX_SHADER = 0x8B31;
  static const int UNSIGNED_SHORT = 0x1403;

  attachShader(program, shader) => glAttachShader(program._id, shader._id);
  bindBuffer(target, buffer) => glBindBuffer(target, buffer._id);
  blendEquation(mode) => glBlendEquation(mode);
  blendEquationSeparate(modeRGB, modeAlpha) => glBlendEquationSeparate(modeRGB, modeAlpha);
  blendFunc(sfactor, dfactor) => glBlendFunc(sfactor, dfactor);
  blendFuncSeparate(srcRGB, dstRGB, srcAlpha, dstAlpha) => glBlendFuncSeparate(srcRGB, dstRGB, srcAlpha, dstAlpha); 
  bufferDataTyped(target, data, usage) => glBufferData(target, data, usage);
  clearColor(r, g, b, alpha) => glClearColor(r, g, b, alpha);
  clearDepth(depth) => glClearDepth(depth);
  clearStencil(int s) {} // TODO (nfgs)
  clear(mask) => glClear(mask);
  compileShader(shader) => glCompileShader(shader._id);
  createBuffer() => new Buffer._(glCreateBuffer());
  createProgram() => new Program._(glCreateProgram());
  createShader(shaderType) => new Shader._(glCreateShader(shaderType));
  deleteShader(shader) => glDeleteShader(shader._id);
  cullFace(mode) => glCullFace(mode);
  depthMask(flag) => glDepthMask(flag);
  depthFunc(func) => glDepthFunc(func); 
  drawArrays(mode, first, count) => glDrawArrays(mode, first, count);
  drawElements(mode, count, type, offset) => glDrawElements(mode, count, type, offset);
  disable(cap) => glDisable(cap);
  enable(cap) => glEnable(cap);
  enableVertexAttribArray(index) => glEnableVertexAttribArray(index);
  disableVertexAttribArray(index) => glDisableVertexAttribArray(index);
  frontFace(mode) => glFrontFace(mode);
  getAttribLocation(program, name) => glGetAttribLocation(program._id, name);
  getError() => glGetError();
  getParameter(name) => glGetParameter(name);
  getProgramParameter(program, name) {
    var rtn = glGetProgramParameter(program._id, name);
    if (name == DELETE_STATUS ||
        name == LINK_STATUS ||
        name == VALIDATE_STATUS) {
      return (rtn == 0) ? false : true;
    }
    return rtn;
  }
  getShaderParameter(shader, name) {
    var rtn = glGetShaderParameter(shader._id, name);
    if (name == DELETE_STATUS || name == COMPILE_STATUS) {
      return (rtn == 0) ? false : true;
    }
    return rtn;
  }
  ShaderPrecisionFormat getShaderPrecisionFormat(int shaderType, int precisionType) => 
  	new ShaderPrecisionFormat._(glGetShaderPrecisionFormat(shaderType, precisionType));
  getUniformLocation(program, name) => new UniformLocation._(glGetUniformLocation(program._id, name));
  linkProgram(program) => glLinkProgram(program._id);
  shaderSource(shader, source) => glShaderSource(shader._id, source);
  uniform1f(location, v0) => glUniform1f(location._id, v0);
  uniform2f(location, v0, v1) => glUniform2f(location._id, v0, v1);
  uniform3f(location, v0, v1, v2) => glUniform3f(location._id, v0, v1, v2);
  uniform4f(location, v0, v1, v2, v3) => glUniform4f(location._id, v0, v1, v2, v3);
  uniform1i(location, v0) => glUniform1i(location._id, v0);
  uniform2i(location, v0, v1) => glUniform2i(location._id, v0, v1);
  uniform3i(location, v0, v1, v2) => glUniform3i(location._id, v0, v1, v2);
  uniform4i(location, v0, v1, v2, v3) => glUniform4i(location._id, v0, v1, v2, v3);
  uniform1fv(location, values) => glUniform1fv(location._id, values);
  uniform2fv(location, values) => glUniform2fv(location._id, values);
  uniform3fv(location, values) => glUniform3fv(location._id, values);
  uniform4fv(location, values) => glUniform4fv(location._id, values);
  uniform1iv(location, values) => glUniform1iv(location._id, values);
  uniform2iv(location, values) => glUniform2iv(location._id, values);
  uniform3iv(location, values) => glUniform3iv(location._id, values);
  uniform4iv(location, values) => glUniform4iv(location._id, values);
  uniformMatrix4fv(location, transpose, array) => glUniformMatrix4fv(location._id, transpose, array);
  uniformMatrix3fv(location, transpose, array) => glUniformMatrix3fv(location._id, transpose, array);
  useProgram(program) => glUseProgram(program._id);
  vertexAttribPointer(index, size, type, normalized, stride, pointer) =>
    glVertexAttribPointer(index, size, type, normalized, stride, pointer);
  viewport(x, y, width, height) => glViewport(x, y, width, height);
  getShaderInfoLog(shader) => glGetShaderInfoLog(shader._id);
  getProgramInfoLog(program) => glGetProgramInfoLog(program._id);
  getExtension(name) => null;

  // TODO(vsm): Kill.
  noSuchMethod(invocation) {
      throw new Exception('Unimplemented ${invocation.memberName}');
  }
}

class _WebGLObject {
	int _id;
	_WebGLObject(this._id);
}

class Buffer extends _WebGLObject {
	Buffer._(int id) : super(id);
}

class Shader extends _WebGLObject {
	Shader._(int id) : super(id);
}

class Program extends _WebGLObject {
	Program._(int id) : super(id);
}

class Texture extends _WebGLObject {
	Texture._(int id) : super(id);
}

class UniformLocation extends _WebGLObject {
	UniformLocation._(int id) : super(id);
}

class ShaderPrecisionFormat {
  int precision, rangeMax, rangeMin;
  ShaderPrecisionFormat._(values) { 
  	precision = values[0];
  	rangeMin = values[1];
  	rangeMax = values[2]; 
  }
}

// EGL functions.
void glSwapBuffers() native "SwapBuffers";

// GL functions.
void glAttachShader(int program, int shader) native "GLAttachShader";
void glBindBuffer(int target, int buffer) native "GLBindBuffer";
void glBlendEquation(int mode) native "GLBlendEquation";
void glBlendEquationSeparate(int modeRGB, int modeAlpha) native "GLBlendEquationSeparate";
void glBlendFunc(int sfactor, int dfactor) native "GLBlendFunc";
void glBlendFuncSeparate(int srcRGB, int dstRGB, int srcAlpha, int dstAlpha) native "GLBlendFuncSeparate";
void glBufferData(int target, List data, int usage) native "GLBufferData";
void glClearColor(num r, num g, num b, num alpha) native "GLClearColor";
void glClearDepth(num depth) native "GLClearDepth";
void glClear(int mask) native "GLClear";
void glCompileShader(int shader) native "GLCompileShader";
int glCreateBuffer() native "GLCreateBuffer";
int glCreateProgram() native "GLCreateProgram";
int glCreateShader(int shaderType) native "GLCreateShader";
int glDeleteShader(int shader) native "GLDeleteShader";
void glCullFace(int mode) native "GLCullFace";
void glDepthMask(bool flag) native "GLDepthMask";
void glDepthFunc(int func) native "GLDepthFunc";
void glDrawArrays(int mode, int first, int count) native "GLDrawArrays";
void glDrawElements(int mode, int count, int type, int offset) native "GLDrawElements";
void glDisable(int cap) native "GLDisable";
void glEnable(int cap) native "GLEnable";
void glEnableVertexAttribArray(int index) native "GLEnableVertexAttribArray";
void glDisableVertexAttribArray(int index) native "GLDisableVertexAttribArray";
int glGetAttribLocation(int program, String name) native "GLGetAttribLocation";
void glFrontFace(int mode) native "GLFrontFace";
int glGetError() native "GLGetError";
int glGetParameter(int param) native "GLGetParameter";
int glGetProgramParameter(int program, int param)
    native "GLGetProgramParameter";
int glGetShaderParameter(int shader, int param) native "GLGetShaderParameter";
int glGetUniformLocation(int program, String name)
    native "GLGetUniformLocation";
void glLinkProgram(int program) native "GLLinkProgram";
List<int> glGetShaderPrecisionFormat(int shadertype, int precisiontype) native "GLGetShaderPrecisionFormat";
void glShaderSource(int shader, String source) native "GLShaderSource";
void glUniform1f(int location, double v0) native "GLUniform1f";
void glUniform2f(int location, double v0, double v1) native "GLUniform2f";
void glUniform3f(int location, double v0, double v1, double v2)
    native "GLUniform3f";
void glUniform4f(int location, double v0, double v1, double v2, double v3)
    native "GLUniform4f";
void glUniform1i(int location, int v0) native "GLUniform1i";
void glUniform2i(int location, int v0, int v1) native "GLUniform2i";
void glUniform3i(int location, int v0, int v1, int v2) native "GLUniform3i";
void glUniform4i(int location, int v0, int v1, int v2, int v3)
    native "GLUniform4i";
void glUniform1fv(int location, List values) native "GLUniform1fv";
void glUniform2fv(int location, List values) native "GLUniform2fv";
void glUniform3fv(int location, List values) native "GLUniform3fv";
void glUniform4fv(int location, List values) native "GLUniform4fv";
void glUniform1iv(int location, List values) native "GLUniform1iv";
void glUniform2iv(int location, List values) native "GLUniform2iv";
void glUniform3iv(int location, List values) native "GLUniform3iv";
void glUniform4iv(int location, List values) native "GLUniform4iv";
void glUniformMatrix3fv(int location, bool transpose, Float32List array) native "GLUniformMatrix3fv";
void glUniformMatrix4fv(int location, bool transpose, Float32List array) native "GLUniformMatrix4fv";
void glUseProgram(int program) native "GLUseProgram";
void glVertexAttribPointer(int index, int size, int type, bool normalized,
    int stride, int pointer) native "GLVertexAttribPointer";
void glViewport(int x, int y, int width, int height) native "GLViewport";

int glArrayBuffer() native "GLArrayBuffer";
int glColorBufferBit() native "GLColorBufferBit";
int glCompileStatus() native "GLCompileStatus";
int glDeleteStatus() native "GLDeleteStatus";
int glDepthBufferBit() native "GLDepthBufferBit";
int glFloat() native "GLFloat";
int glFragmentShader() native "GLFragmentShader";
int glLinkStatus() native "GLLinkStatus";
int glStaticDraw() native "GLStaticDraw";
int glTriangleStrip() native "GLTriangleStrip";
int glTriangles() native "GLTriangles";
int glTrue() native "GLTrue";
int glValidateStatus() native "GLValidateStatus";
int glVertexShader() native "GLVertexShader";

String glGetShaderInfoLog(int shader) native "GLGetShaderInfoLog";
String glGetProgramInfoLog(int program) native "GLGetProgramInfoLog";