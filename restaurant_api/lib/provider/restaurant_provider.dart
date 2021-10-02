import 'package:flutter/material.dart';
import 'package:restaurant_api/utils/enums.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:restaurant_api/data/model/restaurant.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService service;

  RestaurantProvider({
    required this.service,
  }) {
    _fetchAllRestaurant();
  }

  RestaurantResult? _restaurantResult = RestaurantResult.empty();
  RestaurantResult? _tmpRestaurantResult = RestaurantResult.empty();
  String _message = "";
  ResultState? _state = ResultState.Loading;

  String get message => _message;

  RestaurantResult? get result => _restaurantResult;

  ResultState? get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await service.restaurantName();

      if (restaurant!.restaurants!.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.HasData;
        _tmpRestaurantResult = restaurant;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = "Error --> $e";
    }
  }

  Future search(String query) async {
    List<Restaurant> _data = _restaurantResult!.restaurants!;
    List<Restaurant> _queryData = [];
    if (query == '') {
      _fetchAllRestaurant();
      _state = ResultState.HasData;
      notifyListeners();

      return _restaurantResult;
    } else {
      _data.forEach((element) {
        if (element.name!.toLowerCase().contains(query)) {
          _queryData.add(element);
        }
      });
      _state = ResultState.HasData;
      _restaurantResult!.restaurants?.clear();
      _restaurantResult!.restaurants?.addAll(_queryData);
      notifyListeners();
      return _restaurantResult;
    }
  }
}
