import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppTextStyles {
  // Main Heading (e.g., "Welcome back, John!")
  static TextStyle heading = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF1E293B),
    letterSpacing: -0.5,
  );

  // Card Titles (e.g., "Total Revenue")
  static TextStyle cardTitle = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF64748B),
    letterSpacing: 0.1,
  );

  // Large Metrics (e.g., "$45,231.89")
  static TextStyle metric = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF1E293B),
    height: 1.2,
  );

  // Sidebar Menu Items
  static TextStyle sidebarItem = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: Colors.white.withValues(alpha: 0.7),
  );

  // Percentages/Growth Labels (e.g., "12.5%")
  static TextStyle growthLabel = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF10B981),
  );

  // Caption/Small Data
  static TextStyle caption = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF94A3B8),
  );
}
