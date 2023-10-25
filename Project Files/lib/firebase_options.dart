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
    apiKey: 'AIzaSyB6-C3LxhFr55ZRL4TxZZXZ4YS867hRA70',
    appId: '1:481442611957:web:b9a1aa65c97828ef313bbc',
    messagingSenderId: '481442611957',
    projectId: 'questionapp-4e473',
    authDomain: 'questionapp-4e473.firebaseapp.com',
    storageBucket: 'questionapp-4e473.appspot.com',
    measurementId: 'G-4ERKTZKBKP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBVUqGnswukE97kTesRx_n9PZ_KXywZh1k',
    appId: '1:481442611957:android:c06e541fbd61414e313bbc',
    messagingSenderId: '481442611957',
    projectId: 'questionapp-4e473',
    storageBucket: 'questionapp-4e473.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCfQK4R3zU_oNp4uxajPHtqQSaD59sxgo0',
    appId: '1:481442611957:ios:cc8e7f0bfe4d2146313bbc',
    messagingSenderId: '481442611957',
    projectId: 'questionapp-4e473',
    storageBucket: 'questionapp-4e473.appspot.com',
    iosClientId: '481442611957-o398dr4sdt6qangc1rocv4cdhdpasl7b.apps.googleusercontent.com',
    iosBundleId: 'com.example.questionsApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCfQK4R3zU_oNp4uxajPHtqQSaD59sxgo0',
    appId: '1:481442611957:ios:a50be33843011d29313bbc',
    messagingSenderId: '481442611957',
    projectId: 'questionapp-4e473',
    storageBucket: 'questionapp-4e473.appspot.com',
    iosClientId: '481442611957-b0gtpstulv2rap5hibejsu08ulunl68t.apps.googleusercontent.com',
    iosBundleId: 'com.example.questionsApp.RunnerTests',
  );
}