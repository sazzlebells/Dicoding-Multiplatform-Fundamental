import 'package:flutter/material.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/data/model/restaurant.dart';
import 'package:restaurant_api/provider/restaurant_provider.dart';
import 'package:restaurant_api/ui/restaurant_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget appBarTitle = Text("My Resto");
  IconData icon = Icons.search;
  TextEditingController controller = new TextEditingController();
  bool? _isSearching;
  String? _searchText = "";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
        create: (_) => RestaurantProvider(service: ApiService()),
        child: Scaffold(
          appBar: AppBar(title: appBarTitle, actions: [
            Consumer<RestaurantProvider>(
              builder: (c, s, _) {
                return IconButton(
                  icon: Icon(icon),
                  onPressed: () {
                    setState(() {
                      if (icon == Icons.search) {
                        icon = Icons.search;
                        appBarTitle = TextField(
                          // controller = controller,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: "Search...",
                          ),
                          onChanged: (value) {
                            s.search(value);
                            setState(() {
                              controller.text = value;
                            });
                          },
                        );
                      }
                    });
                  },
                );
              },
            )
          ]),
          body: const RestaurantList(),
        ));
  }
}
