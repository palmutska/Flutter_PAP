import 'package:app/widgets/booking/selectDate/calendar.dart';
import 'package:app/widgets/booking/selection/selection_box.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 250,
          top: 95,
          child: Row(
            children: const [
              Calendar(),
              SelectionBox(),
            ],
          ),
        ),
      ],
    );
  }
}
