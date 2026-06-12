import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'English';

  final List<Map<String, String>> _languages = [
    {'name': 'English', 'native': 'English', 'flag': '🇬🇧'},
    {'name': 'Tamil', 'native': 'தமிழ்', 'flag': '🇮🇳'},
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Language'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Overlay
          Positioned.fill(
            child: Container(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.75)
                  : Colors.white.withValues(alpha: 0.85),
            ),
          ),
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current Language
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1), 
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: colorScheme.primary.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.language, color: colorScheme.primary), 
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Language',
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurface.withValues(alpha: 0.6), 
                          ),
                        ),
                        Text(
                          _selectedLanguage,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary, 
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Select Language',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface, 
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Language List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _languages.length,
                  itemBuilder: (context, index) {
                    final lang = _languages[index];
                    final isSelected = _selectedLanguage == lang['name'];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      color: colorScheme.surface.withValues(alpha: 0.85),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isSelected
                              ? colorScheme.primary  
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: ListTile(
                        leading: Text(
                          lang['flag']!,
                          style: const TextStyle(fontSize: 28),
                        ),
                        title: Text(
                          lang['name']!,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface, 
                          ),
                        ),
                        subtitle: Text(
                          lang['native']!,
                          style: TextStyle(
                            color: colorScheme.onSurface.withValues(alpha: 0.6), 
                          ),
                        ),
                        trailing: isSelected
                            ? Icon(Icons.check_circle, color: colorScheme.primary) 
                            : Icon(Icons.circle_outlined,
                                color: colorScheme.onSurface.withValues(alpha: 0.4)),
                        onTap: () {
                          setState(() {
                            _selectedLanguage = lang['name']!;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${lang['name']} selected'),
                              backgroundColor: colorScheme.primary, 
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}