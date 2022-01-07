import 'package:app/models/user.dart';
import 'package:flutter/material.dart';

class TypeImage extends StatefulWidget {
  User user;
  TypeImage(this.user, {Key? key}) : super(key: key);
  @override
  State<TypeImage> createState() => _TypeImageState();
}

class _TypeImageState extends State<TypeImage> {
  @override
  Widget build(BuildContext context) {
    String path;
    switch (widget.user.type) {
      case "Aluno":
        path = "aluno.png";
        break;
      case "Professor":
        path = "professor.png";
        break;
      case "Militar":
        path = "militar.png";
        break;
      case "Funcionário":
        path = "funcionario.png";
        break;
      default:
        path = "missingUser.png";
    }
    return Image.asset(
      "assets/images/" + path,
      width: 340,
    );
  }
}
