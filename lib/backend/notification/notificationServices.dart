import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LexitNotificationServices {
  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      int id,
      String title,
      String body,
      String? payload) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails('sample', 'sampleTestNotification',
            channelDescription: 'This is just a testing notification',
            importance: Importance.max,
            priority: Priority.high,
            enableVibration: true,
            showWhen: false);

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin
        .show(id, title, body, platformChannelSpecifics, payload: payload);
  }
}

class LexitNotificationTemplates {
  void logoutNotification() {
    LexitNotificationServices().showNotification(
        FlutterLocalNotificationsPlugin(),
        1,
        'Lexit',
        'You just logged out 🙁, hope you will comeback soon!',
        'notification_payload');
  }

  void profileUpdateNotification() {
    LexitNotificationServices().showNotification(
        FlutterLocalNotificationsPlugin(),
        1,
        'Lexit',
        'Your profile is just updated 😀',
        'notification_payload');
  }

  void offerNotification(String content) {
    LexitNotificationServices().showNotification(
        FlutterLocalNotificationsPlugin(),
        7,
        'Lexit',
        "🎉 " + content,
        'notification_payload');
  }

  void bookingNotification(String content) {
    LexitNotificationServices().showNotification(
        FlutterLocalNotificationsPlugin(),
        8,
        'Lexit',
        "🗓 " + content,
        'notification_payload');
  }
}
