// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart

//
//  await Firebase.initializeApp(
//    options: DefaultFirebaseOptions.currentPlatform,
//  );

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
    apiKey: 'AIzaSyCDdfWEmh3bPgupdFyYZ4W8Temr-9lsA2c',
    appId: '1:496028515596:web:0b6e9a54a4b9e5b0515d29',
    messagingSenderId: '496028515596',
    projectId: 'coffee-shop-app-7a576',
    authDomain: 'coffee-shop-app-7a576.firebaseapp.com',
    storageBucket: 'coffee-shop-app-7a576.firebasestorage.app',
    measurementId: 'G-LSLLWW4T7L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCI7I-nWGOpX0td4p0qHq_S1mmDWr7x_Hw',
    appId: '1:496028515596:android:d93273a0961acb28515d29',
    messagingSenderId: '496028515596',
    projectId: 'coffee-shop-app-7a576',
    storageBucket: 'coffee-shop-app-7a576.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBaBQg_ebD3bCGuhR78neF4NAHWH_a1nbg',
    appId: '1:496028515596:ios:67d6a603a6d1cb68515d29',
    messagingSenderId: '496028515596',
    projectId: 'coffee-shop-app-7a576',
    storageBucket: 'coffee-shop-app-7a576.firebasestorage.app',
    iosBundleId: 'com.example.coffeeShopApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBaBQg_ebD3bCGuhR78neF4NAHWH_a1nbg',
    appId: '1:496028515596:ios:67d6a603a6d1cb68515d29',
    messagingSenderId: '496028515596',
    projectId: 'coffee-shop-app-7a576',
    storageBucket: 'coffee-shop-app-7a576.firebasestorage.app',
    iosBundleId: 'com.example.coffeeShopApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCDdfWEmh3bPgupdFyYZ4W8Temr-9lsA2c',
    appId: '1:496028515596:web:febd8f2af94eb55a515d29',
    messagingSenderId: '496028515596',
    projectId: 'coffee-shop-app-7a576',
    authDomain: 'coffee-shop-app-7a576.firebaseapp.com',
    storageBucket: 'coffee-shop-app-7a576.firebasestorage.app',
    measurementId: 'G-0VS5YR5YL4',
  );
}
