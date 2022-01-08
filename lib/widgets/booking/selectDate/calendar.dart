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
    return Row(
      children: const [
        SizedBox(
          width: 300,
          height: 300,
          child: DatePicker(),
        ),
        SizedBox(
          width: 70,
        ),
      ],
    );
  }
}
