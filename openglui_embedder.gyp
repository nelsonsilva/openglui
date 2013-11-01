{
  # TODO(gram) : figure out how to make this be autoconfigured. 
  # I've tried a bunch of things with no success yet.
  'variables': {
    'dart': './third_party/dart',
    'dart_version_cc_file': '<(SHARED_INTERMEDIATE_DIR)/version.cc',
    'dart_snapshot_cc_file': '<(SHARED_INTERMEDIATE_DIR)/snapshot_gen.cc',
    'dart_resources_cc_file': '<(SHARED_INTERMEDIATE_DIR)/resources_gen.cc',
    'skia_build_flag' : '--release',
    'skia_libs_location_android': '-Lthird_party/skia/out/config/android-arm/Release/obj.target/gyp', 
    'skia_libs_location_desktop': '-Lthird_party/skia/out/Release',
    'gl_dart_file': 'openglui/common/gl.dart',
    'gl_resources_cc_file': '<(SHARED_INTERMEDIATE_DIR)/gl_resources_gen.cc',
  },
  'conditions': [
    ['OS=="android"',
      {
        'targets': [
          {
            # Dart shared library for Android.
            'target_name': 'android_embedder',
            'type': 'shared_library',
            'dependencies': [
              'skia-android',
              '<(dart)/runtime/dart-runtime.gyp:libdart_withcore',
              '<(dart)/runtime/dart-runtime.gyp:libdart_builtin',
              '<(dart)/runtime/dart-runtime.gyp:libdart_io',
              '<(dart)/runtime/dart-runtime.gyp:generate_snapshot_file#host',
              '<(dart)/runtime/dart-runtime.gyp:generate_resources_cc_file#host',
              'generate_gl_resources_cc_file#host',
            ],
            'include_dirs': [
              '.',
              '<(dart)/runtime',
              'third_party/android_tools/ndk/sources/android/native_app_glue',
              'third_party/skia/include',
              'third_party/skia/include/config',
              'third_party/skia/include/core',
              'third_party/skia/include/gpu',
              'third_party/skia/include/lazy',
              'third_party/skia/include/utils',
            ],
            'defines': [
              'DART_SHARED_LIB',
              '__ANDROID__',
              'SK_BUILD_FOR_ANDROID',
              'SK_BUILD_FOR_ANDROID_NDK',
            ],
            'sources': [
              '<(dart)/runtime/include/dart_api.h',
              '<(dart)/runtime/include/dart_debugger_api.h',
              '<(dart)/runtime/vm/dart_api_impl.cc',
              '<(dart)/runtime/vm/debugger_api_impl.cc',
              '<(dart)/runtime/vm/version.h',
              '<(dart)/runtime/bin/builtin.h',
              '<(dart)/runtime/bin/builtin_natives.cc',
              '<(dart)/runtime/bin/builtin_nolib.cc',
              '<(dart)/runtime/bin/vmservice.h',
              '<(dart)/runtime/bin/vmservice_impl.cc',
              '<(dart)/runtime/bin/vmservice_impl.h',
              '<(dart_version_cc_file)',
              '<(dart_snapshot_cc_file)',
              '<(dart_resources_cc_file)',
              '<(gl_resources_cc_file)',
              'third_party/android_tools/ndk/sources/android/native_app_glue/android_native_app_glue.h',
              'third_party/android_tools/ndk/sources/android/native_app_glue/android_native_app_glue.c',
              'third_party/skia/src/core/SkPaintOptionsAndroid.cpp',
              'openglui/android/android_graphics_handler.cc',
              'openglui/android/android_graphics_handler.h',
              'openglui/android/android_input_handler.h',
              'openglui/android/android_resource.h',
              'openglui/android/android_sound_handler.cc',
              'openglui/android/android_sound_handler.h',
              'openglui/android/eventloop.cc',
              'openglui/android/eventloop.h',
              'openglui/android/log.h',
              'openglui/android/main.cc',
              'openglui/android/support_android.cc',
              'openglui/common/canvas_context.cc',
              'openglui/common/canvas_context.h',
              'openglui/common/canvas_state.cc',
              'openglui/common/canvas_state.h',
              'openglui/common/context.h',
              'openglui/common/dart_host.cc',
              'openglui/common/dart_host.h',
              'openglui/common/events.h',
              'openglui/common/extension.cc',
              'openglui/common/extension.h',
              'openglui/common/graphics_handler.cc',
              'openglui/common/graphics_handler.h',
              'openglui/common/image_cache.cc',
              'openglui/common/image_cache.h',
              'openglui/common/input_handler.cc',
              'openglui/common/input_handler.h',
              'openglui/common/isized.h',
              'openglui/common/life_cycle_handler.h',
              'openglui/common/log.h',
              'openglui/common/opengl.h',
              'openglui/common/resource.h',
              'openglui/common/sample.h',
              'openglui/common/sound_handler.cc',
              'openglui/common/sound_handler.h',
              'openglui/common/support.h',
              'openglui/common/timer.cc',
              'openglui/common/timer.h',
              'openglui/common/types.h',
              'openglui/common/vm_glue.cc',
              'openglui/common/vm_glue.h'
            ],
            'link_settings': {
              'ldflags': [
                # The libraries we need should all be in
                # Lthird_party/skia/trunk/out/config/android-x86/Debug but
                # As I (gram) want to avoid patching the Skia gyp files to build
                # real libraries we'll just point to the location of the 'thin'
                # libraries used by the Skia build for now.
                # TODO(gram): We need to support debug vs release modes.
                '<(skia_libs_location_android)',
                '-z',
                'muldefs',
              ],
              'ldflags!': [
                '-Wl,--exclude-libs=ALL,-shared',
              ],
              'libraries': [
                '-Wl,--start-group',
                '-lexpat',
                '-lfreetype_static',
                '-lgif',
                '-ljpeg',
                '-lpng',
                '-lpicture_utils',
                '-lwebp_dec',
                '-lwebp_utils',
                '-lwebp_dsp',
                '-lwebp_enc',
                '-lskia_core',
                '-lskia_effects',
                '-lskia_images',
                '-lskia_opts',
                '-lskia_pdf',
                '-lskia_ports',
                '-lskia_sfnt',
                '-lskia_skgpu',
                '-lskia_utils',
                '-lskia_views',
                '-lskia_xml',
                '-lzlib',
                '-Wl,--end-group',
                '-llog',
                '-lc',
                '-lz',
                '-landroid',
                '-lEGL',
                '-lGLESv2',
                '-lOpenSLES',
                '-landroid',
              ],
            },
          },
          {
            'target_name': 'skia-android',
            'type': 'none',
            'actions': [
              {
                'action_name': 'build_skia',
                'inputs': [
                  'tools/build_skia.sh'
                ],
                'outputs': [
                  'dummy' # To force re-execution every time.
                ],
                # For now we drive the build from a shell
                # script, to get us going. Eventually we will
                # want to either fork Skia or incorporate its 
                # gclient settings into ours, and include its 
                # gyp files within ours, so that it gets built
                # as part of our tree.
                'action': [
                  'tools/build_skia.sh',
                  '--android',
                  '--arm',
                  '<(skia_build_flag)',
                  '..'
                ],
                'message': 'Building Skia.'
              }
            ]
          }
        ],
      },
    ],
    ['OS=="mac" or OS=="linux"',
      {
        'targets': [
          {
            'target_name': 'emulator_embedder',
            'type': 'static_library',
            'dependencies': [
              'skia-desktop',
              '<(dart)/runtime/dart-runtime.gyp:libdart_withcore',
              '<(dart)/runtime/dart-runtime.gyp:libdart_builtin',
              '<(dart)/runtime/dart-runtime.gyp:libdart_io',
              '<(dart)/runtime/dart-runtime.gyp:generate_snapshot_file#host',
              '<(dart)/runtime/dart-runtime.gyp:generate_resources_cc_file#host',
              'generate_gl_resources_cc_file#host',
            ],
            'include_dirs': [
              '.',
              '<(dart)/runtime',
              '/usr/X11/include',
              'third_party/skia/include',
              'third_party/skia/include/config',
              'third_party/skia/include/core',
              'third_party/skia/include/gpu',
              'third_party/skia/include/lazy',
              'third_party/skia/include/utils',
            ],
            'defines': [
              'DART_SHARED_LIB'
            ],
            'sources': [
              '<(dart)/runtime/include/dart_api.h',
              '<(dart)/runtime/include/dart_debugger_api.h',
              '<(dart)/runtime/vm/dart_api_impl.cc',
              '<(dart)/runtime/vm/debugger_api_impl.cc',
              '<(dart)/runtime/vm/version.h',
              '<(dart)/runtime/bin/builtin.h',
              '<(dart)/runtime/bin/builtin_natives.cc',
              '<(dart)/runtime/bin/builtin_nolib.cc',
              '<(dart)/runtime/bin/vmservice.h',
              '<(dart)/runtime/bin/vmservice_impl.cc',
              '<(dart)/runtime/bin/vmservice_impl.h',
              '<(dart_version_cc_file)',
              '<(dart_snapshot_cc_file)',
              '<(dart_resources_cc_file)',
              '<(gl_resources_cc_file)',
              'openglui/common/canvas_context.cc',
              'openglui/common/canvas_context.h',
              'openglui/common/canvas_state.cc',
              'openglui/common/canvas_state.h',
              'openglui/common/context.h',
              'openglui/common/dart_host.cc',
              'openglui/common/dart_host.h',
              'openglui/common/events.h',
              'openglui/common/extension.cc',
              'openglui/common/extension.h',
              'openglui/common/graphics_handler.cc',
              'openglui/common/graphics_handler.h',
              'openglui/common/image_cache.cc',
              'openglui/common/image_cache.h',
              'openglui/common/input_handler.cc',
              'openglui/common/input_handler.h',
              'openglui/common/isized.h',
              'openglui/common/life_cycle_handler.h',
              'openglui/common/log.h',
              'openglui/common/opengl.h',
              'openglui/common/resource.h',
              'openglui/common/sample.h',
              'openglui/common/sound_handler.cc',
              'openglui/common/sound_handler.h',
              'openglui/common/support.h',
              'openglui/common/support.h',
              'openglui/common/timer.cc',
              'openglui/common/timer.h',
              'openglui/common/types.h',
              'openglui/common/vm_glue.cc',
              'openglui/common/vm_glue.h',
              'openglui/emulator/emulator_embedder.cc',
              'openglui/emulator/emulator_embedder.h',
              'openglui/emulator/emulator_graphics_handler.cc',
              'openglui/emulator/emulator_graphics_handler.h',
              'openglui/emulator/emulator_resource.h'
            ],
            'link_settings': {
              'ldflags': [
                '-Wall',
                '<(skia_libs_location_desktop)',
                '-Wl,--start-group',
                '-lskia_core',
                '-lskia_effects',
                '-lskia_images',
                '-lskia_opts',
                '-lskia_opts_ssse3',
                '-lskia_ports',
                '-lskia_sfnt',
                '-lskia_skgpu',
                '-lskia_utils',
                '-Wl,--end-group',
                '-lfreetype',
              ],
              'libraries': [
                '-lGL',
                '-lglut',
                '-lGLU',
                '-lm'
              ],
            },
            'conditions': [
              ['OS=="mac"', {
                'xcode_settings' : {
                  'OTHER_LDFLAGS': [ '-framework OpenGL', '-framework GLUT', '-L /usr/X11/lib' ]
                },
              }],
            ]
          },
          {
            'target_name': 'skia-desktop',
            'type': 'none',
            'actions': [
              {
                'action_name': 'build_skia',
                'inputs': [
                  'tools/build_skia.sh'
                ],
                'outputs': [
                  'dummy' # To force re-execution every time.
                ],
                'action': [
                  'tools/build_skia.sh',
                  '<(skia_build_flag)',
                  '..'
                ],
                'message': 'Building Skia.'
              }
            ]
          }
        ],
      },
    ],
  ],
  'targets': [
    {
      'target_name': 'generate_gl_resources_cc_file',
      'type': 'none',
      'toolsets':['host'],
      'sources': [
        '<(gl_dart_file)',
      ],
      'actions': [
        {
          'action_name': 'generate_gl_resources_cc_file',
          'inputs': [
            'tools/create_resources.py',
            '<@(_sources)',
          ],
          'outputs': [
            '<(gl_resources_cc_file)',
          ],
          'action': [
            'python',
            'tools/create_resources.py',
            '--output', '<(gl_resources_cc_file)',
            '--root_prefix', 'openglui/common/',
            '<@(_sources)'
          ],
          'message': 'Generating ''<(gl_resources_cc_file)'' file.'
        },
      ]
    },
  ],
}

