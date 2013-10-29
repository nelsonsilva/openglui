{
  'variables': {
    'library': 'static_library',
    'component': 'static_library',
    'target_arch%': 'ia32',
    # Flag that tells us whether to build native support for dart:io.
    'dart_io_support%': 1
  },
  'conditions': [
    [ 'OS=="linux"', {
      'target_defaults': {
        'ldflags': [ '-pthread', ],
      },
    }],
  ],

  'includes': [
    'configurations.gypi',
  ],
}