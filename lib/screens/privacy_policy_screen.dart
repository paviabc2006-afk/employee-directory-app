import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: isDark
                  ? Colors.black.withOpacity(0.75)
                  : Colors.white.withOpacity(0.85),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Privacy Policy',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Last updated: June 2026',
                  style: TextStyle(
                    fontSize: 17,
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 20),

                _buildSection(
                  context: context,
                  icon: Icons.info_outline,
                  title: '1. About This App',
                  content:
                      'Flutter Training App is a multi-screen Employee Directory Application built using Flutter. It is designed to demonstrate core Flutter concepts including navigation, state management, reusable widgets, and clean folder structure.',
                ),

                _buildSection(
                  context: context,
                  icon: Icons.people_outline,
                  title: '2. Employee Data',
                  content:
                      'This app displays employee information including name, ID, email, mobile number, department, and location. All data shown in this app is for demonstration purposes only and does not represent real individuals.',
                ),

                _buildSection(
                  context: context,
                  icon: Icons.lock_outline,
                  title: '3. Data Privacy',
                  content:
                      'We respect your privacy. This app does not collect, store, or share any personal data to external servers. All information remains on your device only.',
                ),

                _buildSection(
                  context: context,
                  icon: Icons.notifications_outlined,
                  title: '4. Notifications',
                  content:
                      'This app may show birthday notifications for employees. You can enable or disable notifications anytime from Settings → Notifications.',
                ),

                _buildSection(
                  context: context,
                  icon: Icons.dark_mode_outlined,
                  title: '5. App Preferences',
                  content:
                      'User preferences such as Dark Mode and Language settings are stored locally on your device. These preferences are never shared with third parties.',
                ),

                _buildSection(
                  context: context,
                  icon: Icons.security_outlined,
                  title: '6. Security',
                  content:
                      'We take reasonable steps to protect the information within this app. Since no data is transmitted to external servers, your information stays safe on your device.',
                ),

                _buildSection(
                  context: context,
                  icon: Icons.update_outlined,
                  title: '7. Changes to This Policy',
                  content:
                      'We may update this Privacy Policy from time to time. Any changes will be reflected within the app. Continued use of the app means you accept the updated policy.',
                ),

                _buildSection(
                  context: context,
                  icon: Icons.contact_mail_outlined,
                  title: '8. Contact Us',
                  content:
                      'If you have any questions about this Privacy Policy, please contact us at: training@elcot.in',
                ),

                const SizedBox(height: 20),

                Center(
                  child: Text(
                    'Your privacy is important to us ❤️',
                    style: TextStyle(
                      fontSize: 16,
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String content,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: colorScheme.onSurface,
            ),
          ),
          const Divider(height: 24),
        ],
      ),
    );
  }
}