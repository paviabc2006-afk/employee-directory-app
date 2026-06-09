import 'package:flutter/material.dart';
import '../models/employee_model.dart';
import '../widgets/profile_info_tile.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  final Employee employee;

  const EmployeeDetailsScreen({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
        backgroundColor: const Color.fromARGB(255, 15, 82, 150),
        foregroundColor: const Color.fromARGB(255, 247, 242, 242),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: const Color.fromARGB(255, 152, 173, 194),
              child: Text(
                employee.name[0],
                style: const TextStyle(
                  fontSize: 40,
                  color: Color.fromARGB(255, 224, 216, 216),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Employee Name
            Text(
              employee.name,
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
                color: const Color.fromARGB(255, 195, 241, 239),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                employee.department,
                style: const TextStyle(
                  color: Color.fromARGB(255, 40, 104, 104),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Info Tiles
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ProfileInfoTile(
                    icon: Icons.badge,
                    label: 'Employee ID',
                    value: employee.id,
                  ),
                  const Divider(height: 2),
                  ProfileInfoTile(
                    icon: Icons.email,
                    label: 'Email',
                    value: employee.email,
                  ),
                  const Divider(height: 2),
                  ProfileInfoTile(
                    icon: Icons.phone,
                    label: 'Mobile',
                    value: employee.mobile,
                  ),
                  const Divider(height: 2),
                  ProfileInfoTile(
                    icon: Icons.work,
                    label: 'Department',
                    value: employee.department,
                  ),
                  const Divider(height: 2),
                  ProfileInfoTile(
                    icon: Icons.location_on,
                    label: 'Location',
                    value: employee.location,
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


