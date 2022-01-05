import 'package:app/routes/routes.dart';
import 'package:app/routes/routes_generator.dart';
import 'package:app/views/home_page.dart';
import 'package:app/widgets/navbar/app_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

String currentCard = "null2";

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    DatabaseReference ref = FirebaseDatabase.instance.ref("server/currentCard");
    Stream<DatabaseEvent> stream = ref.onValue;

    stream.listen((DatabaseEvent event) {
      setState(() {
        currentCard = event.snapshot.value.toString();
      });
    });
    currentCard = currentCard;
    if (currentCard != "null") {
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
  }
}
