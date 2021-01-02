import 'package:fk_haber/src/config/theme/app_colors.dart';
import 'package:fk_haber/src/provider/auth_provider.dart';
import 'package:fk_haber/src/ui/auth/login_page.dart';
import 'package:fk_haber/src/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  AuthProvider _authProvider;

  @override
  void initState() {
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, model, child) {
        if (!_authProvider.isLoading) {
          if (_authProvider.currentUser != null) {
            return HomePage(context: context);
          } else {
            return LoginPage(context: context);
          }
        } else {
          return Scaffold(
            backgroundColor: AppColors.mainColor,
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          );
        }
      },
    );
  }
}
