import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constant/assets_constant.dart';

class EmptyScreen extends StatelessWidget {
  static const String routeName = "/empty";

  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsConstant.empty),
            const SizedBox(height: 90),
            const Text(
              "What do you want to do today?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Color(0xff24252C),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Tap + to add your tasks",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff24252C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
