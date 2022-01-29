import 'package:app/widgets/booking/selection/select_meal.dart';
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
        Center(
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            child: Container(
              margin: const EdgeInsets.only(bottom: 70.0),
              width: 650,
              height: 350,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Colors.transparent.withOpacity(0.15),
              ),
              child: Column(
                children: const [SelectMeal()],
              ),
            ),
          ),
        )
      ],
    );
  }
}
