import 'package:app/widgets/booking/selection_area.dart';
import 'package:app/widgets/booking/selections/local_select.dart';
import 'package:app/widgets/global/popup.dart';
import 'package:flutter/material.dart';

class SelectMeal extends StatefulWidget {
  const SelectMeal({Key? key}) : super(key: key);

  @override
  _SelectMealState createState() => _SelectMealState();
}

class _SelectMealState extends State<SelectMeal> {
  bool optionOne = false;
  bool optionTwo = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              optionOne = true;
              optionTwo = false;
            });
            isAnySelected = true;
            booking.tipo = "almoco";
          },
          child: Container(
            width: 190,
            height: 220,
            child: Center(
              child: optionOne ? const Text("") : const Text("Almoço"),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: optionOne ? Colors.green : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                opacity: optionOne ? 1 : 0.4,
                image: const AssetImage(
                  "assets/images/almoco.jpeg",
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 30),
        GestureDetector(
          onTap: () {
            if (booking.local != "segunda") {
              setState(() {
                optionOne = false;
                optionTwo = true;
              });
            } else {
              showDialog(
                context: context,
                builder: (context) => ShowPopup(
                  buildContext: context,
                  msg: const TextSpan(
                      text: "Não é possivel jantar na segunda secção."),
                  title: 'Ops!',
                ),
              );
            }
            isAnySelected = true;
            booking.tipo = "jantar";
          },
          child: Container(
            width: 190,
            height: 220,
            child: Center(
              child: optionTwo ? const Text("") : const Text("Jantar"),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: optionTwo ? Colors.green : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                opacity: optionTwo ? 1 : 0.4,
                image: const AssetImage(
                  "assets/images/jantar.jpg",
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
