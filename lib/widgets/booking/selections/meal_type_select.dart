import 'package:app/widgets/booking/selections/local_select.dart';
import 'package:flutter/material.dart';

class SelectMealType extends StatefulWidget {
  const SelectMealType({Key? key}) : super(key: key);

  @override
  _SelectMealTypeState createState() => _SelectMealTypeState();
}

class _SelectMealTypeState extends State<SelectMealType> {
  bool optionOne = false;
  bool optionTwo = false;
  bool optionThree = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              optionOne = true;
              optionTwo = false;
              optionThree = false;
            });
            isAnySelected = true;
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: 410,
            height: 105,
            child: Center(
              child: optionOne ? const Text("") : const Text("Normal"),
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
                  "assets/images/tipoNormal.jpg",
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  optionOne = false;
                  optionTwo = true;
                  optionThree = false;
                });
                isAnySelected = true;
              },
              child: Container(
                width: 195,
                height: 105,
                child: Center(
                  child: optionTwo ? const Text("") : const Text("Vegetariano"),
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
                      "assets/images/tipoVegetariano.jpg",
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  optionOne = false;
                  optionTwo = false;
                  optionThree = true;
                });
                isAnySelected = true;
              },
              child: Container(
                width: 195,
                height: 105,
                child: Center(
                  child: optionThree ? const Text("") : const Text("Dieta"),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: optionThree ? Colors.green : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    opacity: optionThree ? 1 : 0.4,
                    image: const AssetImage(
                      "assets/images/tipoDieta.jpg",
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
