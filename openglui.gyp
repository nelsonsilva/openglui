{
  'variables': {
    'target_arch%': 'arm',
    'dart': './third_party/dart',
  },
  'conditions': [
    ['OS=="mac" or OS=="linux"',
      {
        'targets': [
        {
          'target_name': 'mobile_emulator',
          'type': 'none',
          'dependencies': [
            'samples/web/web.gyp:assets',
            'samples/emulator/emulator.gyp:mobile_emulator_app',
          ],
        },
        ],
      }
    ],
    ['OS=="android"', {

      'targets': [
        {
          'target_name': 'samples',
          'type': 'none',
           'dependencies': [
            'samples/web/web.gyp:assets',
            'samples/android-webgl-raytrace/android.gyp:android_app',
            'samples/android-canvas-tests/android.gyp:android_app',
            'samples/android-blasteroids/android.gyp:android_app',
          ],

        },

        #{
        #  'target_name': 'libdart_shared',
        #  'type': 'shared_library',
        #  'dependencies': [
        #    '<(dart)/runtime/dart-runtime.gyp:libdart',
        #  ],
        #  'defines': [
        #          'DART_SHARED_LIB',
        #  ],
        #  'link_settings': {
        #    'libraries': ['-llog'],
        #    'ldflags': [
        #      '-z',
        #      'muldefs',
        #    ],
        #    'ldflags!': [
        #      '-Wl,--exclude-libs=ALL,-shared',
        #    ],
        #  }
        #},
  ],
  }]
  ]
}
