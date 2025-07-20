import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constant/assets_constant.dart';
import 'package:flutter_application_1/screens/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = "SplashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5F33E1),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            ElasticIn(
              duration: const Duration(milliseconds: 1000),
              child: Image.asset(AssetsConstant.taskIcon),
            ),

            
            SlideInUp(
              delay: const Duration(milliseconds: 900),
              duration: const Duration(milliseconds: 800),
              child: Image.asset(AssetsConstant.yIcon),
            ),
          ],
        ),
      ),
    );
  }
}
