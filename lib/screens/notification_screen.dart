import 'package:flutter/material.dart';
import '../services/notification_service.dart';
import '../providers/notification_provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _workAlertEnabled = true;
  bool _birthdayAlertEnabled = true;
  final _provider = NotificationProvider();

  @override
  void initState() {
    super.initState();
    _provider.addListener(_refresh);
  }

  @override
  void dispose() {
    _provider.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() => setState(() {});

  void _toggleWorkAlert(bool value) async {
    setState(() => _workAlertEnabled = value);
    if (value) {
      await NotificationService().scheduleDailyWorkAlert();
      _showSnackBar('✅ Work Alert enabled!', Colors.green);
    } else {
      await NotificationService().cancelWorkAlert();
      _showSnackBar('🔕 Work Alert disabled!', Colors.orange);
    }
  }

  void _toggleBirthdayAlert(bool value) async {
    setState(() => _birthdayAlertEnabled = value);
    if (value) {
      _showSnackBar('✅ Birthday Alert enabled!', Colors.green);
    } else {
      _showSnackBar('🔕 Birthday Alert disabled!', Colors.orange);
    }
  }

  void _showSnackBar(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final notifications = _provider.notifications;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 36, 125, 214),
        foregroundColor: Colors.white,
        actions: [
          if (notifications.isNotEmpty)
            TextButton.icon(
              onPressed: () {
                _provider.clearAll();
                _showSnackBar('🗑️ All notifications cleared!', Colors.grey.shade700);
              },
              icon: const Icon(Icons.delete_sweep_rounded, color: Colors.white, size: 20),
              label: const Text('Clear all', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Settings Section
            Text(
              'Notification Settings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(0.15),
                      child: const Icon(Icons.work, color: Colors.blue),
                    ),
                    title: const Text(
                      'Work Alert',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text('Daily 9:30 AM reminder'),
                    value: _workAlertEnabled,
                    activeColor: Colors.blue,
                    onChanged: _toggleWorkAlert,
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: CircleAvatar(
                      backgroundColor: Colors.pink.withOpacity(0.15),
                      child: const Icon(Icons.cake, color: Colors.pinkAccent),
                    ),
                    title: const Text(
                      'Birthday Alert',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text('Birthday notifications'),
                    value: _birthdayAlertEnabled,
                    activeColor: Colors.pinkAccent,
                    onChanged: _toggleBirthdayAlert,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Notifications',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                if (_provider.unreadCount > 0)
                  TextButton(
                    onPressed: () {
                      _provider.markAllAsRead();
                      _showSnackBar('✅ All marked as read!', Colors.blue);
                    },
                    child: const Text('Mark all read'),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // Empty State
            if (notifications.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: [
                      Icon(Icons.notifications_off_rounded,
                          size: 52,
                          color: isDark ? Colors.white24 : Colors.black.withOpacity(0.15)),
                      const SizedBox(height: 12),
                      Text(
                        'No notifications',
                        style: TextStyle(
                          fontSize: 15,
                          color: isDark ? Colors.white38 : Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Notification List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return Dismissible(
                  key: Key(notif['id']),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) {
                    _provider.dismiss(notif['id']);
                    _showSnackBar('🗑️ Notification removed!', Colors.grey.shade700);
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.delete_rounded, color: Colors.white, size: 28),
                        SizedBox(height: 4),
                        Text('Delete',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () => _provider.markAsRead(notif['id']),
                    child: Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: notif['read'] == false
                            ? BorderSide(
                                color: (notif['color'] as Color).withOpacity(0.5),
                                width: 1.5)
                            : BorderSide.none,
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: CircleAvatar(
                          backgroundColor: (notif['color'] as Color).withOpacity(0.15),
                          child: Icon(notif['icon'] as IconData,
                              color: notif['color'] as Color),
                        ),
                        title: Text(
                          notif['title'],
                          style: TextStyle(
                            fontWeight: notif['read'] == false
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 14,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              notif['body'],
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? Colors.white60 : Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              notif['time'],
                              style: TextStyle(
                                fontSize: 11,
                                color: notif['color'] as Color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        trailing: notif['read'] == false
                            ? CircleAvatar(
                                radius: 6,
                                backgroundColor: notif['color'] as Color,
                              )
                            : const Icon(Icons.check_circle_outline,
                                size: 18, color: Colors.green),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}