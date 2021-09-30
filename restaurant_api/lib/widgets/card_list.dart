import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/common/style.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:restaurant_api/data/model/restaurant.dart';
import 'package:restaurant_api/provider/database_provider.dart';
import 'package:restaurant_api/ui/detail_page.dart';

class CardRestaurant extends StatelessWidget {
  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);
  final Restaurant? restaurant;
  static ApiService _service = ApiService();

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
            future: provider.isFavorited(restaurant!.id!),
            builder: (context, snapshot) {
              var isFavorited = snapshot.data ?? false;
              return Card(
                child: ListTile(
                  tileColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  leading: _leading(),
                  title: Text(restaurant!.name.toString(),
                      style: myTextTheme.headline6),
                  subtitle: _subtitle(),
                  onTap: () => Navigator.pushNamed(
                    context,
                    DetailPage.routeName,
                    arguments: restaurant,
                  ),
                  trailing: isFavorited
                      ? IconButton(
                          icon: Icon(Icons.favorite),
                          color: Theme.of(context).accentColor,
                          onPressed: () =>
                              provider.removeFavorite(restaurant!.id!),
                        )
                      : IconButton(
                          icon: Icon(Icons.favorite_border),
                          color: Theme.of(context).accentColor,
                          onPressed: () => provider.addFavorite(restaurant!),
                        ),
                ),
              );
            });
      },
    );
  }

  Hero _leading() {
    return Hero(
      tag: restaurant!.pictureId.toString(),
      child: Image.network(
        "${_service.getPicture}${restaurant!.pictureId}",
        fit: BoxFit.cover,
        width: 100,
      ),
    );
  }

  Column _subtitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: [
            const Icon(Icons.location_on, size: 20, color: Colors.red),
            Text(
              restaurant!.city.toString(),
              style: myTextTheme.bodyText1,
            ),
          ],
        ),
        Wrap(
          children: [
            const Icon(Icons.star, size: 20, color: Colors.yellow),
            Text(
              restaurant!.rating.toString(),
              style: myTextTheme.bodyText1,
            ),
          ],
        ),
      ],
    );
  }
}
