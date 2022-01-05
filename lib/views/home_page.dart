import 'package:app/utils/timetext.dart';
import 'package:app/widgets/global/background.dart';
import 'package:app/widgets/global/logo.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        const LogoIPE(),
        DefaultTextStyle(
          style: const TextStyle(
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
          child: Positioned(
              top: 230,
              left: 700,
              child: Column(
                children: const [
                  TimeText(),
                  Text(
                    "Passe o cartão para continuar",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              )),
        ),
        Positioned(
          top: 150,
          left: -50,
          child: Image.asset(
            "assets/images/rfidScanner.png",
            width: 600,
          ),
        )
      ],
    );
  }
}
