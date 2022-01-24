import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

List<DateTime> datas = [];

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final DateFormat formatter = DateFormat('dd/MM');

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      datas = args.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      selectableDayPredicate: (DateTime datetime) {
        if (datetime.weekday == 6 || datetime.weekday == 7) {
          return false;
        }
        return true;
      },
      backgroundColor: Colors.white,
      showNavigationArrow: true,
      selectionShape: DateRangePickerSelectionShape.circle,
      minDate: DateTime.now().add(const Duration(days: 2)),
      maxDate: DateTime.now().add(const Duration(days: 32)),
      view: DateRangePickerView.month,
      monthCellStyle: DateRangePickerMonthCellStyle(
          weekendDatesDecoration: BoxDecoration(
        color: Colors.red,
        border: Border.all(color: const Color(0xFFF44436), width: 1),
        shape: BoxShape.circle,
      )),
      headerStyle: const DateRangePickerHeaderStyle(
          textStyle: TextStyle(
        fontWeight: FontWeight.bold,
      )),
      onSelectionChanged: _onSelectionChanged,
      selectionMode: DateRangePickerSelectionMode.multiple,
    );
  }
}
