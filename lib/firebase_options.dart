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
    apiKey: 'AIzaSyB2vpRrVHzsTlccxNLVK10byY4Hi5eMjbI',
    appId: '1:685821457506:web:01b29812f26c7fa42d0d3b',
    messagingSenderId: '685821457506',
    projectId: 'myapp-aj7',
    authDomain: 'myapp-aj7.firebaseapp.com',
    databaseURL: 'https://myapp-aj7-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'myapp-aj7.appspot.com',
    measurementId: 'G-Y8WEKZTTYH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDVFd7yUtCjDoWz9hw6I4eFTdlLfjt_dFc',
    appId: '1:685821457506:android:142e56a11b003e4d2d0d3b',
    messagingSenderId: '685821457506',
    projectId: 'myapp-aj7',
    databaseURL: 'https://myapp-aj7-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'myapp-aj7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCVKHS64vn9Og09meKjTVHNJGqv9Lr8Zpw',
    appId: '1:685821457506:ios:47439073476e569a2d0d3b',
    messagingSenderId: '685821457506',
    projectId: 'myapp-aj7',
    databaseURL: 'https://myapp-aj7-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'myapp-aj7.appspot.com',
    iosBundleId: 'com.example.sendApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCVKHS64vn9Og09meKjTVHNJGqv9Lr8Zpw',
    appId: '1:685821457506:ios:47439073476e569a2d0d3b',
    messagingSenderId: '685821457506',
    projectId: 'myapp-aj7',
    databaseURL: 'https://myapp-aj7-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'myapp-aj7.appspot.com',
    iosBundleId: 'com.example.sendApp',
  );
}