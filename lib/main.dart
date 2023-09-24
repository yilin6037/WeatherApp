import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/view/login/login_page.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(
    defaultTransition: Transition.noTransition,
    transitionDuration: Duration.zero,
    home: LoginPage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(),
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.system,
  ));
}
