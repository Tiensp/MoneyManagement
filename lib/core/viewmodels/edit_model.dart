import 'package:flutter/material.dart';
import 'package:Expenses_Tracker_App/core/database/moor_database.dart';
import 'package:Expenses_Tracker_App/core/models/category.dart';
import 'package:Expenses_Tracker_App/core/services/category_icon_service.dart';
import 'package:Expenses_Tracker_App/core/services/moordatabase_service.dart';
import 'package:Expenses_Tracker_App/core/viewmodels/base_model.dart';
import 'package:toast/toast.dart';

import '../../locator.dart';
// model màng hình sữa giao dich
class EditModel extends BaseModel {
  TextEditingController memoController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final MoorDatabaseService _moorDatabaseService =
  locator<MoorDatabaseService>();

  final CategoryIconService _categoryIconService =
  locator<CategoryIconService>();

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
  Category category;

  Future selectDate(context) async {
    //ẩn phím
    unFocusFromTheTextField(context);

    DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now());
// đặt giá trị sẳn
    if (picked != null) {
      selectedMonth = months[picked.month - 1];
      selectedDay = picked.day.toString();
      selectedDate = picked;

      notifyListeners();
    }
  }

  void unFocusFromTheTextField(context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
// thông tin ngày giờ sẽ hiển thị
  String getSelectedDate() {
    if (int.parse(selectedDay) == DateTime.now().day &&
        DateTime.now().month == months.indexOf(selectedMonth) + 1) {
      return 'Hôm nay, ' + selectedMonth + ',' + selectedDay;
    } else {
      return selectedMonth + ',' + selectedDay;
    }
  }

  void init(Transaction transaction) {
    selectedMonth = transaction.month;
    selectedDay = transaction.day;
    if (transaction.type == 'Tiền vào') {
      category =
          _categoryIconService.incomeList.elementAt(transaction.categoryindex);
    } else {
      category =
          _categoryIconService.expenseList.elementAt(transaction.categoryindex);
    }
    memoController.text = transaction.memo;
    amountController.text = transaction.amount.toString();
    notifyListeners();
  }

  editTransaction(context, type, categoryIndex, id) async {
    String memo = memoController.text;
    String amount = amountController.text;

    if (memo.length == 0 || amount.length == 0) {
      Toast.show("Hãy điền vào vị trí còn trống!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    Transaction updatedTransaction = new Transaction(
        type: type,
        day: selectedDay,
        id: id,
        month: selectedMonth,
        memo: memoController.text,
        amount: int.parse(amount),
        categoryindex: categoryIndex);
    // insert it!
    await _moorDatabaseService.updateTransaction(updatedTransaction);

    Toast.show("Tuỳ chỉnh thành công!", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    // return to the home

    Navigator.of(context).pushNamedAndRemoveUntil(
        'details', (Route<dynamic> route) => false,
        arguments: updatedTransaction);
  }
}
