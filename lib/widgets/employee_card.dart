import 'package:flutter/material.dart';
import '../models/employee_model.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;
  final VoidCallback onTap;

  const EmployeeCard({
    super.key,
    required this.employee,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Profile Avatar
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color.fromARGB(255, 190, 18, 84),
                child: Text(
                  employee.name[0],
                  style: const TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 214, 198, 198),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Employee Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      employee.id,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 221, 14, 14),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      employee.department,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 12, 68, 165),
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow Icon
              const Icon(Icons.arrow_forward_ios, size: 16, color: Color.fromARGB(255, 167, 8, 8)),
            ],
          ),
        ),
      ),
    );
  }
}


