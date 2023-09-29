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
    apiKey: 'AIzaSyCxsQVyTmywpMwF-gsJUAkhutcsh1XPOrU',
    appId: '1:136755774430:web:577a310671e45ef1fc134f',
    messagingSenderId: '136755774430',
    projectId: 'newsapp-affb7',
    authDomain: 'newsapp-affb7.firebaseapp.com',
    storageBucket: 'newsapp-affb7.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUwzWtaQFNWOEj6HtMFbwqkKS2NEcv_LI',
    appId: '1:136755774430:android:36492b570a6934bbfc134f',
    messagingSenderId: '136755774430',
    projectId: 'newsapp-affb7',
    storageBucket: 'newsapp-affb7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7gD8P4fAf3GmibDtkgayLA9irSrT1V3I',
    appId: '1:136755774430:ios:aa645b5f7bb288c1fc134f',
    messagingSenderId: '136755774430',
    projectId: 'newsapp-affb7',
    storageBucket: 'newsapp-affb7.appspot.com',
    iosBundleId: 'com.example.newsApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA7gD8P4fAf3GmibDtkgayLA9irSrT1V3I',
    appId: '1:136755774430:ios:174fc5dc67953210fc134f',
    messagingSenderId: '136755774430',
    projectId: 'newsapp-affb7',
    storageBucket: 'newsapp-affb7.appspot.com',
    iosBundleId: 'com.example.newsApp.RunnerTests',
  );
}
