
import 'package:Expenses_Tracker_App/locator.dart';
import 'package:flutter/material.dart';
import 'package:Expenses_Tracker_App/ui/Router.dart';
import 'ui/shared/app_colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('vi')
      ],
      title: 'Quản Lý Chi Tiêu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: backgroundColor,
        accentColor: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: router.generateRoute,
    );
  }
}
