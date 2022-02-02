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
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.msg),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}
