import 'package:app/widgets/booking/selection_area.dart';
import 'package:flutter/material.dart';

bool isAnySelected = false;

class SelectLocal extends StatefulWidget {
  const SelectLocal({Key? key, required this.onInit}) : super(key: key);
  final VoidCallback onInit;

  @override
  _SelectLocalState createState() => _SelectLocalState();
}

class _SelectLocalState extends State<SelectLocal> {
  bool optionOne = false;
  bool optionTwo = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      widget.onInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      topText = "Selecione o local das sua refeição.";
    });

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              optionOne = true;
              optionTwo = false;
            });
            isAnySelected = true;
            booking.local = "primeira";
          },
          child: Container(
            width: 190,
            height: 220,
            child: Center(
              child: optionOne ? const Text("") : const Text("1ª secção"),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: optionOne ? Colors.green : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                opacity: optionOne ? 1 : 0.4,
                image: const AssetImage(
                  "assets/images/primeira.png",
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 30),
        GestureDetector(
          onTap: () {
            setState(() {
              optionOne = false;
              optionTwo = true;
            });
            isAnySelected = true;
            booking.local = "segunda";
          },
          child: Container(
            width: 190,
            height: 220,
            child: Center(
              child: optionTwo ? const Text("") : const Text("2ª secção"),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: optionTwo ? Colors.green : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                opacity: optionTwo ? 1 : 0.4,
                image: const AssetImage(
                  "assets/images/segunda.png",
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
