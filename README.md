#Dart OpenGL UI

```
gclient config https://github.com/nelsonsilva/openglui.git
gclient sync
cd openglui
tools/build.py -m release -a arm --os=android samples
tools/build.py -m release -a x64 mobile_emulator
```

### Skia

Need to patch third_party/skia/src/gpu/gl/android/GrGLCreateNativeInterface_android.cpp

```
#define glGenVertexArraysOES (PFNGLGENVERTEXARRAYSOESPROC)eglGetProcAddress("glGenVertexArraysOES");
#define glBindVertexArrayOES (PFNGLBINDVERTEXARRAYOESPROC)eglGetProcAddress ( "glBindVertexArrayOES" );
#define glDeleteVertexArraysOES (PFNGLDELETEVERTEXARRAYSOESPROC)eglGetProcAddress ( "glDeleteVertexArraysOES" );
#define glFramebufferTexture2DMultisampleIMG (PFNGLFRAMEBUFFERTEXTURE2DMULTISAMPLEIMG)eglGetProcAddress ( "glFramebufferTexture2DMultisampleIMG" );
#define glRenderbufferStorageMultisampleIMG (PFNGLRENDERBUFFERSTORAGEMULTISAMPLEIMG)eglGetProcAddress ( "glRenderbufferStorageMultisampleIMG" );
#define glDiscardFramebufferEXT (PFNGLDISCARDFRAMEBUFFEREXTPROC)eglGetProcAddress( "glDiscardFramebufferEXT" );
```
