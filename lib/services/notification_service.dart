import 'package:despensa/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:universal_platform/universal_platform.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  askPermission() async {
    if (!UniversalPlatform.isWeb)
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
  }

  void showNotification(String produto) {
    if (!UniversalPlatform.isWeb)
      flutterLocalNotificationsPlugin.show(
          0,
          "DAPP",
          "Quantidade de $produto está em baixo!",
          NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  importance: Importance.high,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher')));
  }
}
