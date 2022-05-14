import 'package:app/widgets/booking/selection_area.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConfirmOptions extends StatefulWidget {
  const ConfirmOptions({Key? key}) : super(key: key);
  @override
  _ConfirmOptionsState createState() => _ConfirmOptionsState();
}

class _ConfirmOptionsState extends State<ConfirmOptions> {
  List<DataRow> getRows() {
    final DateFormat dateFormatter = DateFormat("dd/MM");
    List<DataRow> listRows = [];
    for (var value in bookingList) {
      listRows.add(
        DataRow(
          cells: [
            DataCell(
              Text(dateFormatter.format(value.data!)),
            ),
            DataCell(
              Text(value.tipo == "almoco" ? "Almoço" : "Jantar"),
            ),
            DataCell(
              Text(value.local == "primeira" ? "1ª secção" : "2ª secção"),
            ),
            DataCell(
              Text(value.especial == "normal"
                  ? "Normal"
                  : value.especial == "dieta"
                      ? "Dieta"
                      : "Vegetariano"),
            ),
          ],
        ),
      );
    }
    return listRows;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                height: 205,
                width: 450,
                child: SingleChildScrollView(
                  child: DataTable(
                      headingTextStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      dataTextStyle: const TextStyle(color: Colors.white),
                      columns: const [
                        DataColumn(
                          label: Text("Data"),
                        ),
                        DataColumn(
                          label: Text("Refeição"),
                        ),
                        DataColumn(
                          label: Text("Local"),
                        ),
                        DataColumn(
                          label: Text("Tipo"),
                        ),
                      ],
                      rows: getRows()),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
