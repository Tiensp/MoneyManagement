import 'package:flutter/material.dart';
import 'package:Expenses_Tracker_App/core/database/moor_database.dart';

class DetailsTable extends StatelessWidget {
  const DetailsTable({
    Key key,
    @required this.transaction,
  }) : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: {1: FixedColumnWidth(250)},
      children: [
        TableRow(
          children: [
            Text(
              "Loại :",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
            Text(
              transaction.type,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Text(
              "Số tiền :",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
            Text(
              transaction.amount.toString(),
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Text(
              "Ngày : ",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
            Text(
              transaction.day + ", " + transaction.month,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Text(
              "Ghi chú",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
            Text(
              transaction.memo,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ],
        )
      ],
    );
  }
}
