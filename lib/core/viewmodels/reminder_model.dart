import 'package:flutter/material.dart';
import 'package:Expenses_Tracker_App/core/enums/viewstate.dart';
import 'package:Expenses_Tracker_App/core/services/notification_service.dart';
import 'package:Expenses_Tracker_App/core/services/sharedprefs_service.dart';
import 'package:Expenses_Tracker_App/core/viewmodels/base_model.dart';

import '../../locator.dart';

// rreminder model
class ReminderModel extends BaseModel {
  final NotificationService _notificationService =
      locator<NotificationService>();

  final SharedPrefrencesService _sharedPrefrencesService =
      locator<SharedPrefrencesService>();

  TimeOfDay selectedTime;

  String timeText = '';

  void scheduleNotifaction() {
    if (selectedTime == null) return;
    _notificationService.showNotificationDaily(
        1,
        'Quản Lý Chi Tiêu',
        'Đừng quên ghi chú chi tiêu của bạn!',
        selectedTime.hour,
        selectedTime.minute);
  }

  pickTime(context) async {
    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      selectedTime = time;
      scheduleNotifaction();

      storeTime(); // in shaerd prefs
      timeText = await getTime();

      notifyListeners();
    }
  }

  getTime() async {
    return await _sharedPrefrencesService.getTime();
  }

  storeTime() async {
    await _sharedPrefrencesService.storeTime(
        selectedTime.hour, selectedTime.minute);
  }

  init() async {
    setState(ViewState.Busy);
    notifyListeners();
    timeText = await getTime();
    setState(ViewState.Idle);
    notifyListeners();
  }
}