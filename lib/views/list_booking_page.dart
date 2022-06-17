import 'package:app/models/meal.dart';
import 'package:app/views/login_page.dart';
import 'package:app/widgets/global/popup.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListBookings extends StatefulWidget {
  const ListBookings({Key? key}) : super(key: key);

  @override
  State<ListBookings> createState() => _ListBookingsState();
}

class _ListBookingsState extends State<ListBookings> {
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

  bool antigos = false, todos = true, recentes = false, showButtons = true;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat("dd-MM-yyyy");
    List<DataRow> rows = [];
    return Center(
      child: Column(
        children: [
          FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: CircularProgressIndicator(),
                  );
                }
                Map<String, Meal> list = snapshot.data! as Map<String, Meal>;

                if (snapshot.hasData && list.isNotEmpty) {
                  if (antigos) {
                    list.removeWhere(
                        (key, value) => value.data!.isAfter(DateTime.now()));
                  }
                  if (recentes) {
                    list.removeWhere(
                        (key, value) => value.data!.isBefore(DateTime.now()));
                  }
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
                                                  formatter
                                                      .format(list[k]!.data!) +
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
                                          MaterialStateProperty.all(
                                              Colors.green),
                                    ),
                                    label: const Text("Confirmar"),
                                    icon: const Icon(Icons.check_box_outlined),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      if (DateTime.now()
                                          .add(const Duration(
                                              days: 1, hours: 12))
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
                                            msg: const TextSpan(
                                                text:
                                                    'Já passou o tempo limite para desmarcar esta refeição!'),
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
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromARGB(0, 31, 27, 27),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                fixedSize: const Size(200, 40)),
                            onPressed: () {
                              setState(() {
                                antigos = true;
                                todos = false;
                                recentes = false;
                              });
                            },
                            child: const Text(
                              'Antigas',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromARGB(0, 31, 27, 27),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                fixedSize: const Size(200, 40)),
                            onPressed: () {
                              setState(() {
                                antigos = false;
                                todos = true;
                                recentes = false;
                              });
                            },
                            child: const Text(
                              'Todas',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromARGB(0, 31, 27, 27),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                fixedSize: const Size(200, 40)),
                            onPressed: () {
                              setState(() {
                                antigos = false;
                                todos = false;
                                recentes = true;
                              });
                            },
                            child: const Text(
                              'Recentes',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
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
                      ),
                    ],
                  );
                } else {
                  return const Text(
                    "Não tens marcações!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  );
                }
              })
        ],
      ),
    );
  }
}
