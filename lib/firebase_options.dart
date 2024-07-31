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
    apiKey: 'AIzaSyBOOA6MjaMLqTby1Pa-vixRYPpRdKzzWpw',
    appId: '1:1095217040138:web:23ff50db8615f3a24b48f3',
    messagingSenderId: '1095217040138',
    projectId: 'alumni-hub-ft-uh',
    authDomain: 'alumni-hub-ft-uh.firebaseapp.com',
    storageBucket: 'alumni-hub-ft-uh.appspot.com',
    measurementId: 'G-625L3DWWGV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBrOMkYi8odag4hoe-f5dX89h_upw1POUo',
    appId: '1:1095217040138:android:f1a96384c45d73f04b48f3',
    messagingSenderId: '1095217040138',
    projectId: 'alumni-hub-ft-uh',
    storageBucket: 'alumni-hub-ft-uh.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAAk_xttmmbSaComqu9-fixYCioOYNNVMc',
    appId: '1:1095217040138:ios:d13f33ce34b1534a4b48f3',
    messagingSenderId: '1095217040138',
    projectId: 'alumni-hub-ft-uh',
    storageBucket: 'alumni-hub-ft-uh.appspot.com',
    iosBundleId: 'com.example.alumniHubFtUh',
  );
}
