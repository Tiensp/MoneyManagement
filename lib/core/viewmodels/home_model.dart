import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Expenses_Tracker_App/core/database/moor_database.dart';
import 'package:Expenses_Tracker_App/core/enums/viewstate.dart';
import 'package:Expenses_Tracker_App/core/services/category_icon_service.dart';
import 'package:Expenses_Tracker_App/core/services/moordatabase_service.dart';
import 'package:Expenses_Tracker_App/core/viewmodels/base_model.dart';

import '../../locator.dart';
//model màng hình chính
class HomeModel extends BaseModel {
  final MoorDatabaseService _moorDatabaseService =
  locator<MoorDatabaseService>();

  final CategoryIconService _categoryIconService =
  locator<CategoryIconService>();

  ScrollController scrollController =
  new ScrollController();
  bool show = true;

  List months = [
    'Tháng 1',
    'Tháng 2',
    'Tháng 3',
    'Tháng 4',
    'Tháng 5',
    'Tháng 6',
    'Tháng 7',
    'Tháng 8',
    'Tháng 9',
    'Tháng 10',
    'Tháng 11',
    'Tháng 12'
  ];

  List<Transaction> transactions = List<Transaction>();
  bool isCollabsed = false;
  String appBarTitle; // chọn tháng
  String selectedYear;
  int selectedMonthIndex; // từ danh sách tháng

  int expenseSum = 0;
  int incomeSum = 0;

  monthClicked(String clickedMonth) async {
    selectedMonthIndex = months.indexOf(clickedMonth);
    appBarTitle = clickedMonth;
    transactions = await _moorDatabaseService.getAllTransactions(appBarTitle);
    expenseSum = await _moorDatabaseService.getExpenseSum(appBarTitle);
    incomeSum = await _moorDatabaseService.getIncomeSum(appBarTitle);
    titleClicked();
  }

  titleClicked() {
    isCollabsed = !isCollabsed;
    notifyListeners();
  }

  getColor(month) {
    int monthIndex = months.indexOf(month);
    // màu của tháng được chọn / hiện màu cyan nếu đc chọn
    if (monthIndex == selectedMonthIndex) {
      return Colors.cyan[200];
    } else {
      return Colors.grey[200];
    }
  }

  void closeMonthPicker() {
    isCollabsed = false;
    notifyListeners();
  }

  init() async {
    handleScroll();

    selectedMonthIndex = DateTime.now().month - 1;
    appBarTitle = months[selectedMonthIndex];

    expenseSum = await _moorDatabaseService.getExpenseSum(appBarTitle);
    incomeSum = await _moorDatabaseService.getIncomeSum(appBarTitle);

    print("Tiền ra : $expenseSum");
    print("Tiền vào : $incomeSum");
    //load
    setState(ViewState.Busy);
    notifyListeners();

    transactions = await _moorDatabaseService.getAllTransactions(appBarTitle);
    //hiện danh sách
    setState(ViewState.Idle);
    notifyListeners();
  }

  void handleScroll() async {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideFloationButton(); //kéo xuống sẽ ẩn đi nút thêm giao dịch
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        showFloationButton();
      }
    });
  }

  void showFloationButton() {
    show = true;
    notifyListeners();
  }

  void hideFloationButton() {
    show = false;
    notifyListeners();
  }

  Image getIconForCategory(int index, String type) {
    if (type == 'Tiền vào') {
      final categoryIcon = _categoryIconService.incomeList.elementAt(index);

      return categoryIcon.icon;
    } else {
      final categoryIcon = _categoryIconService.expenseList.elementAt(index);

      return categoryIcon.icon;
    }
  }

  Future deleteTransacation(Transaction transaction) async {
    return await _moorDatabaseService.deleteTransaction(transaction);
  }
}
