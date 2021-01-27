import 'package:Expenses_Tracker_App/core/services/category_icon_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Expenses_Tracker_App/core/database/moor_database.dart';
import 'package:Expenses_Tracker_App/core/viewmodels/home_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../locator.dart';

class TransactionsListView extends StatefulWidget {
  final List<Transaction> transactions;
  List<Transaction> _transaction;

  final HomeModel model;
  TransactionsListView(
      this.transactions,
      this.model,
      );
  @override
  _TransactionsListViewState createState() => _TransactionsListViewState();
}

class _TransactionsListViewState extends State<TransactionsListView> with WidgetsBindingObserver{
  final CategoryIconService _categoryIconService =
  locator<CategoryIconService>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        controller: widget.model.scrollController,
        padding: EdgeInsets.all(8),
        physics: const AlwaysScrollableScrollPhysics (),
        children: widget.transactions.map((transaction) {
          return Card(
              child: InkWell(
                onLongPress: (){
                  Navigator.pushNamed(context, "details", arguments: transaction)
                      .then((value) => {
                    if (value != null)
                      {
                        if (value) {widget.model.init()}
                      }
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            transaction.day + ', ' + transaction.month,
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Text(
                            transaction.type +
                                " : " +
                                transaction.amount.toString(),
                            style: TextStyle(fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.transparent,
                          child: widget.model.getIconForCategory(
                              transaction.categoryindex, transaction.type),
                        ),
                        title: Text(getCategoryIconName(transaction.categoryindex,transaction.type)),
                        subtitle: Text(transaction.memo),
                        trailing: transaction.type == 'Tiền ra'
                            ? Text('- ' + transaction.amount.toString(),
                            style: TextStyle(fontSize: 20))
                            : Text('+ ' + transaction.amount.toString(),
                            style: TextStyle(fontSize: 20)),
                      )
                    ],
                  ),
                ),
              )
          );
        }).toList(),
      ),
    );
  }
  String getCategoryIconName(index, type) {
    if (type == 'Tiền vào') {
      return _categoryIconService.incomeList.elementAt(index).name;
    } else {
      return _categoryIconService.expenseList.elementAt(index).name;
    }
  }
}
