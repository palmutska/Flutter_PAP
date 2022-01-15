import 'package:app/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/images/almoco.jpeg"), context);
    precacheImage(const AssetImage("assets/images/jantar.jpg"), context);
    precacheImage(const AssetImage("assets/images/primeira.png"), context);
    precacheImage(const AssetImage("assets/images/segunda.png"), context);
    precacheImage(const AssetImage("assets/images/tipoDieta.jpg"), context);
    precacheImage(const AssetImage("assets/images/tipoNormal.jpg"), context);
    precacheImage(
        const AssetImage("assets/images/tipoVegetariano.jpg"), context);

    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
