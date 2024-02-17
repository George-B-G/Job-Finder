import 'package:amit_job_finder/shared/components/constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    notificationList.add({
      'data': message.data,
      'time': message.sentTime,
      'id': message.senderId,
      'notificationTitle': message.notification!.title,
      'notificationBody': message.notification!.body,
    });
    notificationList.toSet();
  }
}

class FirebaseMessageApi {
  static initNotification() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    String? token = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // print('User granted permission: ${settings.authorizationStatus}');
    // print('=========================\n$token');
  }

  static getNotificationOnForeground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      notificationList.add({
        'data': message.data,
        'time': message.sentTime,
        'id': message.senderId,
        'notificationTitle': message.notification!.title,
        'notificationBody': message.notification!.body,
      });
      notificationList.toSet();
    });
  }

  static Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      if (initialMessage.notification != null) {
        notificationList.add({
          'data': initialMessage.data,
          'time': initialMessage.sentTime,
          'id': initialMessage.senderId,
          'notificationTitle': initialMessage.notification!.title,
          'notificationBody': initialMessage.notification!.body,
        });
      }
    }
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        notificationList.add({
          'data': message.data,
          'time': message.sentTime,
          'id': message.senderId,
          'notificationTitle': message.notification!.title,
          'notificationBody': message.notification!.body,
        });
        notificationList.toSet();
      }
    });
  }
}
