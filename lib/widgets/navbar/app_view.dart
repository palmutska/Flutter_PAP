import 'package:flutter/material.dart';
import 'package:app/widgets/navbar/navigation_bar.dart';

class AppView extends StatelessWidget {
  final Widget child;

  // ignore: use_key_in_widget_constructors
  const AppView({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Column(
                children: [
                  const NavigationBarWeb(),
                  Expanded(child: child),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
