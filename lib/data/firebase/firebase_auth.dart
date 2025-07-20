
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/core/utils/app_shared_preferences.dart';
import 'package:flutter_application_1/data/firebase/firebase_database.dart';
import 'package:flutter_application_1/data/model/user_model.dart';

abstract class FirebaseAuthUser {
  static Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
     final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);  
        await  AppSharedPreferences.saveData("Id", user.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  static Future<void> register({
    required String email,
    required String password,
    required String userName,
  }) async {
    try {
      final user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseUserDatabase.createUser(UserModel(
        id: user.user!.uid,
        email: email,
        password: password,
        userName: userName,
      ));
          
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception("An unknow error occurred: $e ");
    }
  }
}
