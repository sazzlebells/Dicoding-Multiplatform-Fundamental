import 'package:flutter/material.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/data/db/database_helper.dart';
import 'package:restaurant_api/provider/database_provider.dart';
import 'package:restaurant_api/provider/restaurant_provider.dart';
import 'package:restaurant_api/ui/favorite_page.dart';
import 'package:restaurant_api/ui/restaurant_list_page.dart';
import 'package:cross_connectivity/cross_connectivity.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget appBarTitle = const Text("My Resto");
  IconData icon = Icons.search;
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    Connectivity().checkConnection().then((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityBuilder(builder: (context, isConnected, status) {
      return isConnected == true
          ? MultiProvider(
              providers: [
                  ChangeNotifierProvider(
                      create: (_) =>
                          DatabaseProvider(dbHelper: DatabaseHelper())),
                  ChangeNotifierProvider<RestaurantProvider>(
                    create: (_) => RestaurantProvider(
                        service: ApiService(), context: context),
                  ),
                ],
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
                  ),
                  IconButton(
                      icon: const Icon(Icons.favorite),
                      onPressed: () =>
                          Navigator.pushNamed(context, FavoritePage.routeName)),
                ]),
                body: const RestaurantList(),
              ))
          : const Scaffold(
              body: Center(
                child: Text("No Internet Connection"),
              ),
            );
    });
  }
}
