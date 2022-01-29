import 'package:app/widgets/booking/popup.dart';
import 'package:app/widgets/booking/selection/select_local.dart';
import 'package:app/widgets/global/options_top_text.dart';
import 'package:flutter/material.dart';

class SelectMeal extends StatefulWidget {
  const SelectMeal({Key? key}) : super(key: key);

  @override
  _SelectMealState createState() => _SelectMealState();
}

class _SelectMealState extends State<SelectMeal> {
  bool nextPage = false;
  bool beforePage = false;
  bool optionOne = false;
  bool optionTwo = false;
  @override
  Widget build(BuildContext context) {
    if (beforePage) {
      //return const SelectLocal();
    }
    return !nextPage
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TopText("Almoço ou Jantar?"),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 46,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        optionOne = true;
                        optionTwo = false;
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
                        optionOne = false;
                        optionTwo = true;
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
                      setState(() {
                        if (optionOne || optionTwo) {
                          nextPage = true;
                          //mealInfo.tipo = optionOne ? "almoco" : "jantar";
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => ShowPopup(
                              buildContext: context,
                              msg:
                                  'Antes de continuar selecione uma das opções!',
                              title: 'Selecione uma opção',
                            ),
                          );
                        }
                      });
                    },
                    icon: const Icon(Icons.navigate_next_outlined),
                  ),
                ],
              )
            ],
          )
        : SelectLocal(
            isJantarPressed: optionTwo,
          );
  }
}
