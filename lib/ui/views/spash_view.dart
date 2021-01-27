import 'package:flutter/material.dart';
import 'package:Expenses_Tracker_App/ui/shared/app_colors.dart';
import 'package:Expenses_Tracker_App/ui/views/home_view.dart';
import 'package:splashscreen/splashscreen.dart';

class SpashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(child: buildSpashScreen()));
  }

  buildSpashScreen() {
    return SplashScreen(
        seconds: 2,
        navigateAfterSeconds: HomeView(),
        title: new Text(
          'Quản Lý Chi Tiêu',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
        image: new Image.asset(
          'assets/icons/spash.png',
          height: 150,
          width: 150,
        ),
        backgroundColor: backgroundColor,
        loadingText: Text(
          'Đơn giản - Tiện ích',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        photoSize: 100.0,
        loaderColor: Colors.black);
  }
}
