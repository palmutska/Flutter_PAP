import 'package:app/models/user.dart';
import 'package:app/views/login_page.dart';
import 'package:app/widgets/global/background.dart';
import 'package:app/widgets/global/exit_button.dart';
import 'package:app/widgets/global/logo.dart';
import 'package:app/widgets/num_pad.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RegisterCard extends StatefulWidget {
  const RegisterCard({Key? key}) : super(key: key);

  @override
  State<RegisterCard> createState() => _RegisterCardState();
}

class _RegisterCardState extends State<RegisterCard> {
  final TextEditingController _myController = TextEditingController();

  void unverifiedToVerified(User user) async {
    DatabaseReference newUser =
        FirebaseDatabase.instance.ref("server/verifiedUsers");

    FirebaseDatabase.instance
        .ref("server/unverifiedUsers/" + user.id.toString())
        .remove();

    await newUser.update({
      currentCard.toString() + "/name": user.name,
      currentCard.toString() + "/num": user.num,
      currentCard.toString() + "/regime": user.regime,
      currentCard.toString() + "/tickets": user.tickets,
      currentCard.toString() + "/type": user.type,
    });
  }

  void onSubmit() {
    Map<String, dynamic> unverifiedUsers = {};

    DatabaseReference refUnverifiedUsers =
        FirebaseDatabase.instance.ref("server/unverifiedUsers");
    //! Fix This
    //* VAMBORA MAQUINAAAA
    refUnverifiedUsers.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<String, dynamic>;
        unverifiedUsers = data;
      }
    });

    if (unverifiedUsers.keys.toList().contains(_myController.text)) {
      User user = User();
      unverifiedUsers.forEach((key, value) {
        user.id = key.toString();
        user.name = value["name"].toString();
        user.num = value["num"].toString();
        user.regime = value["regime"].toString();
        user.tickets = value["tickets"].toString();
        user.type = value["type"].toString();
      });
      unverifiedToVerified(user);
    } else {
      print("Nao tem");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          const LogoIPE(),
          ExitButton(),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 500,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.transparent.withOpacity(0.15),
                  ),
                  child: DefaultTextStyle(
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                    child: Column(
                      children: [
                        const Text(
                          "\nEste cartão ainda não está registado.\n",
                        ),
                        const Text(
                          "Digite o código fornecido pelo CAL para",
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "registá-lo!",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40, left: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.transparent.withOpacity(0.15),
                    ),
                    width: 450,
                    height: 550,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: SizedBox(
                            height: 70,
                            child: Center(
                                child: TextField(
                              controller: _myController,
                              textAlign: TextAlign.center,
                              showCursor: false,
                              style: const TextStyle(fontSize: 40),
                              // Disable the default soft keybaord
                              keyboardType: TextInputType.none,
                            )),
                          ),
                        ),
                        // implement the custom NumPad
                        NumPad(
                          buttonSize: 75,
                          buttonColor: Colors.transparent,
                          deleteColor: Colors.red,
                          confirmColor: Colors.green,
                          controller: _myController,
                          delete: () {
                            _myController.text = _myController.text
                                .substring(0, _myController.text.length - 1);
                          },
                          // do something with the input numbers
                          onSubmit: onSubmit,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
