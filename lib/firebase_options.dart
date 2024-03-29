// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAIwxg1nOViSZItBi-z5mNPQOskzORV__4',
    appId: '1:279222388039:web:d657d069ed7420a747b862',
    messagingSenderId: '279222388039',
    projectId: 'tests-f78e2',
    authDomain: 'tests-f78e2.firebaseapp.com',
    storageBucket: 'tests-f78e2.appspot.com',
    measurementId: 'G-PNG8E1DHL8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTnOgwXmQLxYrSWlpJKU5kChS2wT3UoBQ',
    appId: '1:279222388039:android:b9f2680680e3ecd747b862',
    messagingSenderId: '279222388039',
    projectId: 'tests-f78e2',
    storageBucket: 'tests-f78e2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBgKi6MTFlbqxBOdw1h1TfCcfPZEpAWoP8',
    appId: '1:279222388039:ios:3980b9a0d75ff5ae47b862',
    messagingSenderId: '279222388039',
    projectId: 'tests-f78e2',
    storageBucket: 'tests-f78e2.appspot.com',
    iosClientId: '279222388039-60lqvu61brca89ggsm99bj3b1c1t2sot.apps.googleusercontent.com',
    iosBundleId: 'com.example.tests',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBgKi6MTFlbqxBOdw1h1TfCcfPZEpAWoP8',
    appId: '1:279222388039:ios:3980b9a0d75ff5ae47b862',
    messagingSenderId: '279222388039',
    projectId: 'tests-f78e2',
    storageBucket: 'tests-f78e2.appspot.com',
    iosClientId: '279222388039-60lqvu61brca89ggsm99bj3b1c1t2sot.apps.googleusercontent.com',
    iosBundleId: 'com.example.tests',
  );
}
