import 'dart:ui';

import 'package:app/views/login_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    //TODO Deixar + bonito
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FutureBuilder<List>(
          future: _getBooking(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text(
                "Não tem nenhuma marcação!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              var myList = snapshot.data!;
              return DataTable(
                border: TableBorder.all(),
                dividerThickness: 3,
                dataRowColor: MaterialStateProperty.all(Colors.white),
                headingRowColor:
                    MaterialStateProperty.all(Colors.lightBlueAccent[400]),
                headingTextStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                columns: const [
                  DataColumn(label: Text("Data")),
                  DataColumn(label: Text("Tipo")),
                  DataColumn(label: Text("Local")),
                ],
                rows: createRows(myList),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}

Future<List> _getBooking() async {
  // ignore: prefer_typing_uninitialized_variables
  var ref =
      FirebaseDatabase.instance.ref("server/bookings/" + currentCard + "/");
  var bookings = [];

  try {
    DataSnapshot event = await ref.get();
    for (DataSnapshot value in event.children) {
      var pivot = [];
      pivot.add(value.child("data").value);
      pivot.add(value.child("tipo").value);
      pivot.add(value.child("local").value);
      bookings.add(pivot);
    }
  } catch (err) {
    if (kDebugMode) {
      print("Erro: " + err.toString());
    }
  }
  return bookings;
}

List<DataRow> createRows(List<dynamic> list) {
  List<DataRow> rows = [];
  for (var value in list) {
    rows.add(DataRow(
      cells: [
        DataCell(Text(value[0])),
        DataCell(Text(value[1])),
        DataCell(Text(value[2])),
      ],
    ));
  }
  return rows;
}
