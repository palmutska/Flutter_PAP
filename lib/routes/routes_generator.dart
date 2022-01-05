import 'package:app/views/account_page.dart';
import 'package:app/views/booking_page.dart';
import 'package:app/views/list_booking_page.dart';
import 'package:flutter/material.dart';
import 'package:app/routes/routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeBooking:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const BookingPage(),
          transitionDuration: const Duration(milliseconds: 450),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(-1.0, 0), end: Offset.zero)
                      .animate(animation),
              child: SlideTransition(
                  position: Tween<Offset>(
                          begin: Offset.zero, end: const Offset(-1.0, 0))
                      .animate(secondaryAnimation),
                  child: child),
            );
          },
        );
      case routeAccount:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const AccountPage(),
          transitionDuration: const Duration(milliseconds: 450),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(-1.0, 0), end: Offset.zero)
                      .animate(animation),
              child: SlideTransition(
                  //corrent
                  position: Tween<Offset>(
                          begin: Offset.zero, end: const Offset(-1.0, 0))
                      .animate(secondaryAnimation),
                  child: child),
            );
          },
        );
      case routeListBooking:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ListPage(),
          transitionDuration: const Duration(milliseconds: 450),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(-1.0, 0), end: Offset.zero)
                      .animate(animation),
              child: SlideTransition(
                  position: Tween<Offset>(
                          begin: Offset.zero, end: const Offset(-1.0, 0))
                      .animate(secondaryAnimation),
                  child: child),
            );
          },
        );
    }
    return MaterialPageRoute(builder: (_) => const BookingPage());
  }
}
