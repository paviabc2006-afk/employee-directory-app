import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Application'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Logo & Name
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.phone_android,
                      size: 80,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Flutter Training App',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),

            // About Section
            _buildSection(
              icon: Icons.info_outline,
              title: 'About',
              content:
                  'Flutter Training App is a multi-screen Employee Directory '
                  'Application built using Flutter. It is designed to demonstrate '
                  'core Flutter concepts including navigation, state management, '
                  'reusable widgets, and clean folder structure.',
            ),

            _buildSection(
              icon: Icons.featured_play_list_outlined,
              title: 'Features',
              content:
                  '• Employee Directory with detailed profiles\n'
                  '• Birthday Wish Notification\n'
                  '• Dark Mode Support\n'
                  '• Settings & Preferences\n'
                  '• Privacy Policy\n'
                  '• Clean & Responsive UI',
            ),

            _buildSection(
              icon: Icons.code_outlined,
              title: 'Technology',
              content:
                  '• Framework: Flutter\n'
                  '• Language: Dart\n'
                  '• Architecture: Clean Folder Structure\n'
                  '• UI: Material Design 3',
            ),

            _buildSection(
              icon: Icons.person_outline,
              title: 'Developer',
              content:
                  '• Developed by: Flutter Training Batch\n'
                  '• Organization: ELCOT\n'
                  '• Location: Tamil Nadu, India\n'
                  '• Email: training@elcot.in',
            ),

            _buildSection(
              icon: Icons.update_outlined,
              title: 'Release Info',
              content:
                  '• Release Date: June 2025\n'
                  '• Platform: Android\n'
                  '• Min SDK: Android 5.0+',
            ),

            const SizedBox(height: 10),

            // Footer
            Center(
              child: Column(
                children: [
                  const Text(
                    'Made with ❤️ using Flutter',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '© 2025 Flutter Training App',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
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