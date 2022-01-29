import 'package:app/widgets/booking/selectDate/calendar.dart';
import 'package:app/widgets/global/options_top_text.dart';
import 'package:flutter/material.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({Key? key}) : super(key: key);

  @override
  _SelectDateState createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: const [
        TopText("Selecione uma data"),
        Calendar(),
      ],
    ));
  }
}
