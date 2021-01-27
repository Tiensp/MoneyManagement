import 'package:flutter/material.dart';

import 'package:Expenses_Tracker_App/ui/shared/app_colors.dart';

class AppFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed("newtransaction");
      },
      child: Icon(Icons.add, color: Colors.black38),
      backgroundColor: backgroundColor,
    );
  }
}
