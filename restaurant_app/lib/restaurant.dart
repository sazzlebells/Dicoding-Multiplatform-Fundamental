import 'dart:convert';

List<Restaurant> restaurantFromJson(String str) =>
    List<Restaurant>.from(json.decode(str).map((x) => Restaurant.fromJson(x)));

String restaurantToJson(List<Restaurant> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json);
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}

class Restaurant {
  Restaurant({
    this.name,
    this.location,
    this.address,
    this.imageUrl,
    this.rating,
    this.mapUrl,
    this.phone,
    this.menus,
  });

  String? name;
  String? location;
  String? address;
  String? imageUrl;
  String? rating;
  String? mapUrl;
  String? phone;
  List<Menu>? menus;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        name: json["name"],
        location: json["location"],
        address: json["address"],
        imageUrl: json["imageUrl"],
        rating: json["rating"],
        mapUrl: json["mapUrl"],
        phone: json["phone"],
        menus: List<Menu>.from(json["menus"].map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "location": location,
        "address": address,
        "imageUrl": imageUrl,
        "rating": rating,
        "mapUrl": mapUrl,
        "phone": phone,
        "menus": List<dynamic>.from(menus!.map((x) => x.toJson())),
      };
}

class Menu {
  Menu({
    this.menu,
    this.price,
    this.imageUrl,
  });

  String? menu;
  String? price;
  String? imageUrl;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        menu: json["menu"],
        price: json["price"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "menu": menu,
        "price": price,
        "imageUrl": imageUrl,
      };
}
