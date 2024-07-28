import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:social_clone/pages/Auth/view/login_page.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:social_clone/pages/homepage/views/homepage.dart';
import 'package:social_clone/responsive/mobilescreen.dart';
import 'package:social_clone/responsive/responsive.dart';
import 'package:social_clone/responsive/webscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAZHDJ7hQsNVyFKgC7pVPoxZgEuEYcukmQ",
      appId: "1:257776654480:android:5d078165b330ef17ee6015",
      messagingSenderId: "257776654480",
      projectId: "instaclone-f42ee",
      storageBucket: "instaclone-f42ee.appspot.com",
    ),
  );
  // await FirebaseAppCheck.instance.activate(
  //   webProvider: ReCaptchaV3Provider(
  //       'your-recaptcha-v3-site-key'), // Replace with your actual reCAPTCHA site key
  //   androidProvider:
  //       AndroidProvider.playIntegrity, // Use Play Integrity for production
  //   appleProvider: AppleProvider.appAttest,
  // );
  FirebaseStorage.instanceFor(bucket: "instaclone-f42ee.appspot.com");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // Checking if the snapshot has any data or not
            if (snapshot.hasData) {
              // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
              return const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              );
              ;
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }

          // means connection to future hasnt been made yet
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return const LoginPage();
        },
      ),
    );
  }
}