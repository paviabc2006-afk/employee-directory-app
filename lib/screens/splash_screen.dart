import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:firebase_messaging/firebase_messaging.dart';
import '../constants/app_strings.dart';
import '../screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _token = 'Loading...';

  @override
  void initState() {
    super.initState();
    _getTokenAndNavigate();
  }

  void _getTokenAndNavigate() async {
    // FCM Token எடு
    final token = await FirebaseMessaging.instance.getToken();
    if (mounted) {
      setState(() {
        _token = token ?? 'Token not found';
      });
    }

    // 5 seconds காட்டு (copy பண்ண time கொடு)
    await Future.delayed(const Duration(seconds: 5));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/images/background.jpg'), context);
    precacheImage(const AssetImage('assets/images/background1.jpg'), context);
    precacheImage(const AssetImage('assets/images/background2.jpg'), context);
    precacheImage(const AssetImage('assets/images/background3.jpg'), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 187, 198, 207),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.phone_android,
              size: 100,
              color: Color.fromARGB(255, 41, 7, 7),
            ),
            const SizedBox(height: 20),
            const Text(
              AppStrings.appName,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 22, 22, 22),
              ),
            ),
            const SizedBox(height: 20),

            // FCM Token display
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  // Tap பண்ணா copy ஆகும்
                  final data = ClipboardData(text: _token);
                  Clipboard.setData(data);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Token copied!')),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'FCM Token (Tap to copy):',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _token,
                        style: const TextStyle(fontSize: 9),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}