import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../providers/notification_provider.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {},
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // FCM Foreground messages — app open-ஆ இருக்கும்போது
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null) {
        showFcmNotification(
          id: message.hashCode,
          title: notification.title ?? 'புதிய தகவல்',
          body: notification.body ?? '',
        );
        // Notification screen list-la auto add
        NotificationProvider().addNotification({
          'id': message.hashCode.toString(),
          'title': notification.title ?? 'புதிய தகவல்',
          'body': notification.body ?? '',
          'time': _currentTime(),
          'icon': Icons.notifications,
          'color': Colors.blue,
          'read': false,
        });
      }
    });
  }

  String _currentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12
        ? now.hour - 12
        : now.hour == 0
            ? 12
            : now.hour;
    final min = now.minute.toString().padLeft(2, '0');
    final ampm = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$min $ampm';
  }

  // ─── Daily 9:30 AM Work Alert ──────────────────────────────
  Future<void> scheduleDailyWorkAlert() async {
    await _plugin.cancel(1);

    final now = tz.TZDateTime.now(tz.local);
    var scheduled =
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'work_alert_channel',
      'Work Alert',
      channelDescription: 'Daily 9:30 AM work reminder',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await _plugin.zonedSchedule(
      1,
      'Good Morning! Work Alert',
      'Today be productive! TeamSPACE check pannunga',
      scheduled,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // ─── Birthday Notification ─────────────────────────────────
  Future<void> showBirthdayNotification(String name) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'birthday_channel',
      'Birthday Alerts',
      channelDescription: 'Birthday notifications',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await _plugin.show(
      2,
      'Birthday Alert!',
      'Today is $name birthday! Wish pannIngala?',
      details,
    );
  }

  // ─── FCM Push Notification ─────────────────────────────────
  Future<void> showFcmNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'fcm_channel',
      'Push Notifications',
      channelDescription: 'Firebase push notifications',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await _plugin.show(id, title, body, details);
  }

  // ─── Cancel methods ────────────────────────────────────────
  Future<void> cancelWorkAlert() async => _plugin.cancel(1);
  Future<void> cancelBirthdayAlert() async => _plugin.cancel(2);
  Future<void> cancelAllNotifications() async => _plugin.cancelAll();
}