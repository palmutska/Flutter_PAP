import 'package:app/widgets/booking/selection_area.dart';
import 'package:app/widgets/datepicker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConfirmOptions extends StatefulWidget {
  const ConfirmOptions({Key? key, required this.onInit}) : super(key: key);
  final VoidCallback onInit;

  @override
  _ConfirmOptionsState createState() => _ConfirmOptionsState();
}

class _ConfirmOptionsState extends State<ConfirmOptions> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      widget.onInit();
    });
  }

  List<DataRow> getRows() {
    final DateFormat dateFormatter = DateFormat("dd/MM");
    List<DataRow> listRows = [];
    for (var value in datas) {
      listRows.add(
        DataRow(
          cells: [
            DataCell(
              Text(dateFormatter.format(value)),
            ),
            DataCell(
              Text(booking.local == "primeira" ? "1ª secção" : "2ª secção"),
            ),
            DataCell(
              Text(booking.tipo == "almoco" ? "Almoço" : "Jantar"),
            ),
            DataCell(
              Text(booking.especial == "normal"
                  ? "Normal"
                  : booking.especial == "dieta"
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
            SizedBox(
              height: 220,
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
          ],
        ),
      ],
    );
  }
}
