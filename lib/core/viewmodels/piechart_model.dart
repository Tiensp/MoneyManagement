import 'package:Expenses_Tracker_App/core/enums/viewstate.dart';
import 'package:Expenses_Tracker_App/core/services/category_icon_service.dart';
import 'package:Expenses_Tracker_App/core/viewmodels/base_model.dart';
import 'package:Expenses_Tracker_App/core/database/moor_database.dart';
import 'package:Expenses_Tracker_App/core/services/moordatabase_service.dart';
import '../../locator.dart';

class PieChartModel extends BaseModel {
  List<String> months = [
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

  final MoorDatabaseService _moorDatabaseService =
  locator<MoorDatabaseService>();

  final CategoryIconService _categoryIconService =
  locator<CategoryIconService>();

  List<Transaction> transactions = List<Transaction>();

  int selectedMonthIndex = 0;

  Map<String, double> dataMap = new Map<String, double>();
  String type = 'Tiền ra';

  List<String> types = ["Tiền vào", "Tiền ra"];

  init(bool firstTime) async {
    if (firstTime) selectedMonthIndex = DateTime
        .now()
        .month - 1;

    setState(ViewState.Busy);
    notifyListeners();

    transactions = await _moorDatabaseService.getAllTransactionsForType(
        months.elementAt(selectedMonthIndex), type);

    dataMap = getDefaultDataMap(transactions);

    transactions.forEach((element) {
      prepareDataMap(element);
    });

    print(dataMap.toString());
    setState(ViewState.Idle);
    notifyListeners();
  }

  changeSelectedMonth(int val) async {
    selectedMonthIndex = val;

    transactions = await _moorDatabaseService.getAllTransactionsForType(
        months.elementAt(selectedMonthIndex), type);
    //clear old data
    dataMap = getDefaultDataMap(transactions);

    transactions.forEach((element) {
      prepareDataMap(element);
    });

    notifyListeners();
  }

  Map<String, double> getDefaultDataMap(List<Transaction> transactions) {
    Map<String, double> fullExpensesMap = {
      'Ăn uống': 0,
      'Hoá đơn': 0,
      'Đi lại': 0,
      'Nhà cửa': 0,
      'Giải trí': 0,
      'Mua sắm': 0,
      'Quần áo': 0,
      'Bảo hiểm': 0,
      'Điện thoại': 0,
      'Sức khoẻ': 0,
      'Thể thao': 0,
      'Làm đẹp': 0,
      'Giáo dục': 0,
      'Tặng quà': 0,
      'Thú nuôi': 0,
      'Tiền lương': 0,
      'Tiền thưởng': 0,
      'Trợ cấp': 0,
      'Vay mượn': 0,
      'Lợi nhuận': 0,
      'Xổ số': 0,
    };

    Map<String, double> fullIncomeMap = {
      'Tiền lương': 0,
      'Tiền thưởng': 0,
      'Trợ cấp': 0,
      'Vay mượn': 0,
      'Lợi nhuận': 0,
      'Xổ số': 0,
    };

    List<String> transactionsCategories = List();

    transactions.forEach((element) {
      if (type == 'Tiền vào') {
        String category = _categoryIconService.incomeList
            .elementAt(element.categoryindex)
            .name;
        transactionsCategories.add(category);
      } else {
        String category = _categoryIconService.expenseList
            .elementAt(element.categoryindex)
            .name;
        transactionsCategories.add(category);
      }
    });
    if (type == 'Tiền vào') {
      fullIncomeMap.removeWhere((key, value) {
        return !transactionsCategories.contains(key);
      });
      return fullIncomeMap;
    }

    fullExpensesMap.removeWhere((key, value) {
      return !transactionsCategories.contains(key);
    });
    return fullExpensesMap;
  }

  changeType(int val) async {
    // 0 => tiền vào
    // 1 => tiền ra
    if (val == 0) {
      type = 'Tiền vào';
    } else {
      type = 'Tiền ra';
    }

    await init(true);
  }

  void prepareDataMap(element) {
    if (type == 'Tiền vào') {
      dataMap[_categoryIconService.incomeList
          .elementAt(element.categoryindex)
          .name] = dataMap[_categoryIconService.incomeList
          .elementAt(element.categoryindex)
          .name] + element.amount;
    } else {
      dataMap[_categoryIconService.expenseList
          .elementAt(element.categoryindex)
          .name] = dataMap[_categoryIconService.expenseList
          .elementAt(element.categoryindex)
          .name] +
          element.amount;
    }
  } //prepareDatamap
}
