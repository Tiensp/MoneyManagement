import 'package:Expenses_Tracker_App/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:Expenses_Tracker_App/core/database/moor_database.dart';
import 'package:Expenses_Tracker_App/core/enums/viewstate.dart';
import 'package:Expenses_Tracker_App/core/viewmodels/home_model.dart';
import 'package:Expenses_Tracker_App/ui/views/base_view.dart';
import 'package:Expenses_Tracker_App/ui/widgets/home_view_widgets/app_fab.dart';
import 'package:Expenses_Tracker_App/ui/widgets/home_view_widgets/empty_transaction_widget.dart';
import 'package:Expenses_Tracker_App/ui/widgets/home_view_widgets/month_year_picker_widget.dart';
import 'package:Expenses_Tracker_App/ui/widgets/home_view_widgets/summary_widget.dart';
import 'package:Expenses_Tracker_App/ui/widgets/home_view_widgets/transactions_listview_widget.dart';
import 'package:Expenses_Tracker_App/ui/widgets/home_view_widgets/app_docker.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) async => await model.init(),
      builder: (context, model, child) => Scaffold(
        //tạo appbar
        appBar: AppBar(
          centerTitle: true,
          title: Text('Trang chủ',style: TextStyle(fontSize: 22.0), textAlign: TextAlign.center),
          backgroundColor: backgroundColor,
        ),
        bottomNavigationBar: AppDocker(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // nút add transaction
        floatingActionButton: Visibility(
          visible: model.show,
          child: AppFAB(),
        ),
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                PickMonthOverlay(
                    model: model,
                    context: context),
                SummaryWidget(
                  income: model.incomeSum,
                  expense: model.expenseSum,
                ),
                buildList(model.transactions, model),
              ],
            ),
          ],
        ),
      ),
    );
  }
  buildList(List<Transaction> transactions, HomeModel model) {
    return transactions.length == 0
        ? EmptyTransactionsWidget()
        : TransactionsListView(transactions, model);
  }
}
