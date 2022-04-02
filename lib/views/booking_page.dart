import 'package:app/widgets/booking/selection_area.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    Future _showMyDialog() async {
      return showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('AlertDialog Title'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  SizedBox(
                    width: 400,
                    height: 400,
                    child: Image.network(
                        "www.pupilos.eu/wp-content/uploads/2022/03/Ementa-IPE-Marco_004-scaled.jpg"),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Stack(
      children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 50),
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.format_list_bulleted_outlined,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    label: const Text(
                      'Ementa',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      _showMyDialog();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        fixedSize: const Size(300, 40)),
                  )),
              const SelectionArea(),
            ],
          ),
        ),
      ],
    );
  }
}
