import 'package:flutter/material.dart';
import 'package:restaurant_api/utils/enums.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:restaurant_api/data/model/restaurant.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService service;

  RestaurantProvider({
    required this.service,
  }) {
    fetchAllRestaurant();
  }

  RestaurantResult? _restaurantResult = RestaurantResult.empty();
  RestaurantResult? get result => _restaurantResult;
  RestaurantResult? _tmpRestaurantResult = RestaurantResult.empty();

  String _message = "";
  String get message => _message;

  String _query = '';
  String get query => _query;

  ResultState? _state = ResultState.Loading;
  ResultState? get state => _state;

  Future<dynamic> fetchAllRestaurant() async {
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

  Future<dynamic> searchRestaurants(String query) async {
    try {
      _state = ResultState.Loading;
      _query = query;
      notifyListeners();
      final result = await service.search(query);
      if (result!.restaurants!.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Not found';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = result;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
