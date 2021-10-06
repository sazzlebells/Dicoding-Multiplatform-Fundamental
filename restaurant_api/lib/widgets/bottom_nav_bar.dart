import 'package:flutter/material.dart';
import 'package:restaurant_api/ui/home_page.dart';
import 'package:restaurant_api/ui/settings_page.dart';
import 'package:restaurant_api/utils/enums.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key, this.selectedMenu}) : super(key: key);
  final MenuState? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
      currentIndex: selectedMenu == MenuState.home ? 0 : 1,
      onTap: (value) {
        value == 0
            ? Navigator.pushReplacementNamed(context, HomePage.routeName)
            : Navigator.pushReplacementNamed(context, SettingsPage.routeName);
      },
    );
  }
}
