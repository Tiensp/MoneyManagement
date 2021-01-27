import 'package:Expenses_Tracker_App/core/models/category.dart';
import 'package:Expenses_Tracker_App/core/services/category_icon_service.dart';
import 'package:Expenses_Tracker_App/core/viewmodels/base_model.dart';
import 'package:Expenses_Tracker_App/locator.dart';
// model màn hình chọn mục
class NewTransactionModel extends BaseModel {
  final CategoryIconService _categoryIconService =
  locator<CategoryIconService>();

  int selectedCategory = 2; // 1 : tiền vào,2 tiền ra

  void changeSelectedItem(int newItemIndex) {
    selectedCategory = newItemIndex;

    notifyListeners();
  }
// hiện danh sách các mục tiền ra và vào
  List<Category> loadCategoriesIcons() {
    if (selectedCategory == 1) {
      // load income
      List<Category> s = _categoryIconService.incomeList.toList();
      return s;
    } else {
      // load expense
      List<Category> s = _categoryIconService.expenseList.toList();
      return s;
    }
  }
}
