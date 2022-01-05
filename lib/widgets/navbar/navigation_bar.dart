import 'package:flutter/material.dart';
import 'package:app/routes/routes.dart';
import 'package:app/widgets/navbar/navigation_item.dart';

class NavigationBarWeb extends StatefulWidget {
  const NavigationBarWeb({Key? key}) : super(key: key);

  @override
  State<NavigationBarWeb> createState() => _NavigationBarWebState();
}

class _NavigationBarWebState extends State<NavigationBarWeb> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: Padding(
        padding: const EdgeInsets.only(right: 200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: const [
            NavigationItem(
              title: 'Marcar uma refeição',
              routeName: routeBooking,
              icon: Icon(Icons.add_outlined),
            ),
            NavigationItem(
              title: 'Conta',
              routeName: routeAccount,
              icon: Icon(Icons.account_box_outlined),
            ),
            NavigationItem(
              title: 'Marcações',
              routeName: routeListBooking,
              icon: Icon(Icons.list),
            ),
          ],
        ),
      ),
    );
  }
}
