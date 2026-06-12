import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  static final NotificationProvider _instance = NotificationProvider._internal();
  factory NotificationProvider() => _instance;
  NotificationProvider._internal();

  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': '🌅 Good Morning! Work Alert',
      'body': 'Today be productive! TeamSPACE check pannunga',
      'time': '9:30 AM',
      'icon': Icons.work,
      'color': Colors.blue,
      'read': false,
    },
    {
      'id': '2',
      'title': '🎂 Birthday Alert!',
      'body': 'Today someone has a birthday! Wish pannIngala?',
      'time': 'Today',
      'icon': Icons.cake,
      'color': Colors.pinkAccent,
      'read': false,
    },
  ];

  List<Map<String, dynamic>> get notifications => List.unmodifiable(_notifications);

  int get unreadCount => _notifications.where((n) => n['read'] == false).length;

  void addNotification(Map<String, dynamic> notif) {
    _notifications.insert(0, notif);
    notifyListeners();
  }

  void dismiss(String id) {
    _notifications.removeWhere((n) => n['id'] == id);
    notifyListeners();
  }

  void clearAll() {
    _notifications.clear();
    notifyListeners();
  }

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n['id'] == id);
    if (index != -1) {
      _notifications[index] = Map.from(_notifications[index])..['read'] = true;
      notifyListeners();
    }
  }

  void markAllAsRead() {
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i] = Map.from(_notifications[i])..['read'] = true;
    }
    notifyListeners();
  }
}