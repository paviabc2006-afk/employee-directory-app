
import 'package:flutter/material.dart';
import '../constants/app_strings.dart';
import '../models/employee_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/profile_info_tile.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using first employee as logged-in user
    final Employee user = employeeList[0];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Text(
                user.name[0],
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // User Name
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            // Department Badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                user.department,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Info Tiles
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ProfileInfoTile(
                    icon: Icons.badge,
                    label: 'Employee ID',
                    value: user.id,
                  ),
                  const Divider(height: 1),
                  ProfileInfoTile(
                    icon: Icons.email,
                    label: 'Email',
                    value: user.email,
                  ),
                  const Divider(height: 1),
                  ProfileInfoTile(
                    icon: Icons.phone,
                    label: 'Mobile',
                    value: user.mobile,
                  ),
                  const Divider(height: 1),
                  ProfileInfoTile(
                    icon: Icons.work,
                    label: 'Department',
                    value: user.department,
                  ),
                  const Divider(height: 1),
                  ProfileInfoTile(
                    icon: Icons.location_on,
                    label: 'Location',
                    value: user.location,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Buttons
            CustomButton(
              label: AppStrings.editProfile,
              icon: Icons.edit,
              color: const Color.fromARGB(255, 7, 10, 10),
            ),
            const SizedBox(height: 12),
            CustomButton(
              label: AppStrings.openSettings,
              icon: Icons.settings,
              color: const Color.fromARGB(255, 224, 136, 4),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
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


