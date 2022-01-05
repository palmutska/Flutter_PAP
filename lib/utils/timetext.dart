import 'package:flutter/material.dart';

class TimeText extends StatelessWidget {
  const TimeText({Key? key}) : super(key: key);

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Bom dia!';
    }
    if (hour < 19) {
      return 'Boa tarde!';
    }
    return 'Boa noite!';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      greeting(),
      style: const TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
