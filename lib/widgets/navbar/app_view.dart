import 'package:app/widgets/global/background.dart';
import 'package:app/widgets/global/exit_button.dart';
import 'package:app/widgets/global/logo.dart';
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
        const Background(),
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
              ExitButton(),
              const LogoIPE(),
            ],
          ),
        ),
      ],
    );
  }
}
