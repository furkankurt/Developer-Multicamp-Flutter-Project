import 'package:firebase_core/firebase_core.dart';
import 'package:fk_haber/src/config/constants/app_constants.dart';
import 'package:fk_haber/src/config/constants/route_constants.dart';
import 'package:fk_haber/src/config/navigation/navigation_service.dart';
import 'package:fk_haber/src/config/navigation/navigator_route_service.dart';
import 'package:fk_haber/src/provider/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  startApp().then((_) {
    runApp(MyApp());
  });
}

Future startApp() async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        initialRoute: k_ROUTE_SPLASH,
        onGenerateRoute: NavigationRouteManager.onRouteGenerate,
        onUnknownRoute: NavigationRouteManager.onUnknownRoute,
        navigatorKey: NavigationService.instance.navigatorKey,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('tr'),
        ],
        title: k_APP_NAME,
      ),
    );
  }
}
