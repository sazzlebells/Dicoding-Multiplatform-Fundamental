import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/utils/enums.dart';
import 'package:restaurant_api/provider/restaurant_provider.dart';
import 'package:restaurant_api/widgets/card_list.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantProvider>(builder: (context, state, _) {
      var _state = state.state;
      var data = state.result!.restaurants;
      if (_state == ResultState.Loading) {
        return const Center(child: CircularProgressIndicator());
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
        return const Center(child: Text(""));
      }
    });
  }
}
