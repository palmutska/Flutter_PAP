import 'package:app/models/meal.dart';
import 'package:app/widgets/booking/selections/local_select.dart';
import 'package:app/widgets/booking/selections/meal_select.dart';
import 'package:app/widgets/datepicker.dart';
import 'package:app/widgets/booking/options_top_text.dart';
import 'package:app/widgets/global/popup.dart';
import 'package:flutter/material.dart';

String topText = "";
Meal booking = Meal();

class SelectionArea extends StatefulWidget {
  const SelectionArea({Key? key}) : super(key: key);

  @override
  _SelectionAreaState createState() => _SelectionAreaState();
}

class _SelectionAreaState extends State<SelectionArea> {
  bool confirmationPage = false;
  int _index = 0;

  void incrementIndex() {
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
  }

  void decrementIndex() {
    isAnySelected = false;
    switch (_index) {
      case 1:
        booking.local = null;
        booking.tipo = null;
        break;
      case 2:
        booking.local = null;
        booking.tipo = null;
        booking.especial = null;
        break;
    }
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
            IgnorePointer(
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TopText(topText),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
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
                    getOptionPage(_index),
                    IconButton(
                      iconSize: 30,
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          incrementIndex();
                        });
                      },
                      icon: const Icon(Icons.navigate_next_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
