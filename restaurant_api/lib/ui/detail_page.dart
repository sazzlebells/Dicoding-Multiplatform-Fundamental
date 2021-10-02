import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/common/color.dart';
import 'package:restaurant_api/provider/database_provider.dart';
import 'package:restaurant_api/utils/enums.dart';
import 'package:restaurant_api/common/style.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:restaurant_api/data/model/category.dart';
import 'package:restaurant_api/data/model/detail.dart';
import 'package:restaurant_api/data/model/restaurant.dart';
import 'package:restaurant_api/provider/detail_provider.dart';
import 'package:restaurant_api/ui/review_section.dart';
import 'package:restaurant_api/ui/table.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.restaurant}) : super(key: key);
  static const routeName = "/detail";
  static ApiService _service = ApiService();
  final Restaurant? restaurant;
  static bool? isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${restaurant!.name}")),
      body: ChangeNotifierProvider<DetailProvider>(
        create: (_) => DetailProvider(
          service: ApiService(),
          id: restaurant!.id.toString(),
          context: context,
        ),
        child: Consumer<DetailProvider>(
          builder: (context, state, _) {
            var _state = state.state;
            var data = state.result!.restaurant;

            if (_state == ResultState.Loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (_state == ResultState.HasData) {
              return _body(context, data);
            } else if (_state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text(""));
            }
          },
        ),
      ),
    );
  }

  SingleChildScrollView _body(BuildContext context, Detail? data) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Hero(
                tag: data!.pictureId.toString(),
                child: Image.network(_service.getPicture + "${data.pictureId}"),
              ),
              Positioned(
                  right: 25,
                  top: 25,
                  child: Consumer<DatabaseProvider>(
                      builder: (context, provider, child) {
                    return FutureBuilder<bool>(
                        future: provider.isFavorited(data.id!),
                        builder: (context, snapshot) {
                          var isFav = snapshot.data ?? false;
                          return FloatingActionButton(
                            onPressed: () {
                              Restaurant r = Restaurant(
                                name: data.name,
                                city: data.city,
                                description: data.description,
                                id: data.id,
                                pictureId: data.pictureId,
                              );
                              isFav
                                  ? provider.removeFavorite(data.id!)
                                  : provider.addFavorite(r);
                            },
                            child: isFav
                                ? Icon(Icons.favorite, color: Colors.red[300])
                                : const Icon(Icons.favorite_border,
                                    color: Colors.white),
                          );
                        });
                  })),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location: ${data.city}',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Rating: ${data.rating}',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Categories: ", style: myTextTheme.subtitle2),
                        Wrap(spacing: 5, children: _chips(data.categories)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text("Description", style: myTextTheme.headline5),
                const Divider(color: Colors.grey),
                Text(
                  data.description ?? "",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 15),
                Text("Menu", style: myTextTheme.headline5),
                const Divider(color: Colors.grey),
                MenuSection(menu: data.menus),
                const SizedBox(height: 15),
                const SizedBox(height: 15),
                Text("Reviews (${data.customerReviews!.length})",
                    style: myTextTheme.headline5),
                const Divider(color: Colors.grey),
              ],
            ),
          ),
          ReviewSection(review: data),
        ],
      ),
    );
  }

  List<Widget> _chips(List<Category>? cat) {
    List<Widget> chip = [];
    for (var i = 0; i < cat!.length; i++) {
      chip.add(Chip(
        label: Text(cat[i].name.toString()),
        labelStyle: myTextTheme.overline,
      ));
    }
    return chip;
  }
}
