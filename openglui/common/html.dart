library html;

import 'dart:async';
import 'dart:collection';
import 'dart:math' show Point, Rectangle;
import 'dart:typed_data';
import 'dart:web_gl' as gl;

// A VERY simplified DOM.

class BodyElement {
  List _nodes;
  get nodes => _nodes;
  get children => nodes;
  BodyElement() : _nodes = new List();
}

// The OpenGLUI "equivalent" of Window.

typedef void RequestAnimationFrameCallback(num highResTime);

class Console {
  Console._();
  log(msg) { _log(msg); }
}

class Navigator {
  final String userAgent = "";
}

class Window extends EventTarget {
  static int _nextId = 0;
  List _callbacks;
  List _arguments;
  Console console;
  num innerWidth, innerHeight;
  final double devicePixelRatio = 1.0;
  final Navigator navigator = new Navigator();

  Window._internal() : console = new Console._(), _callbacks = [], _arguments = [];

  int _scheduleCallback(callback, [argument]) {
    _callbacks.add(callback);
    _arguments.add(argument);
    return _callbacks.length - 1;
  }

  int requestAnimationFrame(RequestAnimationFrameCallback callback) {
    return _scheduleCallback(callback,
        (new DateTime.now()).millisecondsSinceEpoch);
  }

  void cancelAnimationFrame(id) {
    _callbacks[id] = null;
    _arguments[id] = null;
  }

  get animationFrame {
    // TODO(gram)
    return null;
  }

  void _dispatch() {
    // We clear out the callbacks map before calling any callbacks,
    // as they may schedule new callbacks.
    var oldcallbacks = _callbacks;
    var oldarguments = _arguments;
    _callbacks = [];
    _arguments = [];
    for (var i = 0; i < oldcallbacks.length; i++) {
      if (oldcallbacks[i] != null) {
        oldcallbacks[i](oldarguments[i]);
      }
    }
    // We could loop around here to handle any callbacks
    // scheduled in processing the prior ones, but then we
    // need some other mechanism for trying to get requestAnimationFrame
    // callbacks at 60fps.
  }

  Map localStorage = {};  // TODO(gram) - Make this persistent.

  Stream<DeviceMotionEvent> get onDeviceMotion => new _EventStream(this, 'devicemotion');
  Stream<MouseEvent> get onBlur => new _EventStream(this, 'blur');
  Stream<MouseEvent> get onResize => new _EventStream(this, 'resize');


  // TODO - Extend Node ?
  Stream<KeyboardEvent> get onKeyDown => new _EventStream(this, 'keydown');
  Stream<KeyboardEvent> get onKeyUp => new _EventStream(this, 'keyup');
  Stream<MouseEvent> get onMouseDown => new _EventStream(this, 'mousedown');
  Stream<MouseEvent> get onMouseMove => new _EventStream(this, 'mousemove');
  Stream<MouseEvent> get onMouseUp => new _EventStream(this, 'mouseup');
  Stream<MouseEvent> get onMouseOut => new _EventStream(this, 'mouseout');
  Stream<TouchEvent> get onTouchCancel => new _EventStream(this, 'touchcancel');
  Stream<TouchEvent> get onTouchEnd => new _EventStream(this, 'touchend');
  Stream<TouchEvent> get onTouchMove => new _EventStream(this, 'touchmove');
  Stream<TouchEvent> get onTouchStart => new _EventStream(this, 'touchstart');
  Stream<PopStateEvent> get onPopState => new _EventStream(this, 'popstate');
}

Window window = new Window._internal();

// The OpenGLUI "equivalent" of HtmlDocument.
class Document extends Node {
  BodyElement _body;
  get body => _body;
  Document._internal() : _body = new BodyElement();
  querySelector(String selectors) => null;
}

Document document = new Document._internal();

var querySelector = document.querySelector;
var query = querySelector;

// TODO(gram): make private and call from within library context.
update_() {
  _log("in update");
  window._dispatch();
}

// Event handling. This is very kludgy for now, especially the
// bare-bones Stream stuff!

typedef void EventListener(Event event);

class EventTarget {
  static Map<EventTarget, Map<String, List<EventListener>>>
      _listeners = new Map();

  static get listeners => _listeners;

  bool dispatchEvent(Event event) {
    var rtn = false;
    if (!_listeners.containsKey(this)) return false;
    var listeners = _listeners[this];
    if (!listeners.containsKey(event.type)) return false;
    var eventListeners = listeners[event.type];
    for (var eventListener in eventListeners) {
      if (eventListener != null) {
        eventListener(event);
        rtn = true;
      }
    }
    return rtn;
  }

  void addListener(String eventType, EventListener handler) {
    if (!_listeners.containsKey(this)) {
      _listeners[this] = new Map();
    }
    var listeners = _listeners[this];
    if (!listeners.containsKey(eventType)) {
      listeners[eventType] = new List();
    }
    var event_listeners = listeners[eventType];
    for (var i = 0; i < event_listeners.length; i++) {
      if (event_listeners[i] == null) {
        event_listeners[i] = handler;
        return;
      }
    }
    event_listeners.add(handler);
  }

  void removeListener(String eventType, EventListener handler) {
    if (_listeners.containsKey(this)) {
      var listeners = _listeners[this];
      if (listeners.containsKey(eventType)) {
        var event_listeners = listeners[eventType];
        for (var i = 0; i < event_listeners.length; i++) {
          if (event_listeners[i] == handler) {
            event_listeners[i] = null;
            break;
          }
        }
      }
    }
  }
}

class Event {
  final String type;
  EventTarget target;
  Event(String type) : this.type = type;
  preventDefault() {}
  stopPropagation() {}
}

class KeyboardEvent extends Event {
  final bool altKey;
  final bool ctrlKey;
  final bool shiftKey;
  final int keyCode;

  KeyboardEvent(String type, int keycode, bool alt, bool ctrl, bool shift)
    : super(type),
      keyCode = keycode,
      altKey = alt,
      ctrlKey = ctrl,
      shiftKey = shift {
  }
}

class MouseEvent extends Event {
  final int screenX, screenY;
  final int clientX, clientY;
  final Point offset;
  final Point client;
  final bool altKey;
  final bool ctrlKey;
  final bool shiftKey;

  final int button = 0;

  MouseEvent(String type, int x, int y)
    : super(type),
      screenX = x,
      screenY = y,
      clientX = x,
      clientY = y,
      altKey = false,
      ctrlKey = false,
      shiftKey = false,
      offset = new Point(x, y),
      client = new Point(x, y) {
  }
}

class TouchEvent extends Event {
  TouchList touches,
            targetTouches,
            changedTouches;

  TouchEvent(String type,
      this.touches, this.targetTouches, this.changedTouches,
      {Window view, int screenX: 0, int screenY: 0, int clientX: 0,
      int clientY: 0, bool ctrlKey: false, bool altKey: false,
      bool shiftKey: false, bool metaKey: false}) : super(type) {
  }

  static bool supported = true;
}

class TouchList extends Object with ListMixin<Touch> implements List {
  Touch item(int index) => this[index];
}

class DeviceAcceleration  {
  double x, y, z;
  DeviceAcceleration(this.x, this.y, this.z);
}

class DeviceMotionEvent extends Event {
  DeviceAcceleration _acceleration;

  double interval = 1000.0 / 60.0; // 60 FPS

  DeviceMotionEvent(String type, double x, double y, double z)
    : super(type),
      _acceleration = new DeviceAcceleration(x, y, z);

  DeviceAcceleration get acceleration => _acceleration;

  DeviceAcceleration get accelerationIncludingGravity =>
      throw new Exception('Unimplemented accelerationIncludingGravity');
}

class _EventStreamSubscription<T extends Event> extends StreamSubscription<T> {
  int _pauseCount = 0;
  EventTarget _target;
  final String _eventType;
  var _onData;

  _EventStreamSubscription(this._target, this._eventType, this._onData) {
    _tryResume();
  }

  Future cancel() {
    if (_canceled) {
      throw new StateError("Subscription has been canceled.");
    }

    _unlisten();
    // Clear out the target to indicate this is complete.
    _target = null;
    _onData = null;

    return null;
  }

  bool get _canceled => _target == null;

  void onData(void handleData(T event)) {
    if (_canceled) {
      throw new StateError("Subscription has been canceled.");
    }
    // Remove current event listener.
    _unlisten();

    _onData = handleData;
    _tryResume();
  }

  /// Has no effect.
  void onError(void handleError(Object error)) {}

  /// Has no effect.
  void onDone(void handleDone()) {}

  void pause([Future resumeSignal]) {
    if (_canceled) {
      throw new StateError("Subscription has been canceled.");
    }
    ++_pauseCount;
    _unlisten();

    if (resumeSignal != null) {
      resumeSignal.whenComplete(resume);
    }
  }

  bool get isPaused => _pauseCount > 0;

  void resume() {
    if (_canceled) {
      throw new StateError("Subscription has been canceled.");
    }
    if (!isPaused) {
      throw new StateError("Subscription is not paused.");
    }
    --_pauseCount;
    _tryResume();
  }

  void _tryResume() {
    if (_onData != null && !isPaused) {
      _target.addListener(_eventType, _onData);
    }
  }

  void _unlisten() {
    if (_onData != null) {
      _target.removeListener(_eventType, _onData);
    }
  }

  Future asFuture([var futureValue]) {
    // We just need a future that will never succeed or fail.
    Completer completer = new Completer();
    return completer.future;
  }
}

class _EventStream<T extends Event> extends Stream<T> {
  final Object _target;
  final String _eventType;

  _EventStream(this._target, this._eventType);

  // DOM events are inherently multi-subscribers.
  Stream<T> asBroadcastStream({onListen, onCancel}) => this;
  bool get isBroadcast => true;

  StreamSubscription<T> listen(void onData(T event),
      { void onError(Object error),
      void onDone(),
      bool cancelOnError}) {

    return new _EventStreamSubscription<T>(
        this._target, this._eventType, onData);
  }
}

class Node extends EventTarget {
  Stream<KeyboardEvent> get onKeyDown => new _EventStream(this, 'keydown');
  Stream<KeyboardEvent> get onKeyUp => new _EventStream(this, 'keyup');
  Stream<KeyboardEvent> get onKeyPress => new _EventStream(this, 'keypress');
  Stream<MouseEvent> get onMouseDown => new _EventStream(this, 'mousedown');
  Stream<MouseEvent> get onMouseMove => new _EventStream(this, 'mousemove');
  Stream<MouseEvent> get onMouseUp => new _EventStream(this, 'mouseup');
  Stream<MouseEvent> get onMouseOut => new _EventStream(this, 'mouseout');
  Stream<MouseEvent> get onMouseWheel => new _EventStream(this, 'mousewheel');
}

class Element extends Node {
  CssStyleDeclaration style;
  Element() : super(), style = new CssStyleDeclaration();
  void focus() {}
}

class CssStyleDeclaration {

  set cursor(v) {}

  noSuchMethod(invocation) {
    print('Unimplemented ${invocation.memberName}');
  }
}

// TODO(gram): If we support more than one on-screen canvas, we will
// need to filter dispatched mouse and key events by the target Node
// with more granularity; right now we just iterate through DOM nodes
// until we find one that handles the event.
_dispatchEvent(Event event) {
  //assert(document.body.nodes.length <= 1);
  for (var target in document.body.nodes) {
    event.target = target;
    if (target.dispatchEvent(event)) {
      return;
    }
  }
  document.dispatchEvent(event);
}

_dispatchKeyEvent(String type, int keyCode, bool alt, bool ctrl, bool shift) {
  _dispatchEvent(new KeyboardEvent(type, keyCode, alt, ctrl, shift));
}

_dispatchMouseEvent(String type, double x, double y) {
  _dispatchEvent(new MouseEvent(type, x.toInt(), y.toInt()));
}

// These next few are called by vmglue.cc.
onKeyDown_(int when, int keyCode, bool alt, bool ctrl, bool shift, int repeat)
    =>  _dispatchKeyEvent('keydown', keyCode, alt, ctrl, shift);

onKeyUp_(int when, int keyCode, bool alt, bool ctrl, bool shift, int repeat) =>
    _dispatchKeyEvent('keyup', keyCode, alt, ctrl, shift);

onMouseDown_(int when, double x, double y) =>
    _dispatchMouseEvent('mousedown', x, y);

onMouseMove_(int when, double x, double y) =>
    _dispatchMouseEvent('mousemove', x, y);

onMouseUp_(int when, double x, double y) =>
    _dispatchMouseEvent('mouseup', x, y);

onAccelerometer_(double x, double y, double z) =>
    window.dispatchEvent(new DeviceMotionEvent('devicemotion', x, y, z));

abstract class CanvasImageSource {}

class CanvasElement extends Element implements CanvasImageSource {
  int height;
  int width;
  int tabIndex = 0;

  CanvasRenderingContext2D _context2d;
  gl.RenderingContext _context3d;

  // For use with drawImage, we want to support a src property
  // like ImageElement, which maps to the context handle in native
  // code.
  get src => "context2d://${_context2d.handle}";

  CanvasElement({int width, int height})
    : super() {
    this.width = (width == null) ? getDeviceScreenWidth() : width;
    this.height = (height == null) ? getDeviceScreenHeight() : height;
    getContext('2d');
  }

  CanvasRenderingContext getContext(String contextId, [Map attrs]) {
    if (contextId == "2d") {
      if (_context2d == null) {
        _context2d = new CanvasRenderingContext2D(this, width, height);
      }
      return _context2d;
    } else if (contextId == "webgl" ||
               contextId == "experimental-webgl") {
      if (_context3d == null) {
        _context3d = new gl.RenderingContext(this);
      }
      return _context3d;
    }
  }

  CanvasRenderingContext get context2D => getContext("2d");

  CanvasRenderingContext getContext3d({alpha: true, depth: true, stencil: false,
    antialias: true, premultipliedAlpha: true, preserveDrawingBuffer: false}) {

    var options = {
      'alpha': alpha,
      'depth': depth,
      'stencil': stencil,
      'antialias': antialias,
      'premultipliedAlpha': premultipliedAlpha,
      'preserveDrawingBuffer': preserveDrawingBuffer,
    };

    return getContext('webgl', options);
  }

  String toDataUrl(String type) {
    // This needs to take the contents of the underlying
    // canvas painted by the 2d context, give that a unique
    // URL, and return that. The canvas element should be
    // reuable afterwards without destroying the previously
    // rendered data associated with this URL.
    assert(_context2d != null);
    var rtn = src;
    _context2d = null;
    return rtn;
  }

  Rectangle getBoundingClientRect() => new Rectangle(0, 0, width, height);
  get clientLeft => 0;
  get clientTop => 0;
  get clientWidth => width;
  get clientHeight => height;
}

class CanvasRenderingContext {
  final CanvasElement canvas;
  final double backingStorePixelRatio = 1.0;

  CanvasRenderingContext(this.canvas);
}

class MediaElement {
  String canPlayType(String type, [String keySystem]) => "maybe";
}

class AudioElement extends EventTarget with MediaElement {
  double volume;
  bool loop = false;
  bool ended = true;
  num currentTime = 0;

  String _src;
  get src => _src;
  set src(String v) {
    _src = v;
    _loadSample(v);
  }

  void load() {
    var evt = new Event("canplaythrough")..target = this;
    dispatchEvent(evt);
  }

  AudioElement([this._src]);
  void play() {
    _playSample(_src);
  }

  AudioElement clone(bool deep) => new AudioElement()..src = src;

  Stream<Event> get onError => new _EventStream(this, 'error');
  Stream<Event> get onEnded => new _EventStream(this, 'ended');
  Stream<Event> get onCanPlayThrough => new _EventStream(this, 'canplaythrough');
}

//------------------------------------------------------------------
// Simple audio support.

void playBackground(String path) native "PlayBackground";
void stopBackground() native "StopBackground";

//-------------------------------------------------------------------
// Set up print().

get _printClosure => (s) {
  try {
    _log(s);
  } catch (_) {
    throw(s);
  }
};

// The simplest way to call native code: top-level functions.
int systemRand() native "SystemRand";
void systemSrand(int seed) native "SystemSrand";
void _log(String what) native "Log";

int getDeviceScreenWidth() native "GetDeviceScreenWidth";
int getDeviceScreenHeight() native "GetDeviceScreenHeight";

//------------------------------------------------------------------
// 2D canvas support

int _SetWidth(int handle, int width)
    native "C2DSetWidth";
int _SetHeight(int handle, int height)
    native "C2DSetHeight";

double _SetGlobalAlpha(int handle, double globalAlpha)
    native "C2DSetGlobalAlpha";
void _SetFillStyle(int handle, fs)
    native "C2DSetFillStyle";
String _SetFont(int handle, String font)
    native "C2DSetFont";
void _SetGlobalCompositeOperation(int handle, String op)
    native "C2DSetGlobalCompositeOperation";
_SetLineCap(int handle, String lc)
    native "C2DSetLineCap";
_SetLineJoin(int handle, String lj)
    native "C2DSetLineJoin";
_SetLineWidth(int handle, double w)
    native "C2DSetLineWidth";
_SetMiterLimit(int handle, double limit)
    native "C2DSetMiterLimit";
_SetShadowBlur(int handle, double blur)
    native "C2DSetShadowBlur";
_SetShadowColor(int handle, String color)
    native "C2DSetShadowColor";
_SetShadowOffsetX(int handle, double offset)
    native "C2DSetShadowOffsetX";
_SetShadowOffsetY(int handle, double offset)
    native "C2DSetShadowOffsetY";
void _SetStrokeStyle(int handle, ss)
    native "C2DSetStrokeStyle";
String _SetTextAlign(int handle, String align)
    native "C2DSetTextAlign";
String _SetTextBaseline(int handle, String baseline)
    native "C2DSetTextBaseline";
_GetBackingStorePixelRatio(int handle)
    native "C2DGetBackingStorePixelRatio";
void _SetImageSmoothingEnabled(int handle, bool ise)
    native "C2DSetImageSmoothingEnabled";
void _SetLineDash(int handle, List v)
    native "C2DSetLineDash";
_SetLineDashOffset(int handle, int v)
    native "C2DSetLineDashOffset";
void _Arc(int handle, double x, double y, double radius,
    double startAngle, double endAngle, [bool anticlockwise = false])
    native "C2DArc";
void _ArcTo(int handle, double x1, double y1,
              double x2, double y2, double radius)
    native "C2DArcTo";
void _ArcTo2(int handle, double x1, double y1,
               double x2, double y2, double radiusX,
    double radiusY, double rotation)
    native "C2DArcTo2";
void _BeginPath(int handle)
    native "C2DBeginPath";
void _BezierCurveTo(int handle, double cp1x, double cp1y,
                      double cp2x, double cp2y, double x, double y)
    native "C2DBezierCurveTo";
void _ClearRect(int handle, double x, double y, double w, double h)
    native "C2DClearRect";
void _Clip(int handle)
    native "C2DClip";
void _ClosePath(int handle)
    native "C2DClosePath";
ImageData _CreateImageDataFromDimensions(int handle, num w, num h)
    native "C2DCreateImageDataFromDimensions";
void _DrawImage(int handle, String src_url,
                  int sx, int sy,
                  bool has_src_dimensions, int sw, int sh,
                  int dx, int dy,
                  bool has_dst_dimensions, int dw, int dh)
    native "C2DDrawImage";
void _Fill(int handle)
    native "C2DFill";
void _FillRect(int handle, double x, double y, double w, double h)
    native "C2DFillRect";
void _FillText(int handle, String text, double x, double y, double maxWidth)
    native "C2DFillText";
ImageData _GetImageData(num sx, num sy, num sw, num sh)
    native "C2DGetImageData";
void _LineTo(int handle, double x, double y)
    native "C2DLineTo";
double _MeasureText(int handle, String text)
    native "C2DMeasureText";
void _MoveTo(int handle, double x, double y)
    native "C2DMoveTo";
void _PutImageData(int handle, ImageData imagedata, double dx, double dy)
    native "C2DPutImageData";
void _QuadraticCurveTo(int handle, double cpx, double cpy,
    double x, double y)
        native "C2DQuadraticCurveTo";
void _Rect(int handle, double x, double y, double w, double h)
    native "C2DRect";
void _Restore(int handle)
    native "C2DRestore";
void _Rotate(int handle, double a)
    native "C2DRotate";
void _Save(int handle)
    native "C2DSave";
void _Scale(int handle, double sx, double sy)
    native "C2DScale";
void _SetTransform(int handle, double m11, double m12,
                     double m21, double m22, double dx, double dy)
    native "C2DSetTransform";
void _Stroke(int handle)
    native "C2DStroke";
void _StrokeRect(int handle, double x, double y, double w, double h)
    native "C2DStrokeRect";
void _StrokeText(int handle, String text, double x, double y,
    double maxWidth)
        native "C2DStrokeText";
void _Transform(int handle, double m11, double m12,
                  double m21, double m22, double dx, double dy)
    native "C2DTransform";
void _Translate(int handle, double x, double y)
    native "C2DTranslate";

void _CreateNativeContext(int handle, int width, int height)
    native "C2DCreateNativeContext";

void _SetFillGradient(int handle, bool isRadial,
        double x0, double y0, double r0,
        double x1, double y1, double r1,
        List<double> positions, List<String> colors)
    native "C2DSetFillGradient";

void _SetStrokeGradient(int handle, bool isRadial,
        double x0, double y0, double r0,
        double x1, double y1, double r1,
        List<double> positions, List<String> colors)
    native "C2DSetStrokeGradient";

int _GetImageWidth(String url)
    native "C2DGetImageWidth";

int _GetImageHeight(String url)
    native "C2DGetImageHeight";

class CanvasPattern {
  CanvasPattern() { throw new Exception('CanvasPattern'); }
}

class CanvasGradient {
  num _x0, _y0, _r0 = 0, _x1, _y1, _r1 = 0;
  bool _isRadial;
  List<double> _colorStopPositions = [];
  List<String> _colorStopColors = [];

  void addColorStop(num offset, String color) {
    _colorStopPositions.add(offset.toDouble());
    _colorStopColors.add(color);
  }

  CanvasGradient.linear(this._x0, this._y0, this._x1, this._y1)
      : _isRadial = false;

  CanvasGradient.radial(this._x0, this._y0, this._r0,
                        this._x1, this._y1, this._r1)
      : _isRadial = true;

  void setAsFillStyle(_handle) {
    _SetFillGradient(_handle, _isRadial,
        _x0.toDouble(), _y0.toDouble(), _r0.toDouble(),
        _x1.toDouble(), _y1.toDouble(), _r1.toDouble(),
        _colorStopPositions, _colorStopColors);
  }

  void setAsStrokeStyle(_handle) {
    _SetStrokeGradient(_handle, _isRadial,
        _x0.toDouble(), _y0.toDouble(), _r0.toDouble(),
        _x1.toDouble(), _y1.toDouble(), _r1.toDouble(),
        _colorStopPositions, _colorStopColors);
  }
}

class ImageElement extends Node implements CanvasImageSource {
  Stream<Event> get onLoad => new _EventStream(this, 'load');
  Stream<Event> get onError => new _EventStream(this, 'error');

  String _src;
  int _width;
  int _height;

  get src => _src;

  set src(String v) {
    _log("Set ImageElement src to $v");
    _src = v;
  }

  // The onLoad handler may be set after the src, so
  // we hook into that here...
  void addListener(String eventType, EventListener handler) {
    super.addListener(eventType, handler);
    if (eventType == 'load') {
      var e = new Event('load');
      e.target = this;
      window._scheduleCallback(handler, e);
    }
  }

  get width => _width == null ? _width = _GetImageWidth(_src) : _width;
  get height => _height == null ? _height = _GetImageHeight(_src) : _height;
  set width(int widthp) => _width = widthp;
  set height(int heightp) => _height = heightp;
  get naturalWidth => width;
  get naturalHeight => height;

  ImageElement({String srcp, int widthp, int heightp})
    : _src = srcp,
      _width = widthp,
      _height = heightp {
    if (_src != null) {
      if (_width == null) _width = _GetImageWidth(_src);
      if (_height == null) _height = _GetImageHeight(_src);
    }
  }
}

class ImageData {
  final Uint8ClampedList data;
  final int height;
  final int width;
  ImageData(this.height, this.width, this.data);
}

class TextMetrics {
  final num width;
  TextMetrics(this.width);
}

void shutdown() {
  CanvasRenderingContext2D.next_handle = 0;
}

class CanvasRenderingContext2D extends CanvasRenderingContext {
  // TODO(gram): We need to support multiple contexts, for cached content
  // prerendered to an offscreen buffer. For this we will use handles, with
  // handle 0 being the physical display.
  static int next_handle = 0;
  int _handle = 0;
  get handle => _handle;

  int _width, _height;
  set width(int w) { _width = _SetWidth(_handle, w); }
  get width => _width;
  set height(int h) { _height = _SetHeight(_handle, h); }
  get height => _height;

  CanvasRenderingContext2D(canvas, width, height) : super(canvas) {
    _width = width;
    _height = height;
    _CreateNativeContext(_handle = next_handle++, width, height);
  }

  double _alpha = 1.0;
  set globalAlpha(num a) {
    _alpha = _SetGlobalAlpha(_handle, a.toDouble());
  }
  get globalAlpha => _alpha;

  // TODO(gram): make sure we support compound assignments like:
  // fillStyle = strokeStyle = "red"
  var _fillStyle = "#000";
  set fillStyle(fs) {
    _fillStyle = fs;
    // TODO(gram): Support for CanvasPattern.
    if (fs is CanvasGradient) {
      fs.setAsFillStyle(_handle);
    } else {
      _SetFillStyle(_handle, fs);
    }
  }
  get fillStyle => _fillStyle;

  String _font = "10px sans-serif";
  set font(String f) { _font = _SetFont(_handle, f); }
  get font => _font;

  String _globalCompositeOperation = "source-over";
  set globalCompositeOperation(String o) =>
      _SetGlobalCompositeOperation(_handle, _globalCompositeOperation = o);
  get globalCompositeOperation => _globalCompositeOperation;

  String _lineCap = "butt"; // "butt", "round", "square"
  get lineCap => _lineCap;
  set lineCap(String lc) => _SetLineCap(_handle, _lineCap = lc);

  int _lineDashOffset = 0;
  get lineDashOffset => _lineDashOffset;
  set lineDashOffset(num v) {
    _lineDashOffset = v.toInt();
    _SetLineDashOffset(_handle, _lineDashOffset);
  }

  String _lineJoin = "miter"; // "round", "bevel", "miter"
  get lineJoin => _lineJoin;
  set lineJoin(String lj) =>  _SetLineJoin(_handle, _lineJoin = lj);

  num _lineWidth = 1.0;
  get lineWidth => _lineWidth;
  set lineWidth(num w) {
    _SetLineWidth(_handle, w.toDouble());
    _lineWidth = w;
  }

  num _miterLimit = 10.0; // (default 10)
  get miterLimit => _miterLimit;
  set miterLimit(num limit) {
    _SetMiterLimit(_handle, limit.toDouble());
    _miterLimit = limit;
  }

  num _shadowBlur;
  get shadowBlur =>  _shadowBlur;
  set shadowBlur(num blur) {
    _shadowBlur = blur;
    _SetShadowBlur(_handle, blur.toDouble());
  }

  String _shadowColor;
  get shadowColor => _shadowColor;
  set shadowColor(String color) =>
      _SetShadowColor(_handle, _shadowColor = color);

  num _shadowOffsetX;
  get shadowOffsetX => _shadowOffsetX;
  set shadowOffsetX(num offset) {
    _shadowOffsetX = offset;
    _SetShadowOffsetX(_handle, offset.toDouble());
  }

  num _shadowOffsetY;
  get shadowOffsetY => _shadowOffsetY;
  set shadowOffsetY(num offset) {
    _shadowOffsetY = offset;
    _SetShadowOffsetY(_handle, offset.toDouble());
  }

  var _strokeStyle = "#000";
  get strokeStyle => _strokeStyle;
  set strokeStyle(ss) {
    _strokeStyle = ss;
    // TODO(gram): Support for CanvasPattern.
    if (ss is CanvasGradient) {
      ss.setAsStrokeStyle(_handle);
    } else {
      _SetStrokeStyle(_handle, ss);
    }
  }

  String _textAlign = "start";
  get textAlign => _textAlign;
  set textAlign(String a) { _textAlign = _SetTextAlign(_handle, a); }

  String _textBaseline = "alphabetic";
  get textBaseline => _textBaseline;
  set textBaseline(String b) { _textBaseline = _SetTextBaseline(_handle, b); }

  get webkitBackingStorePixelRatio => _GetBackingStorePixelRatio(_handle);

  bool _webkitImageSmoothingEnabled;
  get webkitImageSmoothingEnabled => _webkitImageSmoothingEnabled;
  set webkitImageSmoothingEnabled(bool v) =>
     _SetImageSmoothingEnabled(_handle, _webkitImageSmoothingEnabled = v);

  get webkitLineDashOffset => lineDashOffset;
  set webkitLineDashOffset(num v) => lineDashOffset = v;

  // Methods

  void arc(num x, num y, num radius, num a1, num a2, bool anticlockwise) {
    if (radius < 0) {
      // throw IndexSizeError
    } else {
      _Arc(_handle, x.toDouble(), y.toDouble(), radius.toDouble(),
          a1.toDouble(), a2.toDouble(), anticlockwise);
    }
  }

  // Note - looking at the Dart docs it seems Dart doesn't support
  // the second form in the browser.
  void arcTo(num x1, num y1, num x2, num y2,
    num radiusX, [num radiusY, num rotation]) {
    if (radiusY == null) {
      _ArcTo(_handle, x1.toDouble(), y1.toDouble(),
                        x2.toDouble(), y2.toDouble(), radiusX.toDouble());
    } else {
      _ArcTo2(_handle, x1.toDouble(), y1.toDouble(),
                         x2.toDouble(), y2.toDouble(),
                         radiusX.toDouble(), radiusY.toDouble(),
                         rotation.toDouble());
    }
  }

  void beginPath() => _BeginPath(_handle);

  void bezierCurveTo(num cp1x, num cp1y, num cp2x, num cp2y,
    num x, num y) =>
    _BezierCurveTo(_handle, cp1x.toDouble(), cp1y.toDouble(),
                              cp2x.toDouble(), cp2y.toDouble(),
                              x.toDouble(), y.toDouble());

  void clearRect(num x, num y, num w, num h) =>
    _ClearRect(_handle, x.toDouble(), y.toDouble(),
        w.toDouble(), h.toDouble());

  void clip() => _Clip(_handle);

  void closePath() => _ClosePath(_handle);

  ImageData createImageData(var imagedata_OR_sw, [num sh = null]) {
    if (sh == null) {
      throw new Exception('Unimplemented createImageData(imagedata)');
    } else {
      return _CreateImageDataFromDimensions(_handle, imagedata_OR_sw, sh);
    }
  }

  CanvasGradient createLinearGradient(num x0, num y0, num x1, num y1) {
    return new CanvasGradient.linear(x0, y0, x1, y1);
  }

  CanvasPattern createPattern(canvas_OR_image, String repetitionType) {
    throw new Exception('Unimplemented createPattern');
  }

  CanvasGradient createRadialGradient(num x0, num y0, num r0,
                                      num x1, num y1, num r1) {
    return new CanvasGradient.radial(x0, y0, r0, x1, y1, r1);
  }

  void _drawImage(element, num x1, num y1,
                [num w1, num h1, num x2, num y2, num w2, num h2]) {
    if (element == null || element.src == null || element.src.length == 0) {
      throw "drawImage called with no valid src";
    } else {
      _log("drawImage ${element.src}");
    }
    var w = (element.width == null) ? 0 : element.width;
    var h = (element.height == null) ?  0 : element.height;
    if (w1 == null) { // drawImage(element, dx, dy)
      _DrawImage(_handle, element.src, 0, 0, false, w, h,
                   x1.toInt(), y1.toInt(), false, 0, 0);
    } else if (x2 == null) {  // drawImage(element, dx, dy, dw, dh)
      _DrawImage(_handle, element.src, 0, 0, false, w, h,
                   x1.toInt(), y1.toInt(), true, w1.toInt(), h1.toInt());
    } else {  // drawImage(image, sx, sy, sw, sh, dx, dy, dw, dh)
      _DrawImage(_handle, element.src,
                   x1.toInt(), y1.toInt(), true, w1.toInt(), h1.toInt(),
                   x2.toInt(), y2.toInt(), true, w2.toInt(), h2.toInt());
    }
  }

  void drawImage(source, num destX, num destY) {
    _drawImage(source, destX, destY);
  }

  void drawImageScaled(source,
      num destX, num destY, num destWidth, num destHeight) {
    _drawImage(source, destX,  destY, destWidth, destHeight);
  }

  void drawImageScaledFromSource(source,
      num sourceX, num sourceY, num sourceWidth, num sourceHeight,
      num destX, num destY, num destWidth, num destHeight) {
    _drawImage(source, sourceX, sourceY, sourceWidth, sourceHeight,
        destX, destY, destWidth, destHeight);
  }

  void drawImageToRect(source, Rectangle dest, {Rectangle sourceRect}) {
    if (sourceRect == null) {
      _drawImage(source, dest.left, dest.top, dest.width, dest.height);
    } else {
      _drawImage(source,
         sourceRect.left, sourceRect.top, sourceRect.width, sourceRect.height,
         dest.left, dest.top, dest.width, dest.height);
    }
  }

  void fill() => _Fill(_handle);

  void fillRect(num x, num y, num w, num h) =>
    _FillRect(_handle, x.toDouble(), y.toDouble(),
                         w.toDouble(), h.toDouble());

  void fillText(String text, num x, num y, [num maxWidth = -1]) =>
    _FillText(_handle, text, x.toDouble(), y.toDouble(),
                                 maxWidth.toDouble());

  ImageData getImageData(num sx, num sy, num sw, num sh) =>
    _GetImageData(sx, sy, sw, sh);

  List<double> _lineDash = null;
  List<num> getLineDash() {
    if (_lineDash == null) return [];
    return _lineDash;  // TODO(gram): should we return a copy?
  }

  bool isPointInPath(num x, num y) {
    throw new Exception('Unimplemented isPointInPath');
  }

  void lineTo(num x, num y) {
    _LineTo(_handle, x.toDouble(), y.toDouble());
  }

  TextMetrics measureText(String text) {
    double w = _MeasureText(_handle, text);
    return new TextMetrics(w);
  }

  void moveTo(num x, num y) =>
    _MoveTo(_handle, x.toDouble(), y.toDouble());

  void putImageData(ImageData imagedata, num dx, num dy,
                   [num dirtyX, num dirtyY, num dirtyWidth, num dirtyHeight]) {
    if (dirtyX != null || dirtyY != null) {
      throw new Exception('Unimplemented putImageData');
    } else {
      _PutImageData(_handle, imagedata, dx, dy);
    }
  }

  void quadraticCurveTo(num cpx, num cpy, num x, num y) =>
    _QuadraticCurveTo(_handle, cpx.toDouble(), cpy.toDouble(),
                        x.toDouble(), y.toDouble());

  void rect(num x, num y, num w, num h) =>
    _Rect(_handle, x.toDouble(), y.toDouble(), w.toDouble(), h.toDouble());

  void restore() => _Restore(_handle);

  void rotate(num angle) => _Rotate(_handle, angle.toDouble());

  void save() => _Save(_handle);

  void scale(num x, num y) => _Scale(_handle, x.toDouble(), y.toDouble());

  void setFillColorHsl(int h, num s, num l, [num a = 1]) {
    throw new Exception('Unimplemented setFillColorHsl');
  }

  void setFillColorRgb(int r, int g, int b, [num a = 1]) {
    throw new Exception('Unimplemented setFillColorRgb');
  }

  void setLineDash(List<num> dash) {
    var valid = true;
    var new_dash;
    if (dash.length % 2 == 1) {
      new_dash = new List<double>(2 * dash.length);
      for (int i = 0; i < dash.length; i++) {
        double v = dash[i].toDouble();
        if (v < 0) {
          valid = false;
          break;
        }
        new_dash[i] = new_dash[i + dash.length] = v;
      }
    } else {
      new_dash = new List<double>(dash.length);
      for (int i = 0; i < dash.length; i++) {
        double v = dash[i].toDouble();
        if (v < 0) {
          valid = false;
          break;
        }
        new_dash[i] = v;
      }
    }
    if (valid) {
      _SetLineDash(_handle, _lineDash = new_dash);
    }
  }

  void setStrokeColorHsl(int h, num s, num l, [num a = 1]) {
    throw new Exception('Unimplemented setStrokeColorHsl');
  }

  void setStrokeColorRgb(int r, int g, int b, [num a = 1]) {
    throw new Exception('Unimplemented setStrokeColorRgb');
  }

  void setTransform(num m11, num m12, num m21, num m22, num dx, num dy) =>
    _SetTransform(_handle, m11.toDouble(), m12.toDouble(),
                           m21.toDouble(), m22.toDouble(),
                           dx.toDouble(), dy.toDouble());

  void stroke() => _Stroke(_handle);

  void strokeRect(num x, num y, num w, num h, [num lineWidth]) =>
    _StrokeRect(_handle, x.toDouble(), y.toDouble(),
        w.toDouble(), h.toDouble());

  void strokeText(String text, num x, num y, [num maxWidth = -1]) =>
    _StrokeText(_handle, text, x.toDouble(), y.toDouble(),
        maxWidth.toDouble());

  void transform(num m11, num m12, num m21, num m22, num dx, num dy) =>
    _Transform(_handle, m11.toDouble(), m12.toDouble(),
                        m21.toDouble(), m22.toDouble(),
                        dx.toDouble(), dy.toDouble());

  void translate(num x, num y) =>
    _Translate(_handle, x.toDouble(), y.toDouble());

  ImageData webkitGetImageDataHD(num sx, num sy, num sw, num sh) {
    throw new Exception('Unimplemented webkitGetImageDataHD');
  }

  void webkitPutImageDataHD(ImageData imagedata, num dx, num dy,
                           [num dirtyX, num dirtyY,
                            num dirtyWidth, num dirtyHeight]) {
    throw new Exception('Unimplemented webkitGetImageDataHD');
  }

  // TODO(vsm): Kill.
  noSuchMethod(invocation) {
      throw new Exception('Unimplemented/unknown ${invocation.memberName}');
  }
}

var sfx_extension = 'raw';
int _loadSample(String s) native "LoadSample";
int _playSample(String s) native "PlaySample";


_getFileAsString(String url) native "GetFileAsString";

class HttpRequest extends EventTarget {
  static const int LOADING = 3;
  static const int DONE = 4;

  int status = 0;
  int readyState = 0;

  String url;
  String responseText;

  static Future<String> getString(String url) => new Future<String>.value(_getFileAsString(url));

  void open(String method, String url) {
    this.url = url;
  }

  void send([data]) {
    responseText = _getFileAsString(url);
    status = 200;
    readyState = DONE;
    dispatchEvent(new Event("readystatechange"));
  }

  Stream<Event> get onReadyStateChange => new _EventStream(this, 'readystatechange');
}