import 'package:app/widgets/booking/popup.dart';
import 'package:app/widgets/booking/selection/select_meal.dart';
import 'package:app/widgets/booking/selection/select_meal_type.dart';
import 'package:app/widgets/global/options_top_text.dart';
import 'package:flutter/material.dart';

class SelectLocal extends StatefulWidget {
  final bool isJantarPressed;
  const SelectLocal({Key? key, required this.isJantarPressed})
      : super(key: key);

  @override
  _SelectLocalState createState() => _SelectLocalState();
}

class _SelectLocalState extends State<SelectLocal> {
  bool nextPage = false;
  bool beforePage = false;
  bool optionOne = false;
  bool optionTwo = false;

  @override
  Widget build(BuildContext context) {
    if (beforePage) {
      return const SelectMeal();
    }
    if (!nextPage) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TopText("Em que secção vai tomar a refeição?"),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                iconSize: 30,
                color: Colors.white,
                onPressed: () {
                  beforePage = true;
                },
                icon: const Icon(Icons.navigate_before_outlined),
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
                    child: optionOne ? const Text("") : const Text("1ª secção"),
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
                        "assets/images/primeira.png",
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (widget.isJantarPressed) {
                    showDialog(
                      context: context,
                      builder: (context) => ShowPopup(
                        buildContext: context,
                        msg:
                            'Não é possível marcar um jantar na segunda secção!',
                        title: 'Erro',
                      ),
                    );
                  } else {
                    setState(() {
                      optionOne = false;
                      optionTwo = true;
                    });
                  }
                },
                child: Container(
                  width: 190,
                  height: 220,
                  child: Center(
                    child: optionTwo ? const Text("") : const Text("2ª secção"),
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
                        "assets/images/segunda.png",
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
                      //mealInfo.local = optionOne ? "primeira" : "segunda";
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => ShowPopup(
                          buildContext: context,
                          msg: 'Antes de continuar selecione uma das opções!',
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
      );
    } else {
      return const SelectSpecial();
    }
  }
}
