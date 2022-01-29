import 'package:app/views/booking_page.dart';
import 'package:app/widgets/booking/selectDate/datepicker.dart';
import 'package:app/widgets/booking/selection/options/select_local.dart';
import 'package:app/widgets/global/options_top_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<DataRow> listRows = [];

class ConfirmOptions extends StatefulWidget {
  const ConfirmOptions({Key? key}) : super(key: key);

  @override
  _ConfirmOptionsState createState() => _ConfirmOptionsState();
}

class _ConfirmOptionsState extends State<ConfirmOptions> {
  List<DataRow> getRows() {
    final DateFormat dateFormatter = DateFormat("dd/MM");
    for (var value in datas) {
      listRows.add(
        DataRow(
          cells: [
            DataCell(Text(dateFormatter.format(value))),
            DataCell(Text(mealInfo.tipo! == "almoco" ? "Almoço" : "Jantar")),
            DataCell(Text(
                mealInfo.local! == "primeira" ? "1ª secção" : "2ª secção")),
            DataCell(
              Text(mealInfo.especial! == "normal"
                  ? "Normal"
                  : mealInfo.especial! == "dieta"
                      ? "Dieta"
                      : "Vegetariano"),
            ),
          ],
        ),
      );
    }
    return listRows;
  }

  bool onNewBookingPressed = false, onConfirmationPressed = false;

  @override
  Widget build(BuildContext context) {
    if (onNewBookingPressed) return const SelectLocal();
    return Column(
      children: [
        const TopText("Confirme as suas marcações"),
        Expanded(
          child: SingleChildScrollView(
            child: DataTable(
              dataTextStyle: const TextStyle(color: Colors.white),
              headingTextStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
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
              rows: getRows(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 15, left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(100, 40),
                    primary: Colors.red,
                  ),
                  onPressed: () {
                    datas = [];
                    listRows = [];
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const BookingPage(),
                        transitionDuration: Duration.zero,
                      ),
                    );
                  },
                  child: const Text("Cancelar"),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(180, 40),
                    primary: Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      onNewBookingPressed = true;
                    });
                  },
                  child: const Text("Marcar outra refeição"),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(100, 40),
                    primary: Colors.green,
                  ),
                  onPressed: () {
                    setState(() {
                      onConfirmationPressed = true;
                    });
                  },
                  child: const Text("Confirmar"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
