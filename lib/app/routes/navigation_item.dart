import 'package:flutter/widgets.dart';

class NavigationItem {
  final IconData icon;
  final String label;
  final String route;

  NavigationItem({
    required this.icon,
    required this.label,
    required this.route,
  });

  BottomNavigationBarItem toBottomNavItem() {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }
}
