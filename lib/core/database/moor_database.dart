import 'package:moor_flutter/moor_flutter.dart';
part 'moor_database.g.dart';

class Transactions extends Table {
  TextColumn get type => text()(); //Tiền ra / Tiền vào
  TextColumn get day => text()(); // Ngày
  TextColumn get month => text()(); // Tháng
  TextColumn get memo => text()(); // địa chỉ asset / hinh anh
  IntColumn get id => integer().autoIncrement()();
  IntColumn get amount => integer()(); // giá tiền
  IntColumn get categoryindex=> integer()(); // 0,1,2,...
}
class Accounts extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username=>text()();
  TextColumn get password=>text()();
}

@UseMoor(tables: [Transactions,Accounts], daos: [TransactionDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sqlite", logStatements: true));
  int get schemaVersion => 1;
}

// Bảng mà DAO có thể truy cập được
@UseDao(
  tables: [Transactions],
  queries: {
    // câu lênh gọi
    'getTransactionForMonth':
        'SELECT * FROM transactions WHERE month = :month',
    'getTransactionForDay':
    'SELECT * FROM transactions WHERE day = :day',
    'sumTheMoneyForMonth':
        'SELECT SUM(amount) FROM transactions WHERE month = :month AND type = :type',
    'sumTheMoneyForDay':
    'SELECT SUM(amount) FROM transactions WHERE day = :day AND type = :type',
    'getAllTransactionsForType':
        'SELECT * FROM transactions WHERE month = :month AND type = :type'
  },
)
class TransactionDao extends DatabaseAccessor<AppDatabase>
    with _$TransactionDaoMixin {
  final AppDatabase db;

  // được gọi bởi AppDatabase class
  TransactionDao(this.db) : super(db);

  Future<List<Transaction>> getAllTransactions() => select(transactions).get();
  // thêm
  Future insertTransaction(Transaction transaction) =>
      into(transactions).insert(transaction);
//sữa
  Future updateTransaction(Transaction transaction) =>
      update(transactions).replace(transaction);
//xoá
  Future deleteTransaction(Transaction transaction) =>
      delete(transactions).delete(transaction);
}
