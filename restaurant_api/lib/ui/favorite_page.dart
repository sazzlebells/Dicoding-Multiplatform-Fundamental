import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/provider/database_provider.dart';
import 'package:restaurant_api/utils/enums.dart';
import 'package:restaurant_api/widgets/card_list.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);
  static const routeName = "/favorite";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.HasData) {
            return ListView.builder(
                itemCount: provider.favorites.length,
                itemBuilder: (context, i) {
                  return CardRestaurant(restaurant: provider.favorites[i]);
                });
          } else {
            return Center(child: Text(provider.message));
          }
        },
      ),
    );
  }
}
