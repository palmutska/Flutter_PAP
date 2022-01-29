import 'package:app/widgets/booking/selectDate/datepicker.dart';
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(right: 20.0),
        width: 500,
        height: 230,
        child: const DatePicker(),
      ),
    );
  }
}
