import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/app_dialog.dart';
import 'package:flutter_application_1/core/utils/validator_functions.dart';
import 'package:flutter_application_1/data/firebase/firebase_auth.dart';
import 'package:flutter_application_1/screens/auth/login_screen.dart';
import 'package:flutter_application_1/screens/auth/widget/material_button_widget.dart';
import 'package:flutter_application_1/screens/auth/widget/text_form_field_widget.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  static String routeName = 'RegisterScreen';

  var email = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var userName = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Text(
                "Register",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Username',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              TextFormFieldWidget(
                hintText: "Enter your username",
                controller: userName,
                validator: Validator.validateUserName,
              ),
              SizedBox(height: 30),
              Text(
                'Email',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              TextFormFieldWidget(
                hintText: "Enter your email",
                controller: email,
                validator: Validator.validateEmail,
              ),
              SizedBox(height: 30),
              Text(
                'Password',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              TextFormFieldWidget(
                hintText: "Enter your password",
                controller: password,
                validator: Validator.validatePassword,
              ),
              SizedBox(height: 30),
              Text(
                'Confirm Password',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              TextFormFieldWidget(
                hintText: "Confirm your password",
                controller: confirmPassword,
                validator: (text) =>
                    Validator.validateConfirmPassword(text, password.text),
              ),
              SizedBox(height: 40),
              MaterialButtonWidget(
                title: "Register",
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    AppDialog.showDialogLoading(context);
                    await FirebaseAuthUser.register(
                      email: email.text,
                      password: password.text,
                      userName: userName.text,
                    ).then((_) {
                      password.clear();
                      confirmPassword.clear();
                      email.clear();
                      userName.clear();
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    }).catchError((error) {
                      Navigator.of(context).pop();
                      AppDialog.showDialogError(context, error);
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
