import 'package:app/widgets/booking/selection_area.dart';
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
      children: const [
        Center(
          child: SelectionArea(),
        ),
      ],
    );
  }
}
