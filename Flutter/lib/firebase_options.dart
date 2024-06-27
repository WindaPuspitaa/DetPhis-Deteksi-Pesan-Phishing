// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCIM0XGTGY6gnQkQg588YVKlGZEtnWWr48',
    appId: '1:984428567909:web:d7ae022b44bd4286c4958c',
    messagingSenderId: '984428567909',
    projectId: 'fireflutterdb',
    authDomain: 'fireflutterdb.firebaseapp.com',
    storageBucket: 'fireflutterdb.appspot.com',
    measurementId: 'G-61DVX8N6JY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA81XrMcvy3Nado40rT7xbYvlVFoFyhsto',
    appId: '1:984428567909:android:e9f9b90217ded9b3c4958c',
    messagingSenderId: '984428567909',
    projectId: 'fireflutterdb',
    storageBucket: 'fireflutterdb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD5sc3BlRc9tGPF5T8PNCQx67s8ozukFc4',
    appId: '1:984428567909:ios:201a203454139e54c4958c',
    messagingSenderId: '984428567909',
    projectId: 'fireflutterdb',
    storageBucket: 'fireflutterdb.appspot.com',
    iosBundleId: 'com.example.flutterApplicationTest1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD5sc3BlRc9tGPF5T8PNCQx67s8ozukFc4',
    appId: '1:984428567909:ios:201a203454139e54c4958c',
    messagingSenderId: '984428567909',
    projectId: 'fireflutterdb',
    storageBucket: 'fireflutterdb.appspot.com',
    iosBundleId: 'com.example.flutterApplicationTest1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCIM0XGTGY6gnQkQg588YVKlGZEtnWWr48',
    appId: '1:984428567909:web:d0583d9071a55d2ac4958c',
    messagingSenderId: '984428567909',
    projectId: 'fireflutterdb',
    authDomain: 'fireflutterdb.firebaseapp.com',
    storageBucket: 'fireflutterdb.appspot.com',
    measurementId: 'G-0J0235RJYC',
  );
}