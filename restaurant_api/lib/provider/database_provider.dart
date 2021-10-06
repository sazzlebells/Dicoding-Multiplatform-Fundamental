import 'package:flutter/cupertino.dart';
import 'package:restaurant_api/utils/enums.dart';
import 'package:restaurant_api/data/db/database_helper.dart';
import 'package:restaurant_api/data/model/restaurant.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper dbHelper;

  DatabaseProvider({required this.dbHelper}) {
    _getFavorites();
  }

  late ResultState _state = ResultState.NoData;
  ResultState get state => _state;

  String _message = "Empty Data";
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await dbHelper.getFavorites();
    if (_favorites.isNotEmpty) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = "Empty Data";
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await dbHelper.addFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = "Error: $e";
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favRestaurant = await dbHelper.getFavoriteById(id);
    return favRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await dbHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = "Error: $e";
      notifyListeners();
    }
  }
}
