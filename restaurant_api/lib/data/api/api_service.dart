import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_api/data/model/detail.dart';
import 'package:restaurant_api/data/model/restaurant.dart';

class ApiService {
  static const String _baseUrl = 'restaurant-api.dicoding.dev';
  static const String _getList = 'list';
  static const String _getDetail = 'detail/';
  static const String _search = 'search?q=query';
  static const String _addReview = 'review';
  static const String _getPicture = 'images\/medium\/';

  Future<RestaurantResult>? restaurantName(BuildContext context) async {
    final response = await http.get(Uri.https(_baseUrl, _getList));

    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<RestaurantDetail>? restaurantDetail(
      String id, BuildContext context) async {
    final response = await http.get(Uri.https(_baseUrl, _getDetail + id));

    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant\'s detail');
    }
  }

  String get getPicture => "https:\/\/" + _baseUrl + "/" + _getPicture;
}
