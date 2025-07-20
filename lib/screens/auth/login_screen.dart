import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/app_dialog.dart';
import 'package:flutter_application_1/core/utils/validator_functions.dart';
import 'package:flutter_application_1/data/firebase/firebase_auth.dart';
import 'package:flutter_application_1/screens/auth/register_screen.dart';
import 'package:flutter_application_1/screens/auth/widget/material_button_widget.dart';
import 'package:flutter_application_1/screens/auth/widget/text_form_field_widget.dart';
import 'package:flutter_application_1/screens/auth/widget/text_rich_widget.dart';
import 'package:flutter_application_1/screens/home/widget/home_screen.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static String routeName = 'LoginScreen';
  final TextEditingController email = TextEditingController();
  
  final TextEditingController password = TextEditingController();
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
              SizedBox(height: 122),
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 53),
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              TextFormFieldWidget(
                hintText: "enter your email",
                controller: email,
                validator: Validator.validateEmail,
              ),
              SizedBox(height: 53),
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              TextFormFieldWidget(
                hintText: "enter your password",
                controller: password,
                validator: Validator.validatePassword,
              ),
              SizedBox(height: 71),
              MaterialButtonWidget(
                title: "Login",
                onPressed: ()async {
                  if (formKey.currentState!.validate()) {
                    AppDialog.showDialogLoading(context);
                   await FirebaseAuthUser.login(
                      email: email.text,
                      password: password.text,
                      
                    ).then((value){
                      email.clear();
                      password.clear();
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                    }).catchError((Error){
                      Navigator.of(context).pop();
                      AppDialog.showDialogError(context, 'error');
                    });
                  }
                  
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: TextRichWidget(
        textTitle: "Don’t have an account?",
        subTitle: "Register",
        onTap: () {
          Navigator.of(context).pushNamed(RegisterScreen.routeName);
        },
      ),
    );
  }
}
