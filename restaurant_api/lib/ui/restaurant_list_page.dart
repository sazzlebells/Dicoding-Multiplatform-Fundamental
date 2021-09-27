import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/common/enums.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:restaurant_api/data/model/restaurant.dart';
import 'package:restaurant_api/provider/restaurant_provider.dart';
import 'package:restaurant_api/widgets/card_list.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({Key? key}) : super(key: key);
  static Future<RestaurantResult>? _restaurant = ApiService().restaurantName();

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantProvider>(builder: (context, state, _) {
      var _state = state.state;
      var data = state.result.restaurants;
      if (_state == ResultState.Loading) {
        return Center(child: CircularProgressIndicator());
      } else if (_state == ResultState.HasData) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: data!.length,
            itemBuilder: (context, i) {
              var resto = data[i];
              return CardRestaurant(restaurant: resto);
            });
      } else if (_state == ResultState.Error) {
        return Center(child: Text(state.message));
      } else {
        return Center(child: Text(""));
      }
    });
  }
}
