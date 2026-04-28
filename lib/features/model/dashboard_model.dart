import 'package:flutter/material.dart';

class DashboardModel {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  DashboardModel({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

final List<DashboardModel> dashList = [
  DashboardModel(title: 'Dashboard', icon: Icons.home_filled, onTap: () {}),
  DashboardModel(
    title: 'Analytics',
    icon: Icons.analytics_outlined,
    onTap: () {},
  ),
  DashboardModel(
    title: 'Projects',
    icon: Icons.shopping_bag_outlined,
    onTap: () {},
  ),
  DashboardModel(title: 'Customer', icon: Icons.group_outlined, onTap: () {}),
  DashboardModel(title: 'Orders', icon: Icons.border_horizontal, onTap: () {}),
  DashboardModel(
    title: 'Invoices',
    icon: Icons.newspaper_outlined,
    onTap: () {},
  ),
  DashboardModel(title: 'Team', icon: Icons.group, onTap: () {}),
  DashboardModel(title: 'Calender', icon: Icons.calendar_month, onTap: () {}),
  DashboardModel(title: 'Messages', icon: Icons.message, onTap: () {}),
  DashboardModel(title: 'Settings', icon: Icons.settings, onTap: () {}),
];
