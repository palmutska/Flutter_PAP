import 'package:app/models/user.dart';
import 'package:app/routes/routes.dart';
import 'package:app/routes/routes_generator.dart';
import 'package:app/views/home_page.dart';
import 'package:app/views/register_card.dart';
import 'package:app/widgets/navbar/app_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

String currentCard = "null";
User user = User();

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<User> getUser() async {
    String name, num, regime, type, nif, vegetariano, dieta;

    final ref =
        FirebaseDatabase.instance.ref("server/verifiedUsers/" + currentCard);

    final refLogs = FirebaseDatabase.instance.ref("server/logs/");

    final snapshot = await ref.get();
    name = snapshot.child("name").value.toString();
    num = snapshot.child("num").value.toString();
    regime = snapshot.child("regime").value.toString();
    type = snapshot.child("type").value.toString();
    nif = snapshot.child("nif").value.toString();
    vegetariano = snapshot.child("vegetariano").value.toString();
    dieta = snapshot.child("dieta").value.toString();
    User user = User(
        name: name,
        nif: nif,
        num: num,
        regime: regime,
        type: type,
        vegetariano: vegetariano,
        dieta: dieta);

    refLogs.push().set({
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'event': "userLogin",
      'userName': name,
      'userNIF': nif,
      'userCardID': currentCard,
      'msg': "O utilizador entrou na conta",
    });

    return user;
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference refCurrentCard =
        FirebaseDatabase.instance.ref("server/currentCard");
    Stream<DatabaseEvent> streamCurrentCard = refCurrentCard.onValue;

    DatabaseReference refUsers =
        FirebaseDatabase.instance.ref("server/verifiedUsers");
    Stream<DatabaseEvent> streamUsers = refUsers.onValue;

    streamCurrentCard.listen((DatabaseEvent event) {
      setState(() {
        currentCard = event.snapshot.value.toString().replaceAll(" ", "");
      });
    });

    var users = [];

    streamUsers.listen((DatabaseEvent event) {
      for (var user in event.snapshot.children) {
        users.add(user.key);
      }
    });
    if (currentCard == "null") {
      return const HomePage();
    } else if (users.contains(currentCard)) {
      return FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            user = snapshot.data as User;
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Refeições',
              builder: (_, child) => AppView(
                child: child!,
              ),
              initialRoute: routeBooking,
              navigatorKey: navKey,
              onGenerateRoute: RouteGenerator.generateRoute,
            );
          } else {
            return const HomePage();
          }
        },
      );
    } else {
      return const RegisterCard();
    }
  }
}
