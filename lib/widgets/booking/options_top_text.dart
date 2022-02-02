import 'package:flutter/material.dart';

class TopText extends StatefulWidget {
  final String text;

  const TopText(this.text, {Key? key}) : super(key: key);

  @override
  _TopTextState createState() => _TopTextState();
}

class _TopTextState extends State<TopText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        widget.text,
        style: const TextStyle(
          fontSize: 28,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
