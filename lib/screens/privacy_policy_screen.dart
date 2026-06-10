import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Last updated: June 2025',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            _buildSection(
              icon: Icons.info_outline,
              title: '1. About This App',
              content:
                  'Flutter Training App is an Employee Directory Application. '
                  'It allows users to view employee profiles, details, and manage '
                  'basic settings. This app is built for training purposes.',
            ),

            _buildSection(
              icon: Icons.people_outline,
              title: '2. Employee Data',
              content:
                  'This app displays employee information including name, ID, '
                  'email, mobile number, department, and location. '
                  'All data shown in this app is for demonstration purposes only '
                  'and does not represent real individuals.',
            ),

            _buildSection(
              icon: Icons.lock_outline,
              title: '3. Data Privacy',
              content:
                  'We respect your privacy. This app does not collect, store, '
                  'or share any personal data to external servers. '
                  'All information remains on your device only.',
            ),

            _buildSection(
              icon: Icons.notifications_outlined,
              title: '4. Notifications',
              content:
                  'This app may show birthday notifications for employees. '
                  'You can enable or disable notifications anytime from '
                  'Settings → Notifications.',
            ),

            _buildSection(
              icon: Icons.dark_mode_outlined,
              title: '5. App Preferences',
              content:
                  'User preferences such as Dark Mode and Language settings '
                  'are stored locally on your device. '
                  'These preferences are never shared with third parties.',
            ),

            _buildSection(
              icon: Icons.security_outlined,
              title: '6. Security',
              content:
                  'We take reasonable steps to protect the information within '
                  'this app. Since no data is transmitted to external servers, '
                  'your information stays safe on your device.',
            ),

            _buildSection(
              icon: Icons.update_outlined,
              title: '7. Changes to This Policy',
              content:
                  'We may update this Privacy Policy from time to time. '
                  'Any changes will be reflected within the app. '
                  'Continued use of the app means you accept the updated policy.',
            ),

            _buildSection(
              icon: Icons.contact_mail_outlined,
              title: '8. Contact Us',
              content:
                  'If you have any questions about this Privacy Policy, '
                  'please contact us at:\n\n'
                  '📧 support@fluttertrainingapp.com\n'
                  '📍 Coimbatore, Tamil Nadu, India',
            ),

            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.verified_user, color: Colors.blue),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Your privacy is important to us. This app is designed '
                      'with privacy-first principles.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
          const Divider(height: 24),
        ],
      ),
    );
  }
}