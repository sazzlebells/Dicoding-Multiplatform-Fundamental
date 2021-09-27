import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_api/data/model/detail.dart';
import 'package:restaurant_api/data/model/restaurant.dart';

class ApiService {
  static final String _baseUrl = 'restaurant-api.dicoding.dev';
  static final String _getList = 'list';
  static final String _getDetail = 'detail/';
  static final String _search = 'search?q=query';
  static final String _addReview = 'review';
  static final String _getPicture = 'images\/medium\/';

  Future<RestaurantResult>? restaurantName() async {
    final response = await http.get(Uri.https(_baseUrl, _getList));

    if (response.statusCode == 200) {
      print(response.body);
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<RestaurantDetail>? restaurantDetail(String id) async {
    final response = await http.get(Uri.https(_baseUrl, _getDetail + id));

    if (response.statusCode == 200) {
      print(response.body);
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant\'s detail');
    }
  }

  String get getPicture => "https:\/\/" + _baseUrl + "/" + _getPicture;
}
