import 'package:flutter/material.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:restaurant_api/data/model/restaurant.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.restaurant}) : super(key: key);
  static const routeName = "/detail";
  static ApiService _service = ApiService();
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${restaurant.name}")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: restaurant.pictureId.toString(),
              child: Image.network(
                  _service.getPicture + "${restaurant.pictureId}"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location: ${restaurant.city}',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Rating: ${restaurant.rating}',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Divider(color: Colors.grey),
                  Text(
                    restaurant.description ?? "",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
