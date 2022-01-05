import 'package:flutter/material.dart';

class LogoIPE extends StatelessWidget {
  const LogoIPE({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      width: 200,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/images/ipeLogo.png'),
      ),
    );
  }
}
