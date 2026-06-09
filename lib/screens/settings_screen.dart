
import 'package:flutter/material.dart';
import '../widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // General Section
            const Text(
              'settings',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 37, 4, 4),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  SettingsTile(
                    icon: Icons.notifications,
                    label: 'Notifications',
                    iconColor: Colors.orange,
                  ),
                  const Divider(height: 1),
                  SettingsTile(
                    icon: Icons.dark_mode,
                    label: 'Dark Mode',
                    iconColor: Colors.indigo,
                  ),
                  const Divider(height: 1),
                  SettingsTile(
                    icon: Icons.language,
                    label: 'Language',
                    iconColor: Colors.green,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // More Section
            const Text(
              'More',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 31, 24, 24),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  SettingsTile(
                    icon: Icons.privacy_tip,
                    label: 'Privacy Policy',
                    iconColor: Colors.red,
                  ),
                  const Divider(height: 1),
                  SettingsTile(
                    icon: Icons.info,
                    label: 'About Application',
                    iconColor: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


