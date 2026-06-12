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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        color: isDark
            ? Colors.grey[850]!.withValues(alpha: 0.5)  
            : Colors.white.withValues(alpha: 0.45),    
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: colorScheme.primary,          
                child: Text(
                  employee.name[0],
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,                        
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,           
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      employee.id,
                      style: TextStyle(
                        fontSize: 13,
                        color: colorScheme.onSurface.withValues(alpha: 0.6), 
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      employee.department,
                      style: TextStyle(
                        fontSize: 13,
                        color: colorScheme.primary,             
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: colorScheme.onSurface.withValues(alpha: 0.5), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}