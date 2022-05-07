import 'package:app/models/user.dart';
import 'package:app/utils/type_img.dart';
import 'package:app/views/login_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AccountData extends StatefulWidget {
  const AccountData({Key? key}) : super(key: key);

  @override
  _AccountDataState createState() => _AccountDataState();
}

class _AccountDataState extends State<AccountData> {
  Future<User> getUser() async {
    User user = User();

    final ref =
        FirebaseDatabase.instance.ref("server/verifiedUsers/" + currentCard);
    final snapshot = await ref.get();
    user.name = snapshot.child("name").value.toString();
    user.num = snapshot.child("num").value.toString();
    user.regime = snapshot.child("regime").value.toString();
    user.tickets = snapshot.child("tickets").value.toString();
    user.type = snapshot.child("type").value.toString();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    //?Devo receber o user no login ou apenas aqui???
    return FutureBuilder<User>(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TypeImage(snapshot.data!),
                RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(children: [
                          TextSpan(
                              text: "Nome: " +
                                  snapshot.data!.name.toString() +
                                  " "),
                          const WidgetSpan(
                              child: Icon(
                            Icons.person_outline,
                            size: 32,
                          ))
                        ]),
                        TextSpan(children: [
                          TextSpan(
                              text: "\nNº: " +
                                  snapshot.data!.num.toString() +
                                  " "),
                          const WidgetSpan(
                              child: Icon(
                            Icons.badge_outlined,
                            size: 32,
                          ))
                        ]),
                        TextSpan(children: [
                          TextSpan(
                              text: "\nRegime: " +
                                  snapshot.data!.regime.toString() +
                                  " "),
                          const WidgetSpan(
                              child: Icon(
                            Icons.house_outlined,
                            size: 32,
                          ))
                        ]),
                        TextSpan(children: [
                          TextSpan(
                              text: "\nTickets: " +
                                  snapshot.data!.tickets.toString() +
                                  " "),
                          const WidgetSpan(
                              child: Icon(
                            Icons.local_activity_outlined,
                            size: 32,
                          ))
                        ]),
                      ],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      )),
                )
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
