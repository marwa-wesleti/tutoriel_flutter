import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi{
  static final _notification=FlutterLocalNotificationsPlugin();
  static final onNotification=BehaviorSubject<String?>();

  static Future _notificationDetails() async{
    return NotificationDetails(
      android: AndroidNotificationDetails(
    'channel_id',
    'Channel Name',
    channelDescription: "Channel Description",
    importance: Importance.max,
  ),
      iOS: DarwinNotificationDetails()
    );
  }

  static Future<void> init({bool initSchedule = true}) async {
  final android = AndroidInitializationSettings('@mipmap/ic_launcher');
  final ios = DarwinInitializationSettings();
  final settings = InitializationSettings(android: android, iOS: ios);
  
  await _notification.initialize(
    settings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      final String? payload = response.payload;
      if (payload != null) {
        onNotification.add(payload);
      }
    },
  );
}

  static Future showNotification({
    int id=0,
    String? title,
    String? body,
    String? payload,
  }) async => _notification.show(
    id,
   title,
    body,
    await _notificationDetails(),
    payload: payload
    );
}