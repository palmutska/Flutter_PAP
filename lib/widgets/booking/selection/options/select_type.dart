import 'package:app/widgets/booking/selection/options/select_local.dart';
import 'package:app/widgets/booking/selection/options/select_special.dart';
import 'package:flutter/material.dart';

class SelectType extends StatefulWidget {
  const SelectType({Key? key}) : super(key: key);

  @override
  _SelectTypeState createState() => _SelectTypeState();
}

class _SelectTypeState extends State<SelectType> {
  bool nextPage = false;
  bool beforePage = false;
  @override
  Widget build(BuildContext context) {
    if (beforePage) {
      return const SelectLocal();
    }
    return !nextPage
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 30, top: 30),
                child: Text(
                  "Almoço ou jantar?",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 30,
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        beforePage = true;
                      });
                    },
                    icon: const Icon(Icons.navigate_before_outlined),
                  ),
                  Container(
                    color: Colors.green,
                    width: 200,
                    height: 200,
                  ),
                  Container(
                    color: Colors.lightGreen,
                    width: 200,
                    height: 200,
                  ),
                  IconButton(
                    iconSize: 30,
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        nextPage = true;
                      });
                    },
                    icon: const Icon(Icons.navigate_next_outlined),
                  ),
                ],
              )
            ],
          )
        : const SelectSpecial();
  }
}
