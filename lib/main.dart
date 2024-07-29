import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:swift11/consts/colors.dart';
import 'package:swift11/consts/strings.dart';
import 'package:swift11/consts/styles.dart';

import 'views/splash_screen/splash_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDQCKwQ1kzBgzgfXjee09n1jTtbJjpFzwg",
          appId:"1:1031671167008:android:8857f3fe31f7c9c0dfa445",
          messagingSenderId: "1031671167008",
          projectId: "swift11-76317",
        storageBucket: "swift11-76317.appspot.com",
      ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: darkFontGrey,
          ),
        ),
        fontFamily: regular,
      ) ,
      home: const SplashScreen(),
    );
  }
}


