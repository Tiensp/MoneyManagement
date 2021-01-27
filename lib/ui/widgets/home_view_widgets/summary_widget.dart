import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Expenses_Tracker_App/ui/shared/text_styles.dart';
import 'package:Expenses_Tracker_App/ui/shared/ui_helpers.dart';
import 'package:flutter/widgets.dart';

class SummaryWidget extends StatelessWidget {
  final int income;
  final int expense;

  const SummaryWidget({this.income, this.expense});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Tiền vào : ', style: summaryTextStyle),
                  UIHelper.verticalSpaceSmall(),
                  Text(income.toString(), style: summaryNumberTextStyle)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Tiền ra : ',
                    style: summaryTextStyle,
                  ),
                  UIHelper.verticalSpaceSmall(),

                  Text(expense.toString(), style: summaryNumberTextStyle,textAlign: TextAlign.right,)
                ],
              ),
              Divider(
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Số dư : ',
                    style: summaryTextStyle,
                  ),
                  UIHelper.horizontalSpaceSmall(),
                  Text((income - expense).toString(),
                      style: summaryNumberTextStyle)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
