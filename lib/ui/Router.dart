import 'package:flutter/material.dart';
import 'package:Expenses_Tracker_App/core/database/moor_database.dart';
import 'package:Expenses_Tracker_App/ui/views/details_view.dart';
import 'package:Expenses_Tracker_App/ui/views/edit_view.dart';
import 'package:Expenses_Tracker_App/ui/views/home_view.dart';
import 'package:Expenses_Tracker_App/ui/views/insert_transaction_view.dart';
import 'package:Expenses_Tracker_App/ui/views/new_transaction_view.dart';
import 'package:Expenses_Tracker_App/ui/views/piechart_view.dart';
import 'package:Expenses_Tracker_App/ui/views/reminder_view.dart';
import 'package:Expenses_Tracker_App/ui/views/spash_view.dart';

const String initialRoute = "/";

class router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SpashView());
      case 'home':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'edit':
        var transaction = settings.arguments as Transaction;
        return MaterialPageRoute(builder: (_) => EditView(transaction));
      case 'chart':
        return MaterialPageRoute(builder: (_) => PieChartView());
      case 'newtransaction':
        return MaterialPageRoute(builder: (_) => NewTransactionView());
      case 'inserttransaction':
        var args = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
            builder: (_) =>
                InsertTranscationView(args.elementAt(0), args.elementAt(1)));
      case 'details':
        var transaction = settings.arguments as Transaction;
        return MaterialPageRoute(builder: (_) => DetailsView(transaction));
      case 'reminder':
        return MaterialPageRoute(builder: (_) => ReminderView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
