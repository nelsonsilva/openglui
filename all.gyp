{
  'targets': [
    {
      'target_name': 'openglui_samples',
      'type': 'none',
      'conditions': [
        ['OS=="android"', {
            'dependencies': [
              'samples/web/web.gyp:assets',
              'samples/android-webgl-raytrace/android.gyp:android_app',
              'samples/android-canvas-tests/android.gyp:android_app',
              'samples/android-blasteroids/android.gyp:android_app',
            ],
          },
        ],
      ],
      'dependencies': [
              'samples/web/web.gyp:assets',
              'samples/emulator/emulator.gyp:mobile_emulator_app',
            ],
    },
  ],
}
