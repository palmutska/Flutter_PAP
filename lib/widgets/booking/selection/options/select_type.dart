import 'package:app/models/meal.dart';
import 'package:app/widgets/booking/selection/options/select_local.dart';
import 'package:app/widgets/booking/selection/options/select_special.dart';
import 'package:flutter/material.dart';

class SelectType extends StatefulWidget {
  const SelectType({Key? key}) : super(key: key);

  @override
  _SelectTypeState createState() => _SelectTypeState();
}

class _SelectTypeState extends State<SelectType> {
  bool nextPage = false;
  bool beforePage = false;
  bool optionOne = false;
  bool optionTwo = false;
  @override
  Widget build(BuildContext context) {
    if (beforePage) {
      return const SelectLocal();
    }
    return !nextPage
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 30, top: 30),
                child: Text(
                  "Almoço ou jantar?",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 30,
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        beforePage = true;
                      });
                    },
                    icon: const Icon(Icons.navigate_before_outlined),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (optionTwo) {
                          optionOne = true;
                          optionTwo = false;
                        } else {
                          optionOne = true;
                        }
                      });
                    },
                    child: Container(
                      width: 190,
                      height: 220,
                      child: Center(
                        child:
                            optionOne ? const Text("") : const Text("Almoço"),
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (optionOne) {
                          optionOne = false;
                          optionTwo = true;
                        } else {
                          optionOne = false;
                        }
                      });
                    },
                    child: Container(
                      width: 190,
                      height: 220,
                      child: Center(
                        child:
                            optionTwo ? const Text("") : const Text("Jantar"),
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
                  IconButton(
                    iconSize: 30,
                    color: Colors.white,
                    onPressed: () {
                      mealInfo.tipo = optionOne ? "almoco" : "jantar";
                      setState(() {
                        nextPage = true;
                      });
                    },
                    icon: const Icon(Icons.navigate_next_outlined),
                  ),
                ],
              )
            ],
          )
        : const SelectSpecial();
  }
}
