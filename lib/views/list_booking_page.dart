import 'package:app/models/meal.dart';
import 'package:app/views/login_page.dart';
import 'package:app/widgets/global/popup.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPage();
}

class _ListPage extends State<ListPage> {
  Future getData() async {
    var ref =
        FirebaseDatabase.instance.ref("server/bookings/" + currentCard + "/");

    DataSnapshot event = await ref.get();
    Map<String, Meal> bookings = {};
    for (DataSnapshot value in event.children) {
      Meal pivot = Meal(
        data: DateTime.parse(value.child("data").value.toString()),
        tipo: value.child("tipo").value.toString() == "almoco"
            ? "Almoço"
            : "Jantar",
        local: value.child("local").value.toString() == "primeira"
            ? "1ª secção"
            : "2ª secção",
      );
      bookings[value.key!] = pivot;
    }
    return bookings;
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat("dd-MM-yyyy");
    List<DataRow> rows = [];

    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          Map<String, Meal> list = snapshot.data! as Map<String, Meal>;
          if (list.isNotEmpty) {
            for (var k in list.keys) {
              rows.add(DataRow(cells: [
                DataCell(Text(formatter.format(list[k]!.data!))),
                DataCell(Text(list[k]!.tipo.toString())),
                DataCell(Text(list[k]!.local.toString())),
                DataCell(IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'Apagar a refeição?',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                          text:
                                              "Tem a certeza que quer desmarcar o\n"),
                                      TextSpan(
                                        text: list[k]!.tipo! +
                                            " na " +
                                            list[k]!.local! +
                                            " no dia " +
                                            formatter.format(list[k]!.data!) +
                                            "?",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          actions: [
                            ElevatedButton.icon(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green),
                              ),
                              label: const Text("Confirmar"),
                              icon: const Icon(Icons.check_box_outlined),
                              onPressed: () {
                                Navigator.of(context).pop();
                                if (DateTime.now()
                                    .add(const Duration(days: 1, hours: 12))
                                    .isBefore(list[k]!.data!)) {
                                  setState(() {
                                    list.remove(list[k]);
                                    FirebaseDatabase.instance
                                        .ref("server/bookings/" +
                                            currentCard +
                                            "/" +
                                            k)
                                        .remove();
                                  });
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => ShowPopup(
                                      buildContext: context,
                                      msg:
                                          'Já passou o tempo limite para desmarcar esta refeição!',
                                      title: 'Ops!',
                                    ),
                                  );
                                }
                              },
                            ),
                            ElevatedButton.icon(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                              ),
                              label: const Text("Cancelar"),
                              icon: const Icon(Icons.cancel_outlined),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                )),
              ]));
            }
          }
          return Center(
            child: SizedBox(
              width: 600,
              height: 300,
              child: SingleChildScrollView(
                child: DataTable(
                  headingTextStyle:
                      const TextStyle(fontWeight: FontWeight.bold),
                  border: TableBorder.symmetric(
                    inside: const BorderSide(width: 1),
                  ),
                  columns: [
                    DataColumn(
                      label: Row(children: const [
                        Text("Data "),
                        Icon(Icons.calendar_month_outlined)
                      ]),
                    ),
                    DataColumn(
                      label: Row(children: const [
                        Text("Tipo "),
                        Icon(Icons.local_dining_outlined)
                      ]),
                    ),
                    DataColumn(
                      label: Row(children: const [
                        Text("Local "),
                        Icon(Icons.place_outlined)
                      ]),
                    ),
                    DataColumn(
                        label: Row(
                      children: const [
                        Text("Ações "),
                        Icon(Icons.more_horiz_outlined)
                      ],
                    )),
                  ],
                  rows: rows,
                ),
              ),
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.only(top: 60),
            child: Text(
              "Não tens nenhuma marcação!",
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        }
      },
    );
  }
}
