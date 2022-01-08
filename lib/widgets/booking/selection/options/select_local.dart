import 'package:app/widgets/booking/popup.dart';
import 'package:app/widgets/booking/selection/options/select_type.dart';
import 'package:flutter/material.dart';

class SelectLocal extends StatefulWidget {
  const SelectLocal({Key? key}) : super(key: key);

  @override
  _SelectLocalState createState() => _SelectLocalState();
}

class _SelectLocalState extends State<SelectLocal> {
  bool nextPage = false;
  bool optionOne = false;
  bool optionTwo = false;

  @override
  Widget build(BuildContext context) {
    if (!nextPage) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 30, top: 30),
            child: Text(
              "Em que seccão quer tomar a refeição?",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          DefaultTextStyle(
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 46),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (optionTwo) {
                        optionOne = true;
                        optionTwo = false;
                      } else {
                        optionOne = true;
                      }
                    });
                  },
                  child: Container(
                    width: 190,
                    height: 220,
                    child: Center(
                      child:
                          optionOne ? const Text("") : const Text("1ª secção"),
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
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (optionOne) {
                        optionOne = false;
                        optionTwo = true;
                      } else {
                        optionTwo = true;
                      }
                    });
                  },
                  child: Container(
                    width: 190,
                    height: 220,
                    child: Center(
                      child:
                          optionTwo ? const Text("") : const Text("2ª secção"),
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
                IconButton(
                  iconSize: 30,
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      if (optionOne || optionTwo) {
                        nextPage = true;
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => ShowPopup(
                            buildContext: context,
                            msg: 'Antes de continuar selecione uma das opções!',
                            title: 'Selecione uma opção',
                          ),
                        );
                      }
                    });
                  },
                  icon: const Icon(Icons.navigate_next_outlined),
                ),
              ],
            ),
          )
        ],
      );
    } else {
      return const SelectType();
    }
  }
}
