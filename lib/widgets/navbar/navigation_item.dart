import 'package:flutter/material.dart';
import 'package:app/routes/routes.dart';
import 'package:app/widgets/navbar/interactive_nav_item.dart';

class NavigationItem extends StatelessWidget {
  final String title, routeName;
  final Icon icon;

  // ignore: use_key_in_widget_constructors
  const NavigationItem(
      {required this.title, required this.routeName, required this.icon});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.5,
      ),
      child: GestureDetector(
        onTap: () {
          navKey.currentState?.pushNamed(routeName);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          child: InteractiveNavItem(
            child: Text(title),
            text: title,
            icon: icon,
          ),
        ),
      ),
    );
  }
}
