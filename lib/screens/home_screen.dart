import 'package:flutter/material.dart';
import '../constants/app_strings.dart';
import '../models/employee_model.dart';
import '../providers/notification_provider.dart';
import 'employee_list_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'birthday_wish_screen.dart';
import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final _provider = NotificationProvider();

  final List<Widget> _screens = [
    const HomeContent(),
    const EmployeeListScreen(),
    const ProfileScreen(),
  ];

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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: isDark
            ? Colors.white
            : const Color.fromARGB(255, 125, 178, 221),
        unselectedItemColor: isDark
            ? Colors.white60
            : const Color.fromARGB(255, 51, 56, 33),
        selectedFontSize: 18,
        unselectedFontSize: 15,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Employees'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
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

  Employee? get _todayBirthdayEmp {
    final now = DateTime.now();
    final today =
        '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
    try {
      return employeeList.firstWhere((e) => e.birthday == today);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final birthdayEmp = _todayBirthdayEmp;
    final unreadCount = _provider.unreadCount;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter App',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 36, 125, 214),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationScreen(),
                  ),
                );
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.notifications,
                      color: Color.fromARGB(255, 250, 248, 248)),
                  if (unreadCount > 0)
                    Positioned(
                      top: -6,
                      right: -6,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          unreadCount > 9 ? '9+' : '$unreadCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background4.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? const Color.fromARGB(255, 2, 1, 1)
                              : Colors.black87,
                        ),
                      ),
                      Text(
                        'Have a great day',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? const Color.fromARGB(179, 0, 0, 0)
                              : Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 20),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.1,
                        children: [
                          _buildCard(
                            context,
                            icon: Icons.people,
                            title: 'Employees',
                            subtitle: 'View Directory',
                            color: const Color.fromARGB(255, 0, 0, 0),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const EmployeeListScreen(),
                                ),
                              );
                            },
                          ),
                          _buildCard(
                            context,
                            icon: Icons.person,
                            title: 'Profile',
                            subtitle: 'Details',
                            color: const Color.fromARGB(255, 0, 0, 0),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProfileScreen(),
                                ),
                              );
                            },
                          ),
                          _buildCard(
                            context,
                            icon: Icons.settings,
                            title: 'Settings',
                            subtitle: 'Preferences',
                            color: isDark
                                ? const Color.fromARGB(255, 2, 1, 1)
                                : const Color.fromARGB(255, 5, 5, 5),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SettingsScreen(),
                                ),
                              );
                            },
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color.fromARGB(255, 97, 19, 45)
                                      .withValues(alpha: 0.1)
                                  : const Color.fromARGB(255, 68, 5, 87)
                                      .withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: Colors.blueAccent
                                      .withValues(alpha: 0.3)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.bar_chart,
                                    size: 36,
                                    color: isDark
                                        ? const Color.fromARGB(255, 0, 0, 0)
                                        : const Color.fromARGB(255, 0, 0, 0)),
                                const SizedBox(height: 8),
                                Text(
                                  'Short description',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? const Color.fromARGB(255, 44, 21, 21)
                                        : const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${employeeList.length} Employees Active',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? const Color.fromARGB(255, 3, 2, 2)
                                        : const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: isDark
                    ? Colors.pink.withValues(alpha: 0.2)
                    : const Color.fromARGB(255, 236, 202, 213),
                child: birthdayEmp != null
                    ? ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BirthdayWishScreen(
                                birthdayEmployee: birthdayEmp,
                              ),
                            ),
                          );
                        },
                        icon: const Text('🎂', style: TextStyle(fontSize: 18)),
                        label: Text(
                          "Today's Birthday - ${birthdayEmp.name.split(' ')[0]}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(120),
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(120),
                        ),
                        child: const Text(
                          '🎈No one Has Birthday today!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    VoidCallback? onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? const Color.fromARGB(255, 153, 140, 140).withValues(alpha: 0.5)
              : const Color.fromARGB(255, 68, 5, 87).withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(31, 0, 0, 0),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? const Color.fromARGB(255, 3, 2, 2)
                    : Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? const Color.fromARGB(135, 0, 0, 0)
                    : Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}