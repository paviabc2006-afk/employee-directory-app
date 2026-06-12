import 'package:flutter/material.dart';
import 'language_screen.dart';
import '../main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 36, 125, 214),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background3.jpg',
              fit: BoxFit.cover,
            ),
          ),

          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 10),

              Card(
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text("Notifications"),
                      subtitle: const Text("Enable app notifications"),
                      value: _notifications,
                      onChanged: (value) {
                        setState(() {
                          _notifications = value;
                        });
                      },
                    ),

                    const Divider(height: 1),

                    SwitchListTile(
                      title: const Text("Dark Mode"),
                      subtitle: const Text("Enable dark theme"),
                      value:
                          Theme.of(context).brightness ==
                          Brightness.dark,
                      onChanged: (value) {
                        MyApp.of(context)?.toggleTheme(value);
                      },
                    ),

                    const Divider(height: 1),

                    ListTile(
                      title: const Text("Language"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const LanguageScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "More",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 10),

              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text("Privacy Policy"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.pushNamed(context, '/privacy');
                      },
                    ),

                    const Divider(height: 1),

                    ListTile(
                      title: const Text("About"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.pushNamed(context, '/about');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}