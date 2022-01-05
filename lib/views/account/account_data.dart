import 'package:app/utils/type_img.dart';
import 'package:app/views/login_page.dart';
import 'package:app/widgets/global/background.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AccountData extends StatefulWidget {
  const AccountData({Key? key}) : super(key: key);

  @override
  _AccountDataState createState() => _AccountDataState();
}

class _AccountDataState extends State<AccountData> {
  DatabaseReference ref =
      FirebaseDatabase.instance.ref("server/users/" + currentCard);

  @override
  Widget build(BuildContext context) {
    //* Name
    DatabaseReference refName =
        FirebaseDatabase.instance.ref("server/users/" + currentCard + "/name");
    String name = "";
    refName.onValue.listen((event) {
      var snapshot = event.snapshot;

      name = snapshot.value.toString();
    });
    //* Type
    DatabaseReference refType =
        FirebaseDatabase.instance.ref("server/users/" + currentCard + "/type");
    String type = "";
    refType.onValue.listen((event) {
      var snapshot = event.snapshot;

      type = snapshot.value.toString();
    });
    //* Num (Aluno)
    DatabaseReference refNum =
        FirebaseDatabase.instance.ref("server/users/" + currentCard + "/num");
    String num = "";
    refNum.onValue.listen((event) {
      var snapshot = event.snapshot;

      num = snapshot.value.toString();
    });
    //* Regime (Aluno)
    DatabaseReference refReg = FirebaseDatabase.instance
        .ref("server/users/" + currentCard + "/regime");
    String regime = "";
    refReg.onValue.listen((event) {
      var snapshot = event.snapshot;

      regime = snapshot.value.toString();
    });
    DatabaseReference refTicket = FirebaseDatabase.instance
        .ref("server/users/" + currentCard + "/tickets");
    String tickets = "";
    refTicket.onValue.listen((event) {
      var snapshot = event.snapshot;
      tickets = snapshot.value.toString();
    });

    String path = "";

    switch (type) {
      case "Aluno":
        path = "aluno";
        break;
      case "Professor":
        path = "professor";
        break;
      case "Militar":
        path = "militar";
        break;
      case "Funcionário":
        path = "funcionario";
        break;
    }

    return DefaultTextStyle(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      child: Row(
        children: [
          TypeImage(path),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              type != "Aluno"
                  ? Text.rich(TextSpan(children: [
                      TextSpan(text: "Nome: " + name),
                      TextSpan(text: "\nTipo: " + type),
                      TextSpan(text: "\nTickets: " + tickets),
                    ]))
                  : Text.rich(TextSpan(children: [
                      TextSpan(text: "Nome: " + name),
                      TextSpan(text: "\nNum: " + num),
                      TextSpan(text: "\nTipo: " + type),
                      TextSpan(text: "\nRegime: " + regime),
                    ]))
            ],
          ),
        ],
      ),
    );
  }
}
