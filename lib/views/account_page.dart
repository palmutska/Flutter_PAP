import 'package:app/widgets/account_data.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: (MediaQuery.of(context).size.width / 2) - 460,
          bottom: MediaQuery.of(context).size.height / 2 - 200,
          child: const DefaultTextStyle(
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            child: AccountData(),
          ),
        )
      ],
    );
  }
}
