import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrencesService {
  final String hourKey = 'hour';
  final String minuteKey = 'minute';

  Future<String> getTime() async {
    final prefs = await SharedPreferences.getInstance();

    // đọc dữ liệu từ biến đến , nếu ko thì trả về 0
    final int hour = prefs.getInt(hourKey) ?? 0;
    final int minute = prefs.getInt(minuteKey) ?? 0;

    if (hour == 0 || minute == 0) return 'Chưa cài đặt thời gian';
    // chuyển thành 2 chữ số để cho chế độ 24 giờ
    String hourTwoDigits = hour.toString().padLeft(2, '0');

    return 'Reminder at $hourTwoDigits:$minute';
  }

  storeTime(int hour, int minute) async {
    final prefs = await SharedPreferences.getInstance();

    // cài giá trị
    prefs.setInt(hourKey, hour);
    prefs.setInt(minuteKey, minute);
  }
}
