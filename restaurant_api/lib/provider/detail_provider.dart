import 'package:flutter/material.dart';
import 'package:restaurant_api/utils/enums.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:restaurant_api/data/model/detail.dart';

class DetailProvider extends ChangeNotifier {
  final ApiService service;
  final String id;
  final BuildContext context;

  DetailProvider(
      {required this.service, required this.id, required this.context}) {
    _fetchAllDetail(id);
  }

  RestaurantDetail? _restaurantDetail = RestaurantDetail.empty();
  String _message = "";
  ResultState? _state = ResultState.Loading;

  String get message => _message;

  RestaurantDetail? get result => _restaurantDetail;

  ResultState? get state => _state;

  Future<dynamic> _fetchAllDetail(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final detail = await service.restaurantDetail(id);
      if (detail!.restaurant!.name == "") {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantDetail = detail;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = "Error --> $e";
    }
  }
}
