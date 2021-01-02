import 'package:firebase_auth/firebase_auth.dart';
import 'package:fk_haber/src/service/auth_service.dart';
import 'package:fk_haber/src/utils/handlers/auth_exception_handler.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    getUser();
  }

  AuthResultStatus authStatus;

  List<String> signInMethods = List<String>();

  bool isLoading = false;

  User currentUser;

  setUser(User _user) {
    currentUser = _user;
    notifyListeners();
  }

  getUser() async {
    try {
      changeState(true);
      currentUser = await AuthService.getUser();
      return currentUser;
    } catch (e) {
      print('AuthStore getUser Error: $e');
      return null;
    } finally {
      changeState(false);
    }
  }

  changeState(bool _isLoading) {
    isLoading = _isLoading;
    notifyListeners();
  }

  Future<AuthResultStatus> logIn(
      {@required String email, @required String password}) async {
    changeState(true);
    authStatus = null;
    try {
      var user = await AuthService.login(email: email, password: password);
      if (user != null) {
        authStatus = AuthResultStatus.successful;
        currentUser = user;
        changeState(false);
      } else {
        changeState(false);
      }
    } on FirebaseAuthException catch (e) {
      print('Auth Store Login Error: $e');
      authStatus = AuthExceptionHandler.handleException(e);
      changeState(false);
    }
    return authStatus;
  }

  Future<AuthResultStatus> register(
      {@required String email, @required String password}) async {
    try {
      authStatus = null;
      changeState(true);
      var user = await AuthService.signUpUser(email: email, password: password);
      if (user != null) {
        authStatus = AuthResultStatus.successful;
        currentUser = user;
        changeState(false);
      } else {
        print('AuthStore signUp user null');
        changeState(false);
      }
    } on FirebaseAuthException catch (e) {
      print('Auth Store signUp Error: $e');
      authStatus = AuthExceptionHandler.handleException(e);
      changeState(false);
    }
    return authStatus;
  }

  logOut() async {
    currentUser = null;
    await AuthService.logout();
    notifyListeners();
  }

  Future<AuthResultStatus> forgotPassword({@required String email}) async {
    changeState(true);
    try {
      authStatus = null;
      await AuthService.forgotPassword(email: email).then((value) {
        authStatus = AuthResultStatus.successful;
      });
    } on FirebaseAuthException catch (e) {
      print("Auth Store Forgot Password Error: $email");
      authStatus = AuthExceptionHandler.handleException(e);
      changeState(false);
    } finally {
      changeState(false);
    }
    return authStatus;
  }
}
