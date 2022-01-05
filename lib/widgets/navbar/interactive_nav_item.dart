import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class InteractiveNavItem extends MouseRegion {
  static final appContainer =
      html.window.document.querySelectorAll('flt-glass-pane')[0];

  InteractiveNavItem(
      {Key? key,
      required Widget child,
      required String text,
      required Icon icon})
      : super(
          key: key,
          onHover: (PointerHoverEvent evt) {
            appContainer.style.cursor = 'pointer';
          },
          onExit: (PointerExitEvent evt) {
            appContainer.style.cursor = 'default';
          },
          child: InteractiveText(
            text: text,
            icon: icon,
          ),
        );
}

class InteractiveText extends StatefulWidget {
  final String text;
  final Icon icon;

  const InteractiveText({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  InteractiveTextState createState() => InteractiveTextState();
}

class InteractiveTextState extends State<InteractiveText> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) => _hovered(true),
      onExit: (_) => _hovered(false),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: widget.icon,
          ),
          Text(
            widget.text,
            style: _hovering
                ? const TextStyle(fontSize: 20).copyWith(color: Colors.indigo)
                : const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  _hovered(bool hovered) {
    setState(() {
      _hovering = hovered;
    });
  }
}
