import 'package:flutter/material.dart';
import 'package:restaurant_api/data/model/category.dart';
import 'package:restaurant_api/data/model/menu.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({Key? key, required this.menu}) : super(key: key);
  final Menus? menu;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(children: [
          const Text("Foods", textAlign: TextAlign.center),
          Text(_menus(menu!.foods), textAlign: TextAlign.center),
        ]),
        TableRow(children: [
          const Text("Drinks", textAlign: TextAlign.center),
          Text(_menus(menu!.drinks), textAlign: TextAlign.center),
        ]),
      ],
    );
  }

  String _menus(List<Category>? cat) {
    String _menu = "";
    for (var i = 0; i < cat!.length; i++) {
      _menu = _menu + "\n${cat[i].name}";
    }

    return _menu + "\n";
  }
}
