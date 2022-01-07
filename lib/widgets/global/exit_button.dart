import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ExitButton extends StatelessWidget {
  final DatabaseReference ref = FirebaseDatabase.instance.ref("server");

  ExitButton({Key? key}) : super(key: key);

  void _setCardNone() async {
    await ref.update({
      "currentCard": "null",
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 5,
      child: GestureDetector(
        onTap: _setCardNone,
        child: Image.asset("assets/images/logout.png"),
      ),
    );
  }
}
