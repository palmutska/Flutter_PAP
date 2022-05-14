import 'package:app/models/user.dart';
import 'package:app/utils/type_img.dart';
import 'package:app/views/login_page.dart';
import 'package:flutter/material.dart';

class AccountData extends StatefulWidget {
  const AccountData({Key? key}) : super(key: key);

  @override
  _AccountDataState createState() => _AccountDataState();
}

class _AccountDataState extends State<AccountData> {
  List<TextSpan> showUser(User user) {
    List<TextSpan> text = [];
    text.add(TextSpan(children: [
      TextSpan(
          text: "Nome: " +
              user.name.toString() +
              " " +
              (user.type.toString().toLowerCase() == "aluno"
                  ? "(" + user.num.toString() + ") "
                  : "")),
      const WidgetSpan(
          child: Icon(
        Icons.person_outline,
        color: Colors.white,
        size: 32,
      ))
    ]));

    if (user.type.toString().toLowerCase() == "militar") {
      text.add(TextSpan(children: [
        TextSpan(text: "\nNIM: " + user.num.toString() + " "),
        const WidgetSpan(
            child: Icon(
          Icons.numbers_outlined,
          color: Colors.white,
          size: 32,
        ))
      ]));
    }
    text.add(TextSpan(children: [
      TextSpan(text: "\nTickets: " + user.tickets.toString() + " "),
      const WidgetSpan(
          child: Icon(
        Icons.confirmation_num_outlined,
        color: Colors.white,
        size: 32,
      ))
    ]));
    text.add(TextSpan(children: [
      const TextSpan(text: "\nDieta: "),
      WidgetSpan(
          child: user.dieta == "true"
              ? const Icon(
                  Icons.done,
                  color: Colors.green,
                  size: 32,
                )
              : const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 32,
                )),
    ]));
    text.add(
      TextSpan(
        children: [
          const TextSpan(text: "\nVegetariano: "),
          WidgetSpan(
            child: user.vegetariano == "true"
                ? const Icon(
                    Icons.done,
                    color: Colors.green,
                    size: 32,
                  )
                : const Icon(
                    Icons.close_outlined,
                    color: Colors.red,
                    size: 32,
                  ),
          ),
        ],
      ),
    );

    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TypeImage(user),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
              children: showUser(user),
            ),
          ),
        ],
      ),
    );
  }
}
