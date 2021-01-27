import 'package:flutter/material.dart';
import 'package:Expenses_Tracker_App/core/enums/viewstate.dart';
import 'package:Expenses_Tracker_App/core/viewmodels/reminder_model.dart';
import 'package:Expenses_Tracker_App/ui/views/base_view.dart';

class ReminderView extends StatelessWidget {
  const ReminderView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ReminderModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(title: Text('Hẹn giờ')),
        body: model.state == ViewState.Busy
            ? CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Hẹn giờ cập nhật giao dịch hằng ngày'),
                    subtitle: Text(model.timeText),
                    trailing: InkWell(
                      child: Icon(Icons.edit),
                      onTap: () {
                        model.pickTime(context);
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
