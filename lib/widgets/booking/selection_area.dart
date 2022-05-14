import 'package:app/models/meal.dart';
import 'package:app/views/login_page.dart';
import 'package:app/widgets/booking/selections/confirm_options.dart';
import 'package:app/widgets/booking/selections/local_select.dart';
import 'package:app/widgets/booking/selections/meal_select.dart';
import 'package:app/widgets/booking/selections/meal_type_select.dart';
import 'package:app/widgets/datepicker.dart';
import 'package:app/widgets/booking/options_top_text.dart';
import 'package:app/widgets/global/popup.dart';
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
      bookingList.clear();
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

  bool checkIfQuarta() {
    for (var booking in bookingList) {
      if (booking.data!.weekday != 3) {
        print(booking.data!.weekday);
        return false;
      }
    }
    return true;
  }

  bool checkIfOnlyJantar() {
    for (var booking in bookingList) {
      if (booking.tipo.toString().toLowerCase() != "jantar") {
        return false;
      }
    }
    return true;
  }

  void confirmBooking() async {
    int tickets = 0;
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("server/bookings/" + currentCard);
    DatabaseReference refUser =
        FirebaseDatabase.instance.ref("server/verifiedUsers/" + currentCard);

    final snapshot = await refUser.child('tickets').get();
    tickets = int.parse(snapshot.value.toString());
    if (snapshot.exists) {
      if (tickets >= bookingList.length) {
        for (var data in datas) {
          ref.push().set({
            'data': data.toString(),
            'local': booking.local,
            'tipo': booking.tipo,
          });
        }
        refUser.child("tickets").set(tickets - bookingList.length);

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Confirmado!"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(bookingList.length > 1
                    ? "Refeições marcadas com sucesso!"
                    : "Refeição marcada com sucesso!"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    bookingList.clear();
                    _index = 0;
                    datas = [];
                    isAnySelected = false;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Fechar'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => ShowPopup(
            buildContext: context,
            msg: ((bookingList.length - tickets) > 1
                ? "Faltam " +
                    (bookingList.length - tickets).toString() +
                    " tickets para poderes marcar!."
                : "Falta 1 ticket para poderes marcar!"),
            title: 'Ops!',
          ),
        );
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
        for (var data in datas) {
          Meal tempMeal = Meal(
              data: data,
              especial: booking.especial,
              local: booking.local,
              tipo: booking.tipo);
          bookingList.add(tempMeal);
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
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(150, 40),
                              primary: Colors.red,
                            ),
                            onPressed: () {
                              cancelBooking();
                            },
                            icon: const Icon(Icons.cancel_outlined),
                            label: const Text("Cancelar"),
                          ),
                          const SizedBox(width: 60),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(150, 40),
                              primary: Colors.green,
                            ),
                            onPressed: () {
                              Object? tipo;
                              DatabaseReference userType = FirebaseDatabase
                                  .instance
                                  .ref('server/verifiedUsers/' +
                                      currentCard +
                                      "/type");
                              userType.onValue.listen((DatabaseEvent event) {
                                tipo = event.snapshot.value;
                              });
                              print(tipo.toString());
                              //tem de ser aluno, so pode marcacoes quartas e jantares
                              if (tipo.toString().toLowerCase() == "aluno") {
                                if (checkIfQuarta() && checkIfOnlyJantar()) {
                                  confirmBooking();
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                            'Ops!',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: [
                                                RichText(
                                                  text: const TextSpan(
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              "Os alunos só podem marcar\n"),
                                                      TextSpan(
                                                          text: "jantar(es) ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      TextSpan(text: "ás "),
                                                      TextSpan(
                                                          text:
                                                              "quarta(s)-feira(s)",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton.icon(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                  Colors.green,
                                                ),
                                              ),
                                              label: const Text("Confirmar"),
                                              icon: const Icon(Icons.done),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                }
                              } else {
                                confirmBooking();
                              }
                            },
                            icon: const Icon(Icons.check_outlined),
                            label: const Text("Confirmar"),
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
