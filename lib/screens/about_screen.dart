import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('About Application'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background2.jpg',
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
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.phone_android,
                          size: 80,
                          color: colorScheme.primary,
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
                      Text(
                        'Version 1.0.0',
                        style: TextStyle(
                          fontSize: 18,
                          color: colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),

                _buildSection(
                  context: context,
                  icon: Icons.info_outline,
                  title: 'About',
                  content:
                      'Flutter Training App is a multi-screen Employee Directory Application built using Flutter. It is designed to demonstrate core Flutter concepts including navigation, state management, reusable widgets, and clean folder structure.',
                ),

                _buildSection(
                  context: context,
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
                  context: context,
                  icon: Icons.code_outlined,
                  title: 'Technology',
                  content:
                      '• Framework: Flutter\n'
                      '• Language: Dart\n'
                      '• Architecture: Clean Folder Structure\n'
                      '• UI: Material Design 3',
                ),

                _buildSection(
                  context: context,
                  icon: Icons.person_outline,
                  title: 'Developer',
                  content:
                      '• Developed by: Flutter Training Batch\n'
                      '• Organization: ELCOT\n'
                      '• Location: Tamil Nadu, India\n'
                      '• Email: training@elcot.in',
                ),

                _buildSection(
                  context: context,
                  icon: Icons.update_outlined,
                  title: 'Release Info',
                  content:
                      '• Release Date: June 2026\n'
                      '• Platform: Android\n'
                      '• Min SDK: Android 5.0+',
                ),

                const SizedBox(height: 10),

                Center(
                  child: Column(
                    children: [
                      Text(
                        'Made with ❤️ using Flutter',
                        style: TextStyle(
                          fontSize: 16,
                          color: colorScheme.onSurface.withOpacity(0.75),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '© 2026 Flutter Training App',
                        style: TextStyle(
                          fontSize: 13,
                          color: colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
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