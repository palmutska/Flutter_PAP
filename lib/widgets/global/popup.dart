import 'package:flutter/material.dart';

class ShowPopup extends StatefulWidget {
  final BuildContext buildContext;
  final String title, msg;
  const ShowPopup(
      {Key? key,
      required this.buildContext,
      required this.title,
      required this.msg})
      : super(key: key);

  @override
  _ShowPopupState createState() => _ShowPopupState();
}

class _ShowPopupState extends State<ShowPopup> {
  @override
  Widget build(BuildContext buildContext) {
    return AlertDialog(
      title: Text(
        widget.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 15),
                text: widget.msg,
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.green,
            ),
          ),
          label: const Text("Confirmar"),
          icon: const Icon(Icons.done),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
