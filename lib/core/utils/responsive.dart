import 'package:flutter/cupertino.dart';

class Responsive {
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static bool isMobile(BuildContext context) => width(context) < 650;

  static bool isTablet(BuildContext context) =>
      width(context) >= 650 && width(context) < 1100;

  static bool isDesktop(BuildContext context) => width(context) >= 1100;
}
