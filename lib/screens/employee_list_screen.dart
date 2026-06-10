import 'package:flutter/material.dart';
import '../models/employee_model.dart';
import '../widgets/employee_card.dart';
import 'employee_details_screen.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees'),
        backgroundColor: const Color.fromARGB(255, 89, 86, 139),
        foregroundColor: const Color.fromARGB(255, 236, 232, 232),
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
          ListView.builder(
            itemCount: employeeList.length,
            itemBuilder: (context, index) {
              final employee = employeeList[index];
              return EmployeeCard(
                employee: employee,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployeeDetailsScreen(
                        employee: employee,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}