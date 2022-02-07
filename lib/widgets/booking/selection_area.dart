import 'package:app/models/meal.dart';
import 'package:app/widgets/booking/selections/confirm_options.dart';
import 'package:app/widgets/booking/selections/local_select.dart';
import 'package:app/widgets/booking/selections/meal_select.dart';
import 'package:app/widgets/booking/selections/meal_type_select.dart';
import 'package:app/widgets/datepicker.dart';
import 'package:app/widgets/booking/options_top_text.dart';
import 'package:app/widgets/global/popup.dart';
import 'package:flutter/material.dart';

Meal booking = Meal();

class SelectionArea extends StatefulWidget {
  const SelectionArea({Key? key}) : super(key: key);

  @override
  _SelectionAreaState createState() => _SelectionAreaState();
}

class _SelectionAreaState extends State<SelectionArea> {
  var topText = [
    "Selecione o local da sua refeição",
    "Almoço ou Jantar?",
    "Selecione o tipo de refeição",
    "Confirme as opções!"
  ];

  bool confirmationPage = false;
  int _index = 0;

  //index
  //0 - local
  //1 - tipo refeição
  //2 - especial
  //3 confirmar

  void incrementIndex() {
    if (_index <= 3 && _index != 2) {
      if (isAnySelected) {
        _index++;
        isAnySelected = false;
      } else {
        showDialog(
          context: context,
          builder: (context) => ShowPopup(
            buildContext: context,
            msg: 'Selecione uma das opções.',
            title: 'Ops!',
          ),
        );
      }
    } else {
      if (_index == 2) {
        if (datas.isNotEmpty) {
          if (isAnySelected) {
            _index++;
            isAnySelected = false;
          } else {
            showDialog(
              context: context,
              builder: (context) => ShowPopup(
                buildContext: context,
                msg: 'Selecione uma opção.',
                title: 'Ops!',
              ),
            );
          }
        } else {
          showDialog(
            context: context,
            builder: (context) => ShowPopup(
              buildContext: context,
              msg: 'Selecione pelo menos uma data.',
              title: 'Ops!',
            ),
          );
        }
      }
    }
  }

  void decrementIndex() {
    _index--;
  }

  Widget getOptionPage(int index) {
    switch (index) {
      case 0:
        return SelectLocal(
          onInit: () {
            setState(() {
              confirmationPage = false;
            });
          },
        );
      case 1:
        return const SelectMeal();
      case 2:
        return const SelectMealType();
      case 3:
        return ConfirmOptions(
          onInit: () {
            setState(() {
              confirmationPage = true;
            });
          },
        );
      default:
        return const Text("Out of bounds");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.transparent.withOpacity(0.15),
      ),
      width: 900,
      height: 375,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(left: _index == 3 ? 20 : 0),
              child: IgnorePointer(
                ignoring: confirmationPage,
                child: Container(
                  margin: const EdgeInsets.only(left: 30),
                  width: 300,
                  height: 300,
                  foregroundDecoration: confirmationPage
                      ? const BoxDecoration(
                          color: Colors.grey,
                          backgroundBlendMode: BlendMode.saturation,
                        )
                      : null,
                  child: const DatePicker(),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TopText(topText[_index]),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: !confirmationPage,
                      child: IconButton(
                        iconSize: 30,
                        color: Colors.white,
                        onPressed: () {
                          _index > 0
                              ? setState(() {
                                  decrementIndex();
                                })
                              : null;
                        },
                        icon: const Icon(Icons.navigate_before_outlined),
                      ),
                    ),
                    getOptionPage(_index),
                    Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: !confirmationPage,
                      child: IconButton(
                        iconSize: 30,
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            incrementIndex();
                          });
                        },
                        icon: const Icon(Icons.navigate_next_outlined),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
