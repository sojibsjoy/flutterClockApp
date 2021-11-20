import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationAPI {
  static final _notificationPlugin = FlutterLocalNotificationsPlugin();

  static var initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel ID',
        'channel Name',
        channelDescription: 'channel description',
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    _notificationPlugin.initialize(
        InitializationSettings(android: initializationSettingsAndroid));
    return _notificationPlugin.show(
      id,
      title,
      body,
      await _notificationDetails(),
      payload: payload,
    );
  }
}
