import 'dart:convert';
import 'package:restaurant_api/data/model/category.dart';
import 'package:restaurant_api/data/model/customer_review.dart';
import 'package:restaurant_api/data/model/menu.dart';

RestaurantDetail restaurantDetailFromJson(String str) =>
    RestaurantDetail.fromJson(json.decode(str));

String restaurantDetailToJson(RestaurantDetail data) =>
    json.encode(data.toJson());

class RestaurantDetail {
  RestaurantDetail({
    this.error,
    this.message,
    this.restaurant,
  });

  bool? error;
  String? message;
  Detail? restaurant;

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        error: json["error"],
        message: json["message"],
        restaurant: Detail.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant!.toJson(),
      };

  RestaurantDetail.empty()
      : error = false,
        message = '',
        restaurant = Detail.empty();
}

class Detail {
  Detail({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  String? id;
  String? name;
  String? description;
  String? city;
  String? address;
  String? pictureId;
  List<Category>? categories;
  Menus? menus;
  String? rating;
  List<CustomerReview>? customerReviews;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"].toString(),
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "menus": menus!.toJson(),
        "rating": rating.toString(),
        "customerReviews":
            List<dynamic>.from(customerReviews!.map((x) => x.toJson())),
      };

  Detail.empty()
      : id = "",
        name = "",
        description = "",
        city = "",
        address = "",
        pictureId = "",
        categories = List<Category>.empty(),
        menus = Menus.empty(),
        rating = "0.0",
        customerReviews = List<CustomerReview>.empty();
}
