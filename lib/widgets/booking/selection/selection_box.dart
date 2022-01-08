import 'package:app/widgets/booking/selection/options/select_local.dart';
import 'package:flutter/material.dart';

class SelectionBox extends StatefulWidget {
  const SelectionBox({Key? key}) : super(key: key);

  @override
  _SelectionBoxState createState() => _SelectionBoxState();
}

class _SelectionBoxState extends State<SelectionBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 350,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.transparent.withOpacity(0.15),
        ),
        child: const SelectLocal(),
      ),
    );
  }
}
