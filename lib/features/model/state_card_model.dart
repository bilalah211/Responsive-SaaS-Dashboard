import 'package:dashpro/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StateCardModel {
  final String title;
  final String subTitle;
  final IconData cIcon;
  final String growthText;
  final Color color;
  final double? iconSize;

  StateCardModel({
    required this.title,
    required this.subTitle,
    required this.cIcon,
    required this.growthText,
    required this.color,
    this.iconSize,
  });

  double get parseIconSize => iconSize ?? 18;
}

List<StateCardModel> stateCardItems = [
  StateCardModel(
    title: 'Total Revenue',
    subTitle: '45,231.39',
    cIcon: Icons.wallet,
    growthText: '↑ 12.5%',
    color: AppColors.secondaryBlue,
    iconSize: 18,
  ),
  StateCardModel(
    title: 'Total Orders',
    subTitle: '2,950',
    cIcon: Icons.shopping_cart_outlined,
    growthText: '↑ 8.3%',
    color: Colors.purple,
    iconSize: 18,
  ),
  StateCardModel(
    title: 'Total Customers',
    subTitle: '856',
    cIcon: Icons.group_outlined,
    growthText: '↑ 6.7%',
    color: Colors.green,
    iconSize: 18,
  ),
  StateCardModel(
    title: 'Total Profit',
    subTitle: '12,671.49',
    cIcon: Icons.currency_exchange,
    growthText: '↑ 10.5%',
    color: Colors.deepOrangeAccent,
    iconSize: 16,
  ),
];
