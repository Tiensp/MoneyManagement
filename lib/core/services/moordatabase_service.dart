import 'package:Expenses_Tracker_App/core/database/moor_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoorDatabaseService {
  final AppDatabase _database = AppDatabase();
//tổng
  getAllTransactions(String month) async {
    List<Transaction> allTrans = List<Transaction>();

    TransactionDao transactionDao = _database.transactionDao;

    allTrans = await transactionDao.getTransactionForMonth(month).get();
    return allTrans;
  }
  getAllTransactionsForDay(String day) async{
    List<Transaction> allDayTrans = List<Transaction>();
    TransactionDao transactionDao = _database.transactionDao;
    allDayTrans = await transactionDao.getTransactionForDay(day).get();
  }
//tổng tiền vào
  getIncomeSum(String month) async {
    List<int> list = await _database.transactionDao
        .sumTheMoneyForMonth(month, "Tiền vào")
        .get();

    int sumOfIncome = 0;

    if (list == null && list.length == 0) {
      return 0;
    }

    list.forEach((element) {
      if (element == null) {
        return;
      }
      sumOfIncome += element;
    });

    return sumOfIncome;
  }
//tổng tiền ra
  getExpenseSum(String month) async {
    List<int> list = await _database.transactionDao
        .sumTheMoneyForMonth(month, "Tiền ra")
        .get();

    int sumOfExpense = 0;

    if (list == null && list.length == 0) {
      return 0;
    }

    list.forEach((element) {
      if (element == null) {
        return;
      }
      sumOfExpense += element;
    });

    return sumOfExpense;
  }
//xoá
  Future deleteTransaction(Transaction transaction) async {
    return await _database.transactionDao.deleteTransaction(transaction);
  }
//thêm
  Future insertTransaction(Transaction transaction) async {
    return await _database.transactionDao.insertTransaction(transaction);
  }
//sữa
  Future updateTransaction(Transaction transaction) async {
    return await _database.transactionDao.updateTransaction(transaction);
  }
//lấy theo loại ra/vào
  getAllTransactionsForType(String month, String type) async {
    return await _database.transactionDao
        .getAllTransactionsForType(month, type)
        .get();
  }
}
