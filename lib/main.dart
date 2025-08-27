import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/views/splash_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // ✅ Use GetMaterialApp
      debugShowCheckedModeBanner: false,
      title: 'Smart Care Doc',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        fontFamily: 'Poppins',
      ),
      home: SplashScreen(), // ✅ Set SplashScreen as home
    );
  }
}
