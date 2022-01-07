import 'package:app/utils/type_img.dart';
import 'package:app/views/login_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:app/models/user.dart';

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
    return FutureBuilder<User>(
      future: getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(child: Text("Erro"));
          }
          if (snapshot.hasData) {
            return Center(
              child: Row(
                children: [
                  TypeImage(snapshot.data!),
                  Column(
                    children: [
                      Text.rich(snapshot.data?.type != "Aluno"
                          ? TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "Nome: " + snapshot.data!.name.toString(),
                                ),
                                TextSpan(
                                  text: "\nCargo: " +
                                      snapshot.data!.type.toString(),
                                ),
                                TextSpan(
                                  text: "\nTickets: " +
                                      snapshot.data!.tickets.toString(),
                                ),
                              ],
                            )
                          : TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "Nome: " + snapshot.data!.name.toString(),
                                ),
                                TextSpan(
                                  text:
                                      "\nNum: " + snapshot.data!.num.toString(),
                                ),
                                TextSpan(
                                  text: "\nCargo: " +
                                      snapshot.data!.type.toString(),
                                ),
                                TextSpan(
                                  text: "\nRegime: " +
                                      snapshot.data!.regime.toString(),
                                ),
                              ],
                            ))
                    ],
                  ),
                ],
              ),
            );
          } else {
            const CircularProgressIndicator();
          }
        } else {
          const CircularProgressIndicator();
        }
        return Container();
      },
    );
  }
}

Future<User> getUserData() async {
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
  DatabaseReference refReg =
      FirebaseDatabase.instance.ref("server/users/" + currentCard + "/regime");
  String regime = "";
  refReg.onValue.listen((event) {
    var snapshot = event.snapshot;

    regime = snapshot.value.toString();
  });
  DatabaseReference refTicket =
      FirebaseDatabase.instance.ref("server/users/" + currentCard + "/tickets");
  String tickets = "";
  refTicket.onValue.listen((event) {
    var snapshot = event.snapshot;
    tickets = snapshot.value.toString();
  });

  if (type == "Aluno") {
    return User(
        name: name, num: num, regime: regime, tickets: tickets, type: type);
  } else {
    return User(name: name, tickets: tickets, type: type);
  }
}
