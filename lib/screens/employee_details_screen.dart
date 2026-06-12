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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
        backgroundColor: const Color.fromARGB(255, 15, 82, 150),
        foregroundColor: const Color.fromARGB(255, 247, 242, 242),
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
          // Content
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: colorScheme.primary,        
                    child: Text(
                      employee.name[0],
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.white,                      
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    employee.name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black, 
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.15), 
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      employee.department,
                      style: TextStyle(
                        color: colorScheme.primary,               
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Card(
                    elevation: 5,
                    color: isDark
                        ? Colors.black.withValues(alpha: 0.55)   
                        : Colors.white.withValues(alpha: 0.75),  
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}