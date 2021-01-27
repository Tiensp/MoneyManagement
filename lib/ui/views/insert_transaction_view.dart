import 'package:flutter/material.dart';
import 'package:Expenses_Tracker_App/core/models/category.dart';
import 'package:Expenses_Tracker_App/core/viewmodels/insert_transaction_model.dart';
import 'package:Expenses_Tracker_App/ui/shared/app_colors.dart';
import 'package:Expenses_Tracker_App/ui/shared/ui_helpers.dart';
import 'package:Expenses_Tracker_App/ui/views/base_view.dart';

class InsertTranscationView extends StatelessWidget {
  final Category category;
  final int selectedCategory;
  InsertTranscationView(this.category, this.selectedCategory);
  @override
  Widget build(BuildContext context) {
    return BaseView<InsertTransactionModel>(
      onModelReady: (model) => model.init(selectedCategory, category.index),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: selectedCategory == 1 ? Text('Tiền vào') : Text('TIền ra'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(category.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                  leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.transparent,
                      child: category.icon),
                ),
                UIHelper.verticalSpaceMedium(),
                buildTextField(model.memoController, 'Ghi chú:',
                    "Thêm ghi chú cho giao dịch", Icons.edit, false),
                UIHelper.verticalSpaceMedium(),
                buildTextField(
                    model.amountController,
                    'Số tiền:',
                    "Thêm giá tiền của giao dịch",
                    Icons.attach_money,
                    true),
                UIHelper.verticalSpaceMedium(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Chọn ngày:',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                Container(
                  width: 20,
                  height: 50,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(model.getSelectedDate()),
                    onPressed: () async {
                      await model.selectDate(context);
                    },
                  ),
                ),
                UIHelper.verticalSpaceLarge(),
                Align(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Thêm giao dịch',
                      style: TextStyle(fontSize: 16),
                    ),

                    color: backgroundColor,
                    textColor: Colors.black,
                    onPressed: () async {
                      await model.addTransaction(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildTextField(TextEditingController controller, String text,
      String helperText, IconData icon, isNumeric) {
    return TextFormField(
      cursorColor: Colors.black,
      maxLength: isNumeric ? 10 : 40,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        labelText: text,
        suffixIcon: InkWell(
          onTap: () {
            controller.clear();
          },
          child: Icon(
            Icons.clear,
            color: Colors.black,
          ),
        ),
        labelStyle: TextStyle(
          color: Color(0xFFFF000000),
        ),
        helperText: helperText,
      ),
    );
  }
}
