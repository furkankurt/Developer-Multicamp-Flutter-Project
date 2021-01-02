import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static Future<User> signUpUser({String email, String password}) async {
    UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User signedInUser = authResult.user;
    if (signedInUser != null) {
      return signedInUser;
    } else {
      return null;
    }
  }

  static Future logout() async {
    await _auth.signOut();
  }

  static Future<User> login({String email, String password}) async {
    UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    User signedInUser = authResult.user;
    if (signedInUser != null) {
      return signedInUser;
    } else {
      return null;
    }
  }

  static Future<User> getUser() async {
    try {
      return _auth.currentUser;
    } catch (e) {
      print('AuthService getUser Error: $e');
      return null;
    }
  }

  static void changeEmail(String email) async {
    try {
      if (_auth.currentUser != null) {
        await _auth.currentUser.updateEmail(email);
      }
    } catch (e) {
      print(e);
    }
  }

  static void updatePassword(
      BuildContext context, String email, String password, String pass) async {
    await login(email: email, password: password);
    final user = _auth.currentUser;
    user.updatePassword(pass);
  }

  static Future forgotPassword({String email}) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }

  static Future passwordReset({String code, String newPassword}) async {
    return await _auth.confirmPasswordReset(
        code: code, newPassword: newPassword);
  }

  static Future<ActionCodeInfo> checkPasswordResetCode({@required code}) async {
    return await _auth.checkActionCode(code);
  }
}
