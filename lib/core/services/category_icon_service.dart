import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Expenses_Tracker_App/core/models/category.dart';

class CategoryIconService {
  //* Danh sách các mục tiền ra
  final expenseList = {
    Category(0, "Ăn uống", Image.asset("assets/icons/food.png"), Colors.green),
    Category(1, "Hoá đơn", Image.asset("assets/icons/bill.png"), Colors.blue),
    Category(2, "Đi lại", Image.asset("assets/icons/taxi.png"), Colors.blueAccent),
    Category(3, "Nhà cửa", Image.asset("assets/icons/home.png"), Colors.brown),
    Category(4, "Giải trí", Image.asset("assets/icons/game.png"), Colors.indigoAccent),
    Category(5, "Mua sắm", Image.asset("assets/icons/goods.png"), Colors.deepOrange),
    Category(6, "Quần áo", Image.asset("assets/icons/hanger.png"), Colors.deepOrangeAccent),
    Category(7, "Bảo hiểm", Image.asset("assets/icons/insurance.png"), Colors.indigo),
    Category(8, "Điện thoại", Image.asset("assets/icons/smartphone.png"), Colors.indigoAccent),
    Category(9, "Sức khoẻ", Image.asset("assets/icons/healthcare.png"), Colors.lime),
    Category(10, "Thể thao", Image.asset("assets/icons/soccer.png"), Colors.brown),
    Category(11, "Làm đẹp", Image.asset("assets/icons/cosmetics.png"), Colors.pink),
    Category(12, "Giáo dục", Image.asset("assets/icons/study.png"), Colors.teal),
    Category(13, "Tặng quà", Image.asset("assets/icons/gift.png"), Colors.redAccent),
    Category(14, "Thú nuôi", Image.asset("assets/icons/pet.png"), Colors.deepPurple),
  };
  //* mục trong tiền vào
  final incomeList = {
    Category(0, "Tiền lương", Image.asset("assets/icons/salary.png"), Colors.lightGreen[900]),
    Category(1, "Tiền thưởng", Image.asset("assets/icons/bonus.png"), Colors.amber),
    Category(2, "Trợ cấp", Image.asset("assets/icons/finance.png"), Colors.lightGreen),
    Category(3, "Vay mượn", Image.asset("assets/icons/credit.png"), Colors.yellow[900]),
    Category(4, "Lợi nhuận",Image.asset("assets/icons/investment.png"), Colors.indigoAccent),
    Category(5, "Xổ số", Image.asset("assets/icons/winner.png"), Colors.deepOrange),
  };
}
