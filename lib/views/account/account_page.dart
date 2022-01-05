import 'package:app/views/account/account_data.dart';
import 'package:app/views/login_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseDatabase.instance
          .ref()
          .child("server/users/" + currentCard)
          .once(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              Positioned(
                left: (MediaQuery.of(context).size.width / 2) - 460,
                bottom: MediaQuery.of(context).size.height / 2 - 200,
                child: DefaultTextStyle(
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      AccountData(),
                    ],
                  ),
                ),
              )
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
