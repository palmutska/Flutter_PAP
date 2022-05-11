import 'package:app/routes/routes.dart';
import 'package:app/routes/routes_generator.dart';
import 'package:app/views/home_page.dart';
import 'package:app/views/register_card.dart';
import 'package:app/widgets/navbar/app_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

String currentCard = "null";

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      return const RegisterCard();
    }
  }
}
