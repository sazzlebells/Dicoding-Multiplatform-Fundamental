import 'package:restaurant_api/data/model/category.dart';

class Menus {
  Menus({
    this.foods,
    this.drinks,
  });

  List<Category>? foods;
  List<Category>? drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods:
            List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
        drinks: List<Category>.from(
            json["drinks"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods!.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks!.map((x) => x.toJson())),
      };

  Menus.empty()
      : drinks = List<Category>.empty(),
        foods = List<Category>.empty();
}
