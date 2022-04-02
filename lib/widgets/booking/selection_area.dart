import 'package:app/models/meal.dart';
import 'package:app/views/login_page.dart';
import 'package:app/widgets/booking/selections/confirm_options.dart';
import 'package:app/widgets/booking/selections/local_select.dart';
import 'package:app/widgets/booking/selections/meal_select.dart';
import 'package:app/widgets/booking/selections/meal_type_select.dart';
import 'package:app/widgets/datepicker.dart';
import 'package:app/widgets/booking/options_top_text.dart';
import 'package:app/widgets/global/popup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

Meal booking = Meal();
List<Meal> bookingList = [];

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
            confirmationPage = true;
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
              msg: 'Selecione uma data.',
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

  void cancelBooking() {
    setState(() {
      _index = 0;
      datas = [];
      isAnySelected = false;
    });
  }

  void newBooking() {
    setState(() {
      _index = 0;
      isAnySelected = false;
    });
  }

  void confirmBooking() {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("server/bookings/" + currentCard + "/");

    try {
      for (var data in datas) {
        ref.push().set({
          'data': data.toString(),
          'local': booking.local,
          'tipo': booking.tipo,
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Erro: " + e.toString());
      }
    }
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
        List<Meal> pivots = [];
        for (var data in datas) {
          //booking = booking atual que o user está a fazer
          //pivot = objeto para ajudar

          //! REFAZER ISTO
          Meal pivot = Meal();
          pivot.data = data;
          pivot.especial = booking.especial;
          pivot.local = booking.local;
          pivot.tipo = booking.tipo;
          pivots.add(pivot);
        }
        if (bookingList.isEmpty) {
          for (var element in pivots) {
            bookingList.add(element);
          }
        } else {
          for (var booking in bookingList) {
            for (var element in pivots) {
              if (element.data == booking.data &&
                  element.local == booking.local &&
                  element.tipo == booking.tipo) {
                bookingList.remove(booking);
              }
            }
          }
          for (var element in pivots) {
            bookingList.add(element);
          }
        }
        return const ConfirmOptions();

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
                Column(
                  children: [
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
                    ),
                    Visibility(
                      visible: confirmationPage,
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(100, 40),
                              primary: Colors.red,
                            ),
                            onPressed: () {
                              cancelBooking();
                            },
                            child: const Text("Cancelar"),
                          ),
                          const SizedBox(width: 30),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(220, 40),
                              primary: Colors.blue,
                            ),
                            onPressed: () {
                              newBooking();
                            },
                            child: const Text("Criar/Apagar uma marcação"),
                          ),
                          const SizedBox(width: 30),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(100, 40),
                              primary: Colors.green,
                            ),
                            onPressed: () {
                              confirmBooking();
                            },
                            child: const Text("Confirmar"),
                          ),
                        ],
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
