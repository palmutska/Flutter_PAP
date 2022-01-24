import 'package:app/widgets/booking/popup.dart';
import 'package:app/widgets/booking/selectDate/datepicker.dart';
import 'package:app/widgets/booking/selection/options/select_local.dart';
import 'package:app/widgets/booking/selection/options/select_type.dart';
import 'package:flutter/material.dart';

class SelectSpecial extends StatefulWidget {
  const SelectSpecial({Key? key}) : super(key: key);

  @override
  _SelectSpecialState createState() => _SelectSpecialState();
}

class _SelectSpecialState extends State<SelectSpecial> {
  bool nextPage = false;
  bool beforePage = false;
  bool optionOne = false, optionTwo = false, optionThree = false;
  @override
  Widget build(BuildContext context) {
    if (beforePage) {
      return const SelectType();
    }
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 30, top: 30),
          child: Text(
            "Que tipo de refeição quer?",
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        optionOne = true;
                        optionTwo = false;
                        optionThree = false;
                        mealInfo.especial = "normal";
                      });
                    },
                    child: Container(
                      width: 400,
                      height: 110,
                      child: Center(
                        child:
                            optionOne ? const Text("") : const Text("Normal"),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              optionOne = false;
                              optionTwo = true;
                              optionThree = false;
                              mealInfo.especial = "vegetariano";
                            });
                          },
                          child: Container(
                            width: 200,
                            height: 85,
                            child: Center(
                              child: optionTwo
                                  ? const Text("")
                                  : const Text("Vegetariano"),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color: optionTwo
                                    ? Colors.green
                                    : Colors.transparent,
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
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              optionOne = false;
                              optionTwo = false;
                              optionThree = true;
                              mealInfo.especial = "dieta";
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              width: 200,
                              height: 85,
                              child: Center(
                                child: optionThree
                                    ? const Text("")
                                    : const Text("Dieta"),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                  color: optionThree
                                      ? Colors.green
                                      : Colors.transparent,
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
                        ),
                      ],
                    ),
                  )
                ],
              ),
              IconButton(
                iconSize: 30,
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    if (datas.isNotEmpty) {
                      if (optionOne || optionTwo || optionThree) {
                        nextPage = true;
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
                    } else {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (context) => ShowPopup(
                            buildContext: context,
                            msg: 'Antes de continuar selecione uma data!',
                            title: 'Selecione uma opção',
                          ),
                        );
                      });
                    }
                  });
                },
                icon: const Icon(Icons.navigate_next_outlined),
              ),
            ],
          ),
        )
      ],
    );
  }
}

























/*

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

            IconButton(
              iconSize: 30,
              color: Colors.white,
              onPressed: () {
                setState(() {
                  nextPage = true;
                });
              },
              icon: const Icon(Icons.navigate_next_outlined),
            ),


 */
