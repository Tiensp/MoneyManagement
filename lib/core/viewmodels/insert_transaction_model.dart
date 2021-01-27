import 'package:flutter/material.dart';
import 'package:Expenses_Tracker_App/core/database/moor_database.dart';
import 'package:Expenses_Tracker_App/core/services/moordatabase_service.dart';
import 'package:Expenses_Tracker_App/core/viewmodels/base_model.dart';
import 'package:toast/toast.dart';

import '../../locator.dart';
// model của màng thêm giao dich
class InsertTransactionModel extends BaseModel {
  TextEditingController memoController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final MoorDatabaseService _moorDatabaseService =
  locator<MoorDatabaseService>();

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

  String selectedDay;
  String selectedMonth;
  DateTime selectedDate = new DateTime.now();
  String type;
  int cateogryIndex;

  Future selectDate(context) async {
    unFocusFromTheTextField(context);

    DateTime picked = await showDatePicker(
        context: context,
        locale : const Locale("vi","VN"),
        initialDate: selectedDate,
        firstDate: DateTime(2018),
        lastDate: DateTime.now());

    if (picked != null) {
      selectedMonth = months[picked.month - 1];
      selectedDay = picked.day.toString();
      selectedDate = picked;

      notifyListeners();
    }
  }

  void init(int selectedCategory, int index) {
    selectedMonth = months[DateTime.now().month - 1];
    selectedDay = DateTime.now().day.toString();
    type = (selectedCategory == 1) ? 'Tiền vào' : 'Tiền ra';
    cateogryIndex = index;
  }

  void unFocusFromTheTextField(context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  String getSelectedDate() {
    if (int.parse(selectedDay) == DateTime.now().day &&
        DateTime.now().month == months.indexOf(selectedMonth) + 1) {
      return 'Hôm nay, ' + selectedMonth + ',' + selectedDay;
    } else {
      return selectedMonth + ',' + selectedDay;
    }
  }

  addTransaction(context) async {
    String memo = memoController.text;
    String amount = amountController.text;

    if (memo.length == 0 || amount.length == 0) {
      Toast.show("Hãy điền vào vị trí còn trống!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    Transaction newTransaction = new Transaction(
        type: type,
        day: selectedDay,
        month: selectedMonth,
        memo: memoController.text,
        amount: int.parse(amount),
        categoryindex: cateogryIndex);
    // insert it!
    await _moorDatabaseService.insertTransaction(newTransaction);

    Toast.show("Thêm thành công!", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    // return to the home
    Navigator.of(context)
        .pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
  }
}
