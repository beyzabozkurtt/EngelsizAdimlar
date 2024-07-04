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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBBo7ygvS2UESfnEEDfXjlSjDRjMBf7SvI',
    appId: '1:236797306841:web:394b7b6dc86f9a458a1bc8',
    messagingSenderId: '236797306841',
    projectId: 'engelsiz-adim',
    authDomain: 'engelsiz-adim.firebaseapp.com',
    databaseURL: 'https://engelsiz-adim-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'engelsiz-adim.appspot.com',
    measurementId: 'G-E1067EJTF5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEjyvFnairHk9E2PxoxmHS24JMlzFGCeo',
    appId: '1:236797306841:android:8c756758fbc055a58a1bc8',
    messagingSenderId: '236797306841',
    projectId: 'engelsiz-adim',
    databaseURL: 'https://engelsiz-adim-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'engelsiz-adim.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAWqbPfjSOYyoQNovOoewUVNl73tRaNLRs',
    appId: '1:236797306841:ios:f78f62dda307f7418a1bc8',
    messagingSenderId: '236797306841',
    projectId: 'engelsiz-adim',
    databaseURL: 'https://engelsiz-adim-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'engelsiz-adim.appspot.com',
    iosBundleId: 'com.example.mobilapp2',
  );
}