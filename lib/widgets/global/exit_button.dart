import 'package:app/views/login_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ExitButton extends StatelessWidget {
  final DatabaseReference ref = FirebaseDatabase.instance.ref("server");
  final refLogs = FirebaseDatabase.instance.ref("server/logs/");

  ExitButton({Key? key}) : super(key: key);

  void _setCardNone() {
    refLogs.push().set({
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'event': "userLogout",
      'userName': user.name,
      'userNIF': user.nif,
      'userCardID': currentCard,
      'msg': "O utilizador saiu da conta",
    });
    ref.update({
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
