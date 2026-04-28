import 'package:flutter/material.dart';

class AppColors {
  // Colors
  static const Color primaryBlue = Color(0xFF4F46E5);
  static const Color secondaryBlue = Colors.blue;
  static const Color sidebarDark = Color(0xFF0F172A);
  static const Color scaffoldBG = Color(0xFFF8FAFC);
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color sideBarSecondary = Color(0xFF94A3B8);
  static const Color successGreen = Color(0xFF10B981);

  // Styling
  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.03),
        blurRadius: 15,
        offset: const Offset(0, 5),
      ),
    ],
  );
}
