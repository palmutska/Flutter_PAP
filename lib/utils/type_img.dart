import 'package:flutter/material.dart';

class TypeImage extends StatefulWidget {
  String path;
  TypeImage(this.path, {Key? key}) : super(key: key);

  @override
  State<TypeImage> createState() => _TypeImageState();
}

class _TypeImageState extends State<TypeImage> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/" + widget.path + ".png",
      width: 340,
    );
  }
}
