import 'package:flutter/material.dart';
import 'package:restaurant_api/data/model/restaurant.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(String routeName, Restaurant? arguments) {
    print(arguments!.name);
    navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  static back() => navigatorKey.currentState!.pop();
}
