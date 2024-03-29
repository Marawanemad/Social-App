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
    apiKey: 'AIzaSyDicyF-ob6mdUkTB1_RMk3d2Ii__MPRWVc',
    appId: '1:851085194177:web:8a9500d4fcacedd1097540',
    messagingSenderId: '851085194177',
    projectId: 'socialapp-ef07d',
    authDomain: 'socialapp-ef07d.firebaseapp.com',
    storageBucket: 'socialapp-ef07d.appspot.com',
    measurementId: 'G-7EP9W3Q4S3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyConFVmiL3xzdOlActRFtoLCP6675ymKZ8',
    appId: '1:851085194177:android:c58a3dd76653fe4c097540',
    messagingSenderId: '851085194177',
    projectId: 'socialapp-ef07d',
    storageBucket: 'socialapp-ef07d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCILmg-D8XRa3ZZLsmhRr1B6grz1H7-qyo',
    appId: '1:851085194177:ios:feb7478a189faecf097540',
    messagingSenderId: '851085194177',
    projectId: 'socialapp-ef07d',
    storageBucket: 'socialapp-ef07d.appspot.com',
    iosBundleId: 'com.example.socialapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCILmg-D8XRa3ZZLsmhRr1B6grz1H7-qyo',
    appId: '1:851085194177:ios:84969d8c4eb54a53097540',
    messagingSenderId: '851085194177',
    projectId: 'socialapp-ef07d',
    storageBucket: 'socialapp-ef07d.appspot.com',
    iosBundleId: 'com.example.socialapp.RunnerTests',
  );
}
