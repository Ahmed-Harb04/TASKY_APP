import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/app_shared_preferences.dart';
import 'package:flutter_application_1/screens/Onboarding_screen.dart';
import 'package:flutter_application_1/screens/auth/login_screen.dart';
import 'package:flutter_application_1/screens/auth/register_screen.dart';
import 'package:flutter_application_1/screens/home/widget/empty_screen.dart';
import 'package:flutter_application_1/screens/home/widget/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screens/home/widget/updata_task_screen.dart';
import 'package:flutter_application_1/screens/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.initSharedPref();
  String routeName = LoginScreen.routeName;
  AppSharedPreferences.getData("Id").then((value){
    if (value!= null){
      log("User ID: $value");
      routeName=HomeScreen.routeName;
    
    }

  });
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(TaskyApp(routeName: routeName,));
  
}

class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key, required this.routeName});
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:SplashScreen.routeName,
      routes: {
        
        SplashScreen.routeName: (context) => SplashScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        EmptyScreen.routeName: (context) => EmptyScreen(),
        HomeScreen.routeName:(context)=>HomeScreen(),
        OnboardingScreen.routeName:(context)=>OnboardingScreen(),
        
      
      },
    );
  }
}