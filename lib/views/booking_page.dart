import 'package:app/widgets/booking/selection_area.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  Future<String> getUrl() {
    final ref = FirebaseStorage.instance
        .ref()
        .child('Ementa-IPE-Marco_004-768x1087.jpg');

    Future<String> url = ref.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Ementa'),
                            content: FutureBuilder(
                              future: getUrl(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }
                                if (snapshot.hasData) {
                                  return SizedBox(
                                    width: 768,
                                    height: 1087,
                                    child: SingleChildScrollView(
                                      child: Image.network(
                                        snapshot.data.toString(),
                                        scale: 0.2,
                                      ),
                                    ),
                                  );
                                } else {
                                  return Text("Erro ao carregar");
                                }
                              },
                            ),
                            actions: [
                              TextButton(
                                child: const Text('Sair'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(0, 31, 27, 27),
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
